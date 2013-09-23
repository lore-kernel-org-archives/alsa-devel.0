From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 1/5] ASoC: Docs: Update codec documentation
Date: Mon, 23 Sep 2013 12:13:58 +0100
Message-ID: <1379934842-4489-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 484B2260845
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 13:14:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Update the codec class driver documentation and bring it up to date
with the current code base. This includes API changes, regmap and
multi component.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 Documentation/sound/alsa/soc/codec.txt | 46 +++++++++++-----------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/Documentation/sound/alsa/soc/codec.txt b/Documentation/sound/alsa/soc/codec.txt
index bce23a4..db5f9c9 100644
--- a/Documentation/sound/alsa/soc/codec.txt
+++ b/Documentation/sound/alsa/soc/codec.txt
@@ -1,22 +1,23 @@
-ASoC Codec Driver
-=================
+ASoC Codec Class Driver
+=======================
 
-The codec driver is generic and hardware independent code that configures the
-codec to provide audio capture and playback. It should contain no code that is
-specific to the target platform or machine. All platform and machine specific
-code should be added to the platform and machine drivers respectively.
+The codec class driver is generic and hardware independent code that configures
+the codec, FM, MODEM, BT or external DSP to provide audio capture and playback.
+It should contain no code that is specific to the target platform or machine.
+All platform and machine specific code should be added to the platform and
+machine drivers respectively.
 
-Each codec driver *must* provide the following features:-
+Each codec class driver *must* provide the following features:-
 
  1) Codec DAI and PCM configuration
- 2) Codec control IO - using I2C, 3 Wire(SPI) or both APIs
+ 2) Codec control IO - using RegMap API
  3) Mixers and audio controls
  4) Codec audio operations
+ 5) DAPM description.
+ 6) DAPM event handler.
 
 Optionally, codec drivers can also provide:-
 
- 5) DAPM description.
- 6) DAPM event handler.
  7) DAC Digital mute control.
 
 Its probably best to use this guide in conjunction with the existing codec
@@ -64,26 +65,9 @@ struct snd_soc_dai_driver wm8731_dai = {
 2 - Codec control IO
 --------------------
 The codec can usually be controlled via an I2C or SPI style interface
-(AC97 combines control with data in the DAI). The codec drivers provide
-functions to read and write the codec registers along with supplying a
-register cache:-
-
-	/* IO control data and register cache */
-	void *control_data; /* codec control (i2c/3wire) data */
-	void *reg_cache;
-
-Codec read/write should do any data formatting and call the hardware
-read write below to perform the IO. These functions are called by the
-core and ALSA when performing DAPM or changing the mixer:-
-
-    unsigned int (*read)(struct snd_soc_codec *, unsigned int);
-    int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
-
-Codec hardware IO functions - usually points to either the I2C, SPI or AC97
-read/write:-
-
-	hw_write_t hw_write;
-	hw_read_t hw_read;
+(AC97 combines control with data in the DAI). The codec driver should use the
+Regmap API for all codec IO. Please see include/linux/regmap.h and existing
+codec drivers for example regmap usage.
 
 
 3 - Mixers and audio controls
@@ -127,7 +111,7 @@ Defines a stereo enumerated control
 
 4 - Codec Audio Operations
 --------------------------
-The codec driver also supports the following ALSA operations:-
+The codec driver also supports the following ALSA PCM operations:-
 
 /* SoC audio ops */
 struct snd_soc_ops {
-- 
1.8.1.2
