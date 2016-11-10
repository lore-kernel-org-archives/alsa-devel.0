From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ASoC: doc: ReSTize codec.txt
Date: Thu, 10 Nov 2016 22:47:14 +0100
Message-ID: <20161110214722.14698-3-tiwai@suse.de>
References: <20161110214722.14698-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF7A266942
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:47:26 +0100 (CET)
In-Reply-To: <20161110214722.14698-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

A simple conversion from a plain text file.
The section numbers are dropped to align with other documents.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../sound/{alsa/soc/codec.txt => soc/codec.rst}    | 75 +++++++++++++---------
 Documentation/sound/soc/index.rst                  |  1 +
 2 files changed, 44 insertions(+), 32 deletions(-)
 rename Documentation/sound/{alsa/soc/codec.txt => soc/codec.rst} (84%)

diff --git a/Documentation/sound/alsa/soc/codec.txt b/Documentation/sound/soc/codec.rst
similarity index 84%
rename from Documentation/sound/alsa/soc/codec.txt
rename to Documentation/sound/soc/codec.rst
index db5f9c9ae149..f87612b94812 100644
--- a/Documentation/sound/alsa/soc/codec.txt
+++ b/Documentation/sound/soc/codec.rst
@@ -1,3 +1,4 @@
+=======================
 ASoC Codec Class Driver
 =======================
 
@@ -9,16 +10,16 @@ machine drivers respectively.
 
 Each codec class driver *must* provide the following features:-
 
- 1) Codec DAI and PCM configuration
- 2) Codec control IO - using RegMap API
- 3) Mixers and audio controls
- 4) Codec audio operations
- 5) DAPM description.
- 6) DAPM event handler.
+1. Codec DAI and PCM configuration
+2. Codec control IO - using RegMap API
+3. Mixers and audio controls
+4. Codec audio operations
+5. DAPM description.
+6. DAPM event handler.
 
 Optionally, codec drivers can also provide:-
 
- 7) DAC Digital mute control.
+7. DAC Digital mute control.
 
 Its probably best to use this guide in conjunction with the existing codec
 driver code in sound/soc/codecs/
@@ -26,24 +27,25 @@ driver code in sound/soc/codecs/
 ASoC Codec driver breakdown
 ===========================
 
-1 - Codec DAI and PCM configuration
------------------------------------
+Codec DAI and PCM configuration
+-------------------------------
 Each codec driver must have a struct snd_soc_dai_driver to define its DAI and
 PCM capabilities and operations. This struct is exported so that it can be
 registered with the core by your machine driver.
 
 e.g.
+::
 
-static struct snd_soc_dai_ops wm8731_dai_ops = {
+  static struct snd_soc_dai_ops wm8731_dai_ops = {
 	.prepare	= wm8731_pcm_prepare,
 	.hw_params	= wm8731_hw_params,
 	.shutdown	= wm8731_shutdown,
 	.digital_mute	= wm8731_mute,
 	.set_sysclk	= wm8731_set_dai_sysclk,
 	.set_fmt	= wm8731_set_dai_fmt,
-};
-
-struct snd_soc_dai_driver wm8731_dai = {
+  };
+  
+  struct snd_soc_dai_driver wm8731_dai = {
 	.name = "wm8731-hifi",
 	.playback = {
 		.stream_name = "Playback",
@@ -59,25 +61,27 @@ struct snd_soc_dai_driver wm8731_dai = {
 		.formats = WM8731_FORMATS,},
 	.ops = &wm8731_dai_ops,
 	.symmetric_rates = 1,
-};
+  };
 
 
-2 - Codec control IO
---------------------
+Codec control IO
+----------------
 The codec can usually be controlled via an I2C or SPI style interface
 (AC97 combines control with data in the DAI). The codec driver should use the
 Regmap API for all codec IO. Please see include/linux/regmap.h and existing
 codec drivers for example regmap usage.
 
 
-3 - Mixers and audio controls
------------------------------
+Mixers and audio controls
+-------------------------
 All the codec mixers and audio controls can be defined using the convenience
 macros defined in soc.h.
+::
 
     #define SOC_SINGLE(xname, reg, shift, mask, invert)
 
 Defines a single control as follows:-
+::
 
   xname = Control name e.g. "Playback Volume"
   reg = codec register
@@ -86,18 +90,22 @@ Defines a single control as follows:-
   invert = the control is inverted
 
 Other macros include:-
+::
 
     #define SOC_DOUBLE(xname, reg, shift_left, shift_right, mask, invert)
 
 A stereo control
+::
 
     #define SOC_DOUBLE_R(xname, reg_left, reg_right, shift, mask, invert)
 
 A stereo control spanning 2 registers
+::
 
     #define SOC_ENUM_SINGLE(xreg, xshift, xmask, xtexts)
 
 Defines an single enumerated control as follows:-
+::
 
    xreg = register
    xshift = control bit(s) offset in register
@@ -109,25 +117,26 @@ Defines an single enumerated control as follows:-
 Defines a stereo enumerated control
 
 
-4 - Codec Audio Operations
---------------------------
+Codec Audio Operations
+----------------------
 The codec driver also supports the following ALSA PCM operations:-
+::
 
-/* SoC audio ops */
-struct snd_soc_ops {
+  /* SoC audio ops */
+  struct snd_soc_ops {
 	int (*startup)(struct snd_pcm_substream *);
 	void (*shutdown)(struct snd_pcm_substream *);
 	int (*hw_params)(struct snd_pcm_substream *, struct snd_pcm_hw_params *);
 	int (*hw_free)(struct snd_pcm_substream *);
 	int (*prepare)(struct snd_pcm_substream *);
-};
+  };
 
 Please refer to the ALSA driver PCM documentation for details.
 http://www.alsa-project.org/~iwai/writing-an-alsa-driver/
 
 
-5 - DAPM description.
----------------------
+DAPM description
+----------------
 The Dynamic Audio Power Management description describes the codec power
 components and their relationships and registers to the ASoC core.
 Please read dapm.txt for details of building the description.
@@ -135,13 +144,14 @@ Please read dapm.txt for details of building the description.
 Please also see the examples in other codec drivers.
 
 
-6 - DAPM event handler
-----------------------
+DAPM event handler
+------------------
 This function is a callback that handles codec domain PM calls and system
 domain PM calls (e.g. suspend and resume). It is used to put the codec
 to sleep when not in use.
 
 Power states:-
+::
 
 	SNDRV_CTL_POWER_D0: /* full On */
 	/* vref/mid, clk and osc on, active */
@@ -155,8 +165,8 @@ Power states:-
 	SNDRV_CTL_POWER_D3cold: /* Everything Off, without power */
 
 
-7 - Codec DAC digital mute control
-----------------------------------
+Codec DAC digital mute control
+------------------------------
 Most codecs have a digital mute before the DACs that can be used to
 minimise any system noise.  The mute stops any digital data from
 entering the DAC.
@@ -165,9 +175,10 @@ A callback can be created that is called by the core for each codec DAI
 when the mute is applied or freed.
 
 i.e.
+::
 
-static int wm8974_mute(struct snd_soc_dai *dai, int mute)
-{
+  static int wm8974_mute(struct snd_soc_dai *dai, int mute)
+  {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = snd_soc_read(codec, WM8974_DAC) & 0xffbf;
 
@@ -176,4 +187,4 @@ static int wm8974_mute(struct snd_soc_dai *dai, int mute)
 	else
 		snd_soc_write(codec, WM8974_DAC, mute_reg);
 	return 0;
-}
+  }
diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index e974fd9f38a3..a2e023c91df2 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -8,3 +8,4 @@ The documentation is spilt into the following sections:-
    :maxdepth: 2
 
    overview
+   codec
-- 
2.10.2
