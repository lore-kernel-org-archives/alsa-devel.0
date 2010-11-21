From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/4] ASoC: Do not include soc-dapm.h
Date: Sun, 21 Nov 2010 19:48:45 +0200
Message-ID: <1290361727-25162-2-git-send-email-jhnikula@gmail.com>
References: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0044B10382F
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 18:48:57 +0100 (CET)
Received: by eyg24 with SMTP id 24so3507424eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 09:48:57 -0800 (PST)
In-Reply-To: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

There is no need to include soc-dapm.h since soc.h includes it.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/atmel/playpaq_wm8510.c               |    1 -
 sound/soc/atmel/sam9g20_wm8731.c               |    1 -
 sound/soc/atmel/snd-soc-afeb9260.c             |    1 -
 sound/soc/au1x/db1200.c                        |    1 -
 sound/soc/blackfin/bf5xx-ad1836.c              |    1 -
 sound/soc/blackfin/bf5xx-ad193x.c              |    1 -
 sound/soc/blackfin/bf5xx-ad73311.c             |    1 -
 sound/soc/blackfin/bf5xx-ssm2602.c             |    1 -
 sound/soc/codecs/88pm860x-codec.c              |    1 -
 sound/soc/codecs/ad1836.c                      |    1 -
 sound/soc/codecs/ad193x.c                      |    1 -
 sound/soc/codecs/ad1980.c                      |    1 -
 sound/soc/codecs/ak4535.c                      |    1 -
 sound/soc/codecs/ak4671.c                      |    1 -
 sound/soc/codecs/alc5623.c                     |    1 -
 sound/soc/codecs/cq93vc.c                      |    1 -
 sound/soc/codecs/cs42l51.c                     |    1 -
 sound/soc/codecs/max98088.c                    |    1 -
 sound/soc/codecs/ssm2602.c                     |    1 -
 sound/soc/codecs/stac9766.c                    |    1 -
 sound/soc/codecs/tlv320aic23.c                 |    1 -
 sound/soc/codecs/tlv320aic26.c                 |    1 -
 sound/soc/codecs/tlv320aic3x.c                 |    1 -
 sound/soc/codecs/tlv320dac33.c                 |    1 -
 sound/soc/codecs/tpa6130a2.c                   |    1 -
 sound/soc/codecs/twl4030.c                     |    1 -
 sound/soc/codecs/twl6040.c                     |    1 -
 sound/soc/codecs/uda134x.c                     |    1 -
 sound/soc/codecs/uda1380.c                     |    1 -
 sound/soc/codecs/wl1273.c                      |    1 -
 sound/soc/codecs/wm2000.c                      |    1 -
 sound/soc/codecs/wm8350.c                      |    1 -
 sound/soc/codecs/wm8400.c                      |    1 -
 sound/soc/codecs/wm8510.c                      |    1 -
 sound/soc/codecs/wm8523.c                      |    1 -
 sound/soc/codecs/wm8580.c                      |    1 -
 sound/soc/codecs/wm8711.c                      |    1 -
 sound/soc/codecs/wm8728.c                      |    1 -
 sound/soc/codecs/wm8731.c                      |    1 -
 sound/soc/codecs/wm8741.c                      |    1 -
 sound/soc/codecs/wm8750.c                      |    1 -
 sound/soc/codecs/wm8753.c                      |    1 -
 sound/soc/codecs/wm8770.c                      |    1 -
 sound/soc/codecs/wm8776.c                      |    1 -
 sound/soc/codecs/wm8804.c                      |    1 -
 sound/soc/codecs/wm8900.c                      |    1 -
 sound/soc/codecs/wm8903.c                      |    1 -
 sound/soc/codecs/wm8904.c                      |    1 -
 sound/soc/codecs/wm8940.c                      |    1 -
 sound/soc/codecs/wm8955.c                      |    1 -
 sound/soc/codecs/wm8960.c                      |    1 -
 sound/soc/codecs/wm8961.c                      |    1 -
 sound/soc/codecs/wm8962.c                      |    1 -
 sound/soc/codecs/wm8971.c                      |    1 -
 sound/soc/codecs/wm8974.c                      |    1 -
 sound/soc/codecs/wm8978.c                      |    1 -
 sound/soc/codecs/wm8985.c                      |    1 -
 sound/soc/codecs/wm8988.c                      |    1 -
 sound/soc/codecs/wm8990.c                      |    1 -
 sound/soc/codecs/wm8993.c                      |    1 -
 sound/soc/codecs/wm8994.c                      |    1 -
 sound/soc/codecs/wm9081.c                      |    1 -
 sound/soc/codecs/wm9090.c                      |    1 -
 sound/soc/codecs/wm9705.c                      |    1 -
 sound/soc/codecs/wm9712.c                      |    1 -
 sound/soc/codecs/wm9713.c                      |    1 -
 sound/soc/codecs/wm_hubs.c                     |    1 -
 sound/soc/davinci/davinci-evm.c                |    1 -
 sound/soc/davinci/davinci-sffsdr.c             |    1 -
 sound/soc/ep93xx/snappercl15.c                 |    1 -
 sound/soc/imx/eukrea-tlv320.c                  |    1 -
 sound/soc/imx/phycore-ac97.c                   |    1 -
 sound/soc/imx/wm1133-ev1.c                     |    1 -
 sound/soc/jz4740/jz4740-i2s.c                  |    1 -
 sound/soc/jz4740/qi_lb60.c                     |    1 -
 sound/soc/kirkwood/kirkwood-t5325.c            |    1 -
 sound/soc/nuc900/nuc900-audio.c                |    1 -
 sound/soc/omap/am3517evm.c                     |    1 -
 sound/soc/omap/igep0020.c                      |    1 -
 sound/soc/omap/n810.c                          |    1 -
 sound/soc/omap/omap2evm.c                      |    1 -
 sound/soc/omap/omap3beagle.c                   |    1 -
 sound/soc/omap/omap3evm.c                      |    1 -
 sound/soc/omap/omap3pandora.c                  |    1 -
 sound/soc/omap/osk5912.c                       |    1 -
 sound/soc/omap/overo.c                         |    1 -
 sound/soc/omap/rx51.c                          |    1 -
 sound/soc/omap/sdp3430.c                       |    1 -
 sound/soc/omap/sdp4430.c                       |    1 -
 sound/soc/omap/zoom2.c                         |    1 -
 sound/soc/pxa/corgi.c                          |    1 -
 sound/soc/pxa/e740_wm9705.c                    |    1 -
 sound/soc/pxa/e750_wm9705.c                    |    1 -
 sound/soc/pxa/e800_wm9712.c                    |    1 -
 sound/soc/pxa/em-x270.c                        |    1 -
 sound/soc/pxa/magician.c                       |    1 -
 sound/soc/pxa/mioa701_wm9713.c                 |    1 -
 sound/soc/pxa/palm27x.c                        |    1 -
 sound/soc/pxa/poodle.c                         |    1 -
 sound/soc/pxa/raumfeld.c                       |    1 -
 sound/soc/pxa/saarb.c                          |    1 -
 sound/soc/pxa/spitz.c                          |    1 -
 sound/soc/pxa/tavorevb3.c                      |    1 -
 sound/soc/pxa/tosa.c                           |    1 -
 sound/soc/pxa/z2.c                             |    1 -
 sound/soc/pxa/zylonite.c                       |    1 -
 sound/soc/s3c24xx/aquila_wm8994.c              |    1 -
 sound/soc/s3c24xx/goni_wm8994.c                |    1 -
 sound/soc/s3c24xx/jive_wm8750.c                |    1 -
 sound/soc/s3c24xx/ln2440sbc_alc650.c           |    1 -
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |    1 -
 sound/soc/s3c24xx/neo1973_wm8753.c             |    1 -
 sound/soc/s3c24xx/rx1950_uda1380.c             |    1 -
 sound/soc/s3c24xx/s3c24xx_simtec.c             |    1 -
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |    1 -
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |    1 -
 sound/soc/s3c24xx/s3c24xx_uda134x.c            |    1 -
 sound/soc/s3c24xx/smdk2443_wm9710.c            |    1 -
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |    1 -
 sound/soc/s6000/s6105-ipcam.c                  |    1 -
 sound/soc/sh/migor.c                           |    1 -
 sound/soc/sh/sh7760-ac97.c                     |    1 -
 sound/soc/soc-core.c                           |    1 -
 sound/soc/soc-dapm.c                           |    1 -
 sound/soc/soc-jack.c                           |    1 -
 125 files changed, 0 insertions(+), 125 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index aede7e7..1aac2f4 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -33,7 +33,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <mach/at32ap700x.h>
 #include <mach/portmux.h>
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index da9c303..da37961 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -44,7 +44,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index 92c709e..1202f5e 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -30,7 +30,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index b62fcd3..cb99f04 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -13,7 +13,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 2394bff..83012da 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -20,7 +20,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/pcm_params.h>
 
 #include <asm/blackfin.h>
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index e4a6253..d3ccb92 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -29,7 +29,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/pcm_params.h>
 
 #include <asm/blackfin.h>
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 900ced5..732fb8b 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -35,7 +35,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/pcm_params.h>
 
 #include <asm/blackfin.h>
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 36f2769..e902b24 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -33,7 +33,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/pcm_params.h>
 
 #include <asm/dma.h>
diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index a15a3e9..7e4d880 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -19,7 +19,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
 #include <sound/jack.h>
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index e5d3db9..ab63d52 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -27,7 +27,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
-#include <sound/soc-dapm.h>
 #include <linux/spi/spi.h>
 #include "ad1836.h"
 
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index fd3e659..a007bd7 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -19,7 +19,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
-#include <sound/soc-dapm.h>
 #include "ad193x.h"
 
 /* codec private data */
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 410ccd5..34cb51e 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -29,7 +29,6 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "ad1980.h"
 
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 52abb93..7367545 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "ak4535.h"
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 1d6573c..4faf105 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -17,7 +17,6 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 5a45067..e84b26b 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -28,7 +28,6 @@
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/alc5623.h>
 
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 98b9e52..1a6f511 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -37,7 +37,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include <mach/dm365.h>
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index a7fdca3..d4e60dc 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 9c32237..c44b5f7 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -20,7 +20,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <linux/slab.h>
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index adbc3e8..2727bef 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -38,7 +38,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "ssm2602.h"
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 8aad3a2..7f27730 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -24,7 +24,6 @@
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
 #include "stac9766.h"
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index d9d8e84..54a30ef 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -30,7 +30,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
 
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 6b7d71e..68f0ae4 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -18,7 +18,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "tlv320aic26.h"
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index df726a5..49b797c 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -46,7 +46,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/tlv320aic3x.h>
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 7149c14..ccb267f 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -36,7 +36,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 9b98107..dfa3c65 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <sound/tpa6130a2-plat.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
 #include "tpa6130a2.h"
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f4602e8..0488d55 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -32,7 +32,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 0dd2d53..b92f2b7 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -34,7 +34,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 6b6c0d2..e76847a 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -19,7 +19,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include <sound/uda134x.h>
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index cd6dd19..800980e 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -27,7 +27,6 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/uda1380.h>
 
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 0c47c78..c606b3e 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -26,7 +26,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc-dai.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "wl1273.h"
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 9277d8d..80ddf4f 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -36,7 +36,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index d5e6e02..dc6912e 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 96927a4..3c3bc07 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -26,7 +26,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 6b3833c..db0dced 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "wm8510.h"
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index d331888..1bda09b 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 36c035b..e2a9276 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -31,7 +31,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
 #include <asm/div64.h>
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index ea2daf4..fec37eb 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -25,7 +25,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
 
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 2393997..736b035 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4b70958..a104145 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -26,7 +26,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 2543a26..35789b7 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 178b967..51280e9 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -25,7 +25,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "wm8750.h"
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 26096b4..57bf946 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -45,7 +45,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <asm/div64.h>
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 8608b4a..19b92ba 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index e09ed65..8e7953b 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -25,7 +25,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 031a0d4..6dae1b4 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 06ea9c0..cfbaac1 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -30,7 +30,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 4a6df4b..620793e 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -29,7 +29,6 @@
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/wm8903.h>
 
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 5e57bd2..da91928 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/wm8904.h>
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index caed084..381934f 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -35,7 +35,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index df1940f..6200beb 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/wm8955.h>
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 0ea5788..0bcf36e 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -20,7 +20,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/wm8960.h>
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 79b6509..a0bb972 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 9f6beca..cf4b272 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -29,7 +29,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <sound/wm8962.h>
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 84b2dcb..8805636 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -25,7 +25,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "wm8971.h"
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index d19bb14..5d28642 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index ac43b60..a195af9 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <asm/div64.h>
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index c3c8fd2..bae510a 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -26,7 +26,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 0bc2eb5..65807b1 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -25,7 +25,6 @@
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "wm8988.h"
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 309664e..5c87a63 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 #include <asm/div64.h>
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 991d90c..77b1d44 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -24,7 +24,6 @@
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/wm8993.h>
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 189f000..435508f 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -24,7 +24,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index c03e2c3..c706077 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -23,7 +23,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index b5afa01..7ba5807 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 #include <sound/wm9090.h>
 
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 58d1208..47b357a 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -19,7 +19,6 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "wm9705.h"
 
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 3ca42a3..bf5d4ef 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -20,7 +20,6 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include "wm9712.h"
 
 #define WM9712_VERSION "0.4"
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 87b236b..38ed985 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -26,7 +26,6 @@
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "wm9713.h"
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index 422c7fb..e7a19d6 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -22,7 +22,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index fd96905..24b031e 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -18,7 +18,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/dma.h>
 #include <asm/mach-types.h>
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 6c6666a..0fe558c 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -21,7 +21,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/dma.h>
 #include <asm/mach-types.h>
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index f1c7851..dfe1d7f 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -15,7 +15,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index dd4fffd..e20c9e1 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -22,7 +22,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <asm/mach-types.h>
 
 #include "../codecs/tlv320aic23.h"
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index 39f2373..db157f7 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -17,7 +17,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <asm/mach-types.h>
 
 static struct snd_soc_card imx_phycore;
diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/imx/wm1133-ev1.c
index 46fadf4..75b4c72 100644
--- a/sound/soc/imx/wm1133-ev1.c
+++ b/sound/soc/imx/wm1133-ev1.c
@@ -19,7 +19,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <mach/audmux.h>
 
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index f3cffd1..419bf4f 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -28,7 +28,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include "jz4740-i2s.h"
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 70afbfa..49723e3 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -19,7 +19,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <linux/gpio.h>
 
 #define QI_LB60_SND_GPIO JZ_GPIO_PORTB(29)
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 07b6eca..c8d2195 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <mach/kirkwood.h>
 #include <plat/audio.h>
 #include <asm/mach-types.h>
diff --git a/sound/soc/nuc900/nuc900-audio.c b/sound/soc/nuc900/nuc900-audio.c
index 161f5b6..38a2d0d 100644
--- a/sound/soc/nuc900/nuc900-audio.c
+++ b/sound/soc/nuc900/nuc900-audio.c
@@ -18,7 +18,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "nuc900-audio.h"
 
diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 668773d..1617504 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -22,7 +22,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/igep0020.c b/sound/soc/omap/igep0020.c
index fd3a40f..0ae3470 100644
--- a/sound/soc/omap/igep0020.c
+++ b/sound/soc/omap/igep0020.c
@@ -24,7 +24,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 296cd9b..fe215f3 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -27,7 +27,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/omap2evm.c b/sound/soc/omap/omap2evm.c
index cf3fc8a..29b60d6 100644
--- a/sound/soc/omap/omap2evm.c
+++ b/sound/soc/omap/omap2evm.c
@@ -26,7 +26,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index e56832b..40db813 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -24,7 +24,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/omap3evm.c b/sound/soc/omap/omap3evm.c
index 810f1e3..0daa044 100644
--- a/sound/soc/omap/omap3evm.c
+++ b/sound/soc/omap/omap3evm.c
@@ -22,7 +22,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 93e83c0..bff9864 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -28,7 +28,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <plat/mcbsp.h>
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index c2a5420..18d053d 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -26,7 +26,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/overo.c b/sound/soc/omap/overo.c
index e95a607..bbcf380 100644
--- a/sound/soc/omap/overo.c
+++ b/sound/soc/omap/overo.c
@@ -24,7 +24,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 62fc7a4..150042a 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -30,7 +30,6 @@
 #include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <plat/mcbsp.h>
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index a3dd07a..3f72d17 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -28,7 +28,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 3ce1731..ebbd62f 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -24,7 +24,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <plat/hardware.h>
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index cc5bc52..0170994 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -24,7 +24,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 85956ff..fc592f0 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -23,7 +23,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/corgi.h>
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 38a84b8..28333e7 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -16,7 +16,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <mach/audio.h>
 #include <mach/eseries-gpio.h>
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 2bc97e9..01bf316 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -16,7 +16,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <mach/audio.h>
 #include <mach/eseries-gpio.h>
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index eac846c..c6a37c6 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -16,7 +16,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/audio.h>
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index eadf9d3..fc22e6e 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -26,7 +26,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/audio.h>
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 98cb990..67dcc36 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -26,7 +26,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/uda1380.h>
 
 #include <mach/magician.h>
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index f7a1e8f..0d70fc8 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -50,7 +50,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/ac97_codec.h>
 
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 530064d..857db96 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -21,7 +21,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index f45ea40..6298ee1 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -23,7 +23,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <asm/hardware/locomo.h>
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 2cda82b..0fd60f4 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -22,7 +22,6 @@
 #include <linux/gpio.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 
diff --git a/sound/soc/pxa/saarb.c b/sound/soc/pxa/saarb.c
index ee06f99..9595189 100644
--- a/sound/soc/pxa/saarb.c
+++ b/sound/soc/pxa/saarb.c
@@ -18,7 +18,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 7e13440..c2acb69 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -23,7 +23,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/spitz.h>
diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
index 18cbe0e..f881f65 100644
--- a/sound/soc/pxa/tavorevb3.c
+++ b/sound/soc/pxa/tavorevb3.c
@@ -18,7 +18,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 7f81f82..f75804e 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -26,7 +26,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 #include <mach/tosa.h>
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index cacbcd4..2d4f896 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -21,7 +21,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/jack.h>
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index c74eac3..b222a7d 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -20,7 +20,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "../codecs/wm9713.h"
 #include "pxa2xx-ac97.h"
diff --git a/sound/soc/s3c24xx/aquila_wm8994.c b/sound/soc/s3c24xx/aquila_wm8994.c
index 33bebda..0043e62 100644
--- a/sound/soc/s3c24xx/aquila_wm8994.c
+++ b/sound/soc/s3c24xx/aquila_wm8994.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/jack.h>
 #include <asm/mach-types.h>
 #include <mach/gpio.h>
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index 052729c..bcbfe85 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -16,7 +16,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/jack.h>
 #include <asm/mach-types.h>
 #include <mach/gpio.h>
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index e3599e2..100f0f0 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -21,7 +21,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index abe64ab..dd4fad8 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -21,7 +21,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "s3c-dma.h"
 #include "s3c-ac97.h"
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index c3f63ef..64c98e5 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -22,7 +22,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <asm/mach-types.h>
 
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index e94ffe0..11e3c90 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -21,7 +21,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
 #include <asm/mach-types.h>
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index b2a741a..5dfd4db 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -25,7 +25,6 @@
 #include <linux/clk.h>
 
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/uda1380.h>
 #include <sound/jack.h>
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec.c b/sound/soc/s3c24xx/s3c24xx_simtec.c
index c4c1114..8d3bbc6 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec.c
@@ -17,7 +17,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <plat/audio-simtec.h>
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index 05c7937..044a0b2 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -14,7 +14,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <plat/audio-simtec.h>
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index 653dc75..f2f70a9 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -14,7 +14,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <plat/audio-simtec.h>
 
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index bd48ffb..4f1eeb6 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -18,7 +18,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/s3c24xx_uda134x.h>
 #include <sound/uda134x.h>
 
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 4613288..ec05df9 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -17,7 +17,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "s3c-dma.h"
 #include "s3c-ac97.h"
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 291939c..e6b461c 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -16,7 +16,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "../codecs/wm8580.h"
 #include "s3c-dma.h"
diff --git a/sound/soc/s6000/s6105-ipcam.c b/sound/soc/s6000/s6105-ipcam.c
index db1803d..2e977e4 100644
--- a/sound/soc/s6000/s6105-ipcam.c
+++ b/sound/soc/s6000/s6105-ipcam.c
@@ -18,7 +18,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include <variant/dmac.h>
 
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index c61fc18..df13338 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -20,7 +20,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 
 #include "../codecs/wm8978.h"
 #include "siu.h"
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 105d411..917d3ce 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -12,7 +12,6 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <asm/io.h>
 
 #define IPSEL 0xFE400034
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2540efd..c8d8dde 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -36,7 +36,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #define CREATE_TRACE_POINTS
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 02b6ac4..6a29d59 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -43,7 +43,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
 #include <trace/events/asoc.h>
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 619061d..0e9b071 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -13,7 +13,6 @@
 
 #include <sound/jack.h>
 #include <sound/soc.h>
-#include <sound/soc-dapm.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
-- 
1.7.0.4
