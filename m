From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] SoundScape tweaks
Date: Tue, 22 Oct 2002 23:58:54 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210222258.g9MMws6l004795@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

It really is safe to declare these parameters as __initdata because their values are never referenced again once the module loads. (All values are copied.) And there's also a whitespace fix.

Cheers,
Chris

Index: sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/sscape.c,v
retrieving revision 1.10
diff -u -u -r1.10 sscape.c
--- sscape.c	22 Oct 2002 10:45:19 -0000	1.10
+++ sscape.c	22 Oct 2002 22:55:21 -0000
@@ -52,12 +52,12 @@
 MODULE_DESCRIPTION("ENSONIQ SoundScape PnP driver");
 MODULE_LICENSE("GPL");
 
-static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
-static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
-static long port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = SNDRV_AUTO_PORT };
-static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
-static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
-static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+static int __initdata index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char* __initdata id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static long __initdata port[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = SNDRV_AUTO_PORT };
+static int __initdata irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int __initdata mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int __initdata dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 
 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(index, "Index number for SoundScape soundcard");
@@ -1418,7 +1418,7 @@
 			 */
 			if ( !is_port_known(this->port, data->params, data->cards) ) {
 				++(data->cards);
-			  ++(data->idx);
+				++(data->idx);
 				ret = 0;
 			}
 		}


-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
