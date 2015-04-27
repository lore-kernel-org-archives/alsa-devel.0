From: yang.a.fang@intel.com
Subject: [PATCH] ASoC: rt5645: fixed kbuild err
Date: Mon, 27 Apr 2015 15:54:30 -0700
Message-ID: <1430175270-54717-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 66011260815
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 00:55:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

kbuild robot reports following error/warnings

   sound/soc/codecs/rt5645.c: In function 'rt5645_i2c_probe':
>> sound/soc/codecs/rt5645.c:2720:4: error: implicit declaration of
>> function 'devm_gpiod_get_index'
>> [-Werror=implicit-function-declaration]
       gpiod = devm_gpiod_get_index(&i2c->dev, "rt5645", 0);
       ^
>> sound/soc/codecs/rt5645.c:2720:10: warning: assignment makes pointer
>> from integer without a cast
       gpiod = devm_gpiod_get_index(&i2c->dev, "rt5645", 0);
             ^
>> sound/soc/codecs/rt5645.c:2722:4: error: implicit declaration of
>> function 'gpiod_direction_input'
>> [-Werror=implicit-function-declaration]
       if (IS_ERR(gpiod) || gpiod_direction_input(gpiod)) {
       ^
>> sound/soc/codecs/rt5645.c:2726:5: error: implicit declaration of
>> function 'desc_to_gpio' [-Werror=implicit-function-declaration]
        rt5645->pdata.hp_det_gpio = desc_to_gpio(gpiod);
        ^
>> sound/soc/codecs/rt5645.c:2728:7: error: implicit declaration of
>> function 'gpiod_is_active_low'
>> [-Werror=implicit-function-declaration]
          = !gpiod_is_active_low(gpiod);
          ^
   cc1: some warnings being treated as errors

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/rt5645.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index fb561b4..2cab2eb 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <sound/core.h>
-- 
1.7.9.5
