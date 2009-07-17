From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 1/2] Add Palm support to Mainstone accelerated
	touch
Date: Fri, 17 Jul 2009 10:00:24 +0200
Message-ID: <200907171000.24408.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 401881037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 10:00:47 +0200 (CEST)
Received: by fxm26 with SMTP id 26so627941fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2009 01:00:46 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

>From f32fa9ef6476be0cf8106bc57a98724c48d4baa1 Mon Sep 17 00:00:00 2001                                
From: Marek Vasut <marek.vasut@gmail.com>                                                             
Date: Fri, 17 Jul 2009 09:54:13 +0200                                                                 
Subject: [PATCH 1/2] Add Palm support to Mainstone accelerated touch                                  

This patch refactors the Mainstone accelerated touch code a little and
adds support for interrupt driven touchscreen on Palm LifeDrive, TX and
Tungsten T5.                                                           

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---                                               
 drivers/input/touchscreen/Kconfig            |    4 +-
 drivers/input/touchscreen/mainstone-wm97xx.c |   52 +++++++++++++++++--------
 2 files changed, 37 insertions(+), 19 deletions(-)                           

diff --git a/drivers/input/touchscreen/Kconfig 
b/drivers/input/touchscreen/Kconfig
index 72e2712..0fdae1a 100644                                                     
--- a/drivers/input/touchscreen/Kconfig                                           
+++ b/drivers/input/touchscreen/Kconfig                                           
@@ -366,11 +366,11 @@ config TOUCHSCREEN_WM97XX_ATMEL                             
          be called atmel-wm97xx.                                                 
                                                                                  
 config TOUCHSCREEN_WM97XX_MAINSTONE                                              
-       tristate "WM97xx Mainstone accelerated touch"                             
+       tristate "WM97xx Mainstone/Palm accelerated touch"                        
        depends on TOUCHSCREEN_WM97XX && ARCH_PXA                                 
        help                                                                      
          Say Y here for support for streaming mode with WM97xx touchscreens      
-         on Mainstone systems.                                                   
+         on Mainstone, Palm Tungsten T5, TX and LifeDrive systems.               
                                                                                  
          If unsure, say N.                                                       
                                                                                  
diff --git a/drivers/input/touchscreen/mainstone-wm97xx.c 
b/drivers/input/touchscreen/mainstone-wm97xx.c
index 4cc047a..60bda9a 100644                                                                           
--- a/drivers/input/touchscreen/mainstone-wm97xx.c                                                      
+++ b/drivers/input/touchscreen/mainstone-wm97xx.c                                                      
@@ -31,9 +31,13 @@                                                                                      
 #include <linux/interrupt.h>                                                                           
 #include <linux/wm97xx.h>                                                                              
 #include <linux/io.h>                                                                                  
+#include <linux/gpio.h>                                                                                
+                                                                                                       
 #include <mach/regs-ac97.h>                                                                            
                                                                                                        
-#define VERSION                "0.13"                                                                  
+#include <asm/mach-types.h>                                                                            
+                                                                                                       
+#define VERSION                "0.14"                                                                  
                                                                                                        
 struct continuous {                                                                                    
        u16 id;    /* codec id */                                                                       
@@ -62,6 +66,7 @@ static const struct continuous cinfo[] = {                                            
 /* continuous speed index */                                                                           
 static int sp_idx;                                                                                     
 static u16 last, tries;                                                                                
+static int irq;                                                                                        
                                                                                                        
 /*                                                                                                     
  * Pen sampling frequency (Hz) in continuous mode.                                                     
@@ -171,7 +176,7 @@ up:                                                                                 
                                                                                                        
 static int wm97xx_acc_startup(struct wm97xx *wm)                                                       
 {                                                                                                      
-       int idx = 0;                                                                                    
+       int idx = 0, ret = 0;                                                                           
                                                                                                        
        /* check we have a codec */                                                                     
        if (wm->ac97 == NULL)                                                                           
@@ -191,18 +196,37 @@ static int wm97xx_acc_startup(struct wm97xx *wm)                                  
                 "mainstone accelerated touchscreen driver, %d samples/sec\n",                          
                 cinfo[sp_idx].speed);                                                                  
                                                                                                        
+       /* IRQ driven touchscreen is used on Palm hardware */                                           
+       if (machine_is_palmt5() || machine_is_palmtx() || machine_is_palmld()) 
{                        
+               pen_int = 1;                                                                            
+               irq = 27;                                                                               
+       } else if (machine_is_mainstone() && pen_int)                                                   
+               irq = 4;                                                                                
+                                                                                                       
+       if (irq) {                                                                                      
+               ret = gpio_request(irq, "Touchscreen IRQ");                                             
+               if (ret)                                                                                
+                       goto out;                                                                       
+                                                                                                       
+               ret = gpio_direction_input(irq);                                                        
+               if (ret) {                                                                              
+                       gpio_free(irq);                                                                 
+                       goto out;                                                                       
+               }                                                                                       
+                                                                                                       
+               wm->pen_irq = gpio_to_irq(irq);                                                         
+               set_irq_type(wm->pen_irq, IRQ_TYPE_EDGE_BOTH);                                          
+       } else  /* pen irq not supported */                                                             
+               pen_int = 0;                                                                            
+                                                                                                       
        /* codec specific irq config */                                                                 
        if (pen_int) {                                                                                  
                switch (wm->id) {                                                                       
                case WM9705_ID2:                                                                        
-                       wm->pen_irq = IRQ_GPIO(4);                                                      
-                       set_irq_type(IRQ_GPIO(4), IRQ_TYPE_EDGE_BOTH);                                  
                        break;                                                                          
                case WM9712_ID2:                                                                        
                case WM9713_ID2:                                                                        
-                       /* enable pen down interrupt */                                                 
                        /* use PEN_DOWN GPIO 13 to assert IRQ on GPIO line 2 
*/                         
-                       wm->pen_irq = MAINSTONE_AC97_IRQ;                                               
                        wm97xx_config_gpio(wm, WM97XX_GPIO_13, WM97XX_GPIO_IN,                          
                                           WM97XX_GPIO_POL_HIGH,                                        
                                           WM97XX_GPIO_STICKY,                                          
@@ -220,23 +244,17 @@ static int wm97xx_acc_startup(struct wm97xx *wm)                                  
                }                                                                                       
        }

-       return 0;
+out:
+       return ret;
 }

 static void wm97xx_acc_shutdown(struct wm97xx *wm)
 {
        /* codec specific deconfig */
        if (pen_int) {
-               switch (wm->id & 0xffff) {
-               case WM9705_ID2:
-                       wm->pen_irq = 0;
-                       break;
-               case WM9712_ID2:
-               case WM9713_ID2:
-                       /* disable interrupt */
-                       wm->pen_irq = 0;
-                       break;
-               }
+               if (irq)
+                       gpio_free(irq);
+               wm->pen_irq = 0;
        }
 }

--
1.6.3.3
