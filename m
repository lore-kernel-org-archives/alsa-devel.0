From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Clean up kerneldoc warnings
Date: Thu,  1 Jan 2009 15:32:53 +0000
Message-ID: <1230823973-6557-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090101153113.GA5966@sirena.org.uk>
	<1230823973-6557-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1230823973-6557-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1230823973-6557-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AD8032434E
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 16:33:03 +0100 (CET)
In-Reply-To: <1230823973-6557-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Almost all parameters that have been misnamed in the comments.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   46 ++++++++++++++++++++++++----------------------
 sound/soc/soc-dapm.c |   10 +++++-----
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b098c0b..f73c134 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1300,6 +1300,8 @@ EXPORT_SYMBOL_GPL(snd_soc_test_bits);
 /**
  * snd_soc_new_pcms - create new sound card and pcms
  * @socdev: the SoC audio device
+ * @idx: ALSA card index
+ * @xid: card identification
  *
  * Create a new sound card based upon the codec and interface pcms.
  *
@@ -1472,7 +1474,7 @@ EXPORT_SYMBOL_GPL(snd_soc_set_runtime_hwparams);
  * snd_soc_cnew - create new control
  * @_template: control template
  * @data: control private data
- * @lnng_name: control long name
+ * @long_name: control long name
  *
  * Create a new mixer control from a template control.
  *
@@ -1522,7 +1524,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_enum_double);
 /**
  * snd_soc_get_enum_double - enumerated double mixer get callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to get the value of a double enumerated mixer.
  *
@@ -1551,7 +1553,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_enum_double);
 /**
  * snd_soc_put_enum_double - enumerated double mixer put callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a double enumerated mixer.
  *
@@ -1668,7 +1670,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
 /**
  * snd_soc_get_volsw - single mixer get callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to get the value of a single mixer control.
  *
@@ -1707,7 +1709,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
 /**
  * snd_soc_put_volsw - single mixer put callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a single mixer control.
  *
@@ -1775,7 +1777,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r);
 /**
  * snd_soc_get_volsw_2r - double mixer get callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to get the value of a double mixer control that spans 2 registers.
  *
@@ -1812,7 +1814,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r);
 /**
  * snd_soc_put_volsw_2r - double mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a double mixer control that spans 2 registers.
  *
@@ -1882,7 +1884,7 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw_s8);
 /**
  * snd_soc_get_volsw_s8 - signed mixer get callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to get the value of a signed mixer control.
  *
@@ -1909,7 +1911,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_s8);
 /**
  * snd_soc_put_volsw_sgn - signed mixer put callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a signed mixer control.
  *
@@ -1954,7 +1956,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
 /**
  * snd_soc_dai_set_clkdiv - configure DAI clock dividers.
  * @dai: DAI
- * @clk_id: DAI specific clock divider ID
+ * @div_id: DAI specific clock divider ID
  * @div: new clock divisor.
  *
  * Configures the clock dividers. This is used to derive the best DAI bit and
@@ -2060,7 +2062,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 /**
  * snd_soc_register_card - Register a card with the ASoC core
  *
- * @param card Card to register
+ * @card: Card to register
  *
  * Note that currently this is an internal only function: it will be
  * exposed to machine drivers after further backporting of ASoC v2
@@ -2087,7 +2089,7 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 /**
  * snd_soc_unregister_card - Unregister a card with the ASoC core
  *
- * @param card Card to unregister
+ * @card: Card to unregister
  *
  * Note that currently this is an internal only function: it will be
  * exposed to machine drivers after further backporting of ASoC v2
@@ -2107,7 +2109,7 @@ static int snd_soc_unregister_card(struct snd_soc_card *card)
 /**
  * snd_soc_register_dai - Register a DAI with the ASoC core
  *
- * @param dai DAI to register
+ * @dai: DAI to register
  */
 int snd_soc_register_dai(struct snd_soc_dai *dai)
 {
@@ -2134,7 +2136,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_dai);
 /**
  * snd_soc_unregister_dai - Unregister a DAI from the ASoC core
  *
- * @param dai DAI to unregister
+ * @dai: DAI to unregister
  */
 void snd_soc_unregister_dai(struct snd_soc_dai *dai)
 {
@@ -2149,8 +2151,8 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_dai);
 /**
  * snd_soc_register_dais - Register multiple DAIs with the ASoC core
  *
- * @param dai Array of DAIs to register
- * @param count Number of DAIs
+ * @dai: Array of DAIs to register
+ * @count: Number of DAIs
  */
 int snd_soc_register_dais(struct snd_soc_dai *dai, size_t count)
 {
@@ -2175,8 +2177,8 @@ EXPORT_SYMBOL_GPL(snd_soc_register_dais);
 /**
  * snd_soc_unregister_dais - Unregister multiple DAIs from the ASoC core
  *
- * @param dai Array of DAIs to unregister
- * @param count Number of DAIs
+ * @dai: Array of DAIs to unregister
+ * @count: Number of DAIs
  */
 void snd_soc_unregister_dais(struct snd_soc_dai *dai, size_t count)
 {
@@ -2190,7 +2192,7 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_dais);
 /**
  * snd_soc_register_platform - Register a platform with the ASoC core
  *
- * @param platform platform to register
+ * @platform: platform to register
  */
 int snd_soc_register_platform(struct snd_soc_platform *platform)
 {
@@ -2213,7 +2215,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_platform);
 /**
  * snd_soc_unregister_platform - Unregister a platform from the ASoC core
  *
- * @param platform platform to unregister
+ * @platform: platform to unregister
  */
 void snd_soc_unregister_platform(struct snd_soc_platform *platform)
 {
@@ -2228,7 +2230,7 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_platform);
 /**
  * snd_soc_register_codec - Register a codec with the ASoC core
  *
- * @param codec codec to register
+ * @codec: codec to register
  */
 int snd_soc_register_codec(struct snd_soc_codec *codec)
 {
@@ -2255,7 +2257,7 @@ EXPORT_SYMBOL_GPL(snd_soc_register_codec);
 /**
  * snd_soc_unregister_codec - Unregister a codec from the ASoC core
  *
- * @param codec codec to unregister
+ * @codec: codec to unregister
  */
 void snd_soc_unregister_codec(struct snd_soc_codec *codec)
 {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8863edd..6c79ca6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1077,7 +1077,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
 /**
  * snd_soc_dapm_get_volsw - dapm mixer get callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to get the value of a dapm mixer control.
  *
@@ -1122,7 +1122,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_volsw);
 /**
  * snd_soc_dapm_put_volsw - dapm mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a dapm mixer control.
  *
@@ -1193,7 +1193,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
 /**
  * snd_soc_dapm_get_enum_double - dapm enumerated double mixer get callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to get the value of a dapm enumerated double mixer control.
  *
@@ -1221,7 +1221,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_get_enum_double);
 /**
  * snd_soc_dapm_put_enum_double - dapm enumerated double mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a dapm enumerated double mixer control.
  *
@@ -1419,7 +1419,7 @@ int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
 
 /**
  * snd_soc_dapm_enable_pin - enable pin.
- * @snd_soc_codec: SoC codec
+ * @codec: SoC codec
  * @pin: pin name
  *
  * Enables input/output pin and it's parents or children widgets iff there is
-- 
1.5.6.3
