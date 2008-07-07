From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: core - refactored DAPM pin
	control	API.
Date: Mon, 07 Jul 2008 13:35:17 +0100
Message-ID: <1215434117.4882.152.camel@localhost.localdomain>
References: <1215180449.4882.131.camel@localhost.localdomain>
	<s5h4p75lmjp.wl%tiwai@suse.de>  <1215193124.6440.16.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C064224592
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 14:35:18 +0200 (CEST)
In-Reply-To: <1215193124.6440.16.camel@odin>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This time without the extras.....



Refactored snd_soc_dapm_set_endpoint() to snd_soc_dapm_enable_pin() and
snd_soc_dapm_disable_pin().

Renamed snd_soc_dapm_sync_endpoints() to snd_soc_dapm_sync().
Renamed snd_soc_dapm_get_endpoint_status() to
snd_soc_dapm_get_pin_status().

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h           |   15 ++---
 sound/soc/at91/eti_b1_wm8731.c     |   10 ++--
 sound/soc/codecs/tlv320aic3x.c     |    4 +-
 sound/soc/davinci/davinci-evm.c    |   16 +++---
 sound/soc/omap/n810.c              |   27 ++++++---
 sound/soc/pxa/corgi.c              |   42 +++++++------
 sound/soc/pxa/poodle.c             |   24 ++++----
 sound/soc/pxa/spitz.c              |   62 ++++++++++----------
 sound/soc/pxa/tosa.c               |   30 +++++----
 sound/soc/s3c24xx/neo1973_wm8753.c |  116 ++++++++++++++++++------------------
 sound/soc/sh/sh7760-ac97.c         |    2 +-
 sound/soc/soc-dapm.c               |   81 ++++++++++++++++---------
 12 files changed, 230 insertions(+), 199 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index b284953..3030fdc 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -234,16 +234,11 @@ int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
 
-/* event handler for register modifier widget - used by the soc-dapm */
-int dapm_reg_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event);
-
-/* dapm audio endpoint control */
-int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec,
-	char *pin, int status);
-int snd_soc_dapm_get_endpoint_status(struct snd_soc_codec *codec,
-	char *pin);
-int snd_soc_dapm_sync_endpoints(struct snd_soc_codec *codec);
+/* dapm audio pin control and status */
+int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, char *pin);
+int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, char *pin);
+int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, char *pin);
+int snd_soc_dapm_sync(struct snd_soc_codec *codec);
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
index 4a383a4..ad971e7 100644
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ b/sound/soc/at91/eti_b1_wm8731.c
@@ -216,14 +216,14 @@ static int eti_b1_wm8731_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_add_route(codec, intercon, ARRAY_SIZE(intercon));
 
 	/* not connected */
-	snd_soc_dapm_set_endpoint(codec, "RLINEIN", 0);
-	snd_soc_dapm_set_endpoint(codec, "LLINEIN", 0);
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
 
 	/* always connected */
-	snd_soc_dapm_set_endpoint(codec, "Int Mic", 1);
-	snd_soc_dapm_set_endpoint(codec, "Ext Spk", 1);
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d138306..954d39b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -29,7 +29,7 @@
  *  ---------------------------------------
  *
  *  Hence the machine layer should disable unsupported inputs/outputs by
- *  snd_soc_dapm_set_endpoint(codec, "MONO_LOUT", 0), etc.
+ *  snd_soc_dapm_disable_pin(codec, "MONO_LOUT"), etc.
  */
 
 #include <linux/module.h>
@@ -206,7 +206,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 		}
 
 		if (found)
-			snd_soc_dapm_sync_endpoints(widget->codec);
+			snd_soc_dapm_sync(widget->codec);
 	}
 
 	ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 4c70a0e..091eae3 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -103,17 +103,17 @@ static int evm_aic3x_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	/* not connected */
-	snd_soc_dapm_set_endpoint(codec, "MONO_LOUT", 0);
-	snd_soc_dapm_set_endpoint(codec, "HPLCOM", 0);
-	snd_soc_dapm_set_endpoint(codec, "HPRCOM", 0);
+	snd_soc_dapm_disable_pin(codec, "MONO_LOUT");
+	snd_soc_dapm_disable_pin(codec, "HPLCOM");
+	snd_soc_dapm_disable_pin(codec, "HPRCOM");
 
 	/* always connected */
-	snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 1);
-	snd_soc_dapm_set_endpoint(codec, "Line Out", 1);
-	snd_soc_dapm_set_endpoint(codec, "Mic Jack", 1);
-	snd_soc_dapm_set_endpoint(codec, "Line In", 1);
+	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	snd_soc_dapm_enable_pin(codec, "Line Out");
+	snd_soc_dapm_enable_pin(codec, "Mic Jack");
+	snd_soc_dapm_enable_pin(codec, "Line In");
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 
 	return 0;
 }
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 767b39f..74f4599 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -50,11 +50,22 @@ static int n810_dmic_func;
 
 static void n810_ext_control(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_set_endpoint(codec, "Ext Spk", n810_spk_func);
-	snd_soc_dapm_set_endpoint(codec, "Headphone Jack", n810_jack_func);
-	snd_soc_dapm_set_endpoint(codec, "DMic", n810_dmic_func);
+	if (n810_spk_func)
+		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	else
+		snd_soc_dapm_disable_pin(codec, "Ext Spk");
+
+	if (n810_jack_func)
+		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	else
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+
+	if (n810_dmic_func)
+		snd_soc_dapm_enable_pin(codec, "DMic");
+	else
+		snd_soc_dapm_disable_pin(codec, "DMic);
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 }
 
 static int n810_startup(struct snd_pcm_substream *substream)
@@ -236,9 +247,9 @@ static int n810_aic33_init(struct snd_soc_codec *codec)
 	int i, err;
 
 	/* Not connected */
-	snd_soc_dapm_set_endpoint(codec, "MONO_LOUT", 0);
-	snd_soc_dapm_set_endpoint(codec, "HPLCOM", 0);
-	snd_soc_dapm_set_endpoint(codec, "HPRCOM", 0);
+	snd_soc_dapm_disable_pin(codec, "MONO_LOUT");
+	snd_soc_dapm_disable_pin(codec, "HPLCOM");
+	snd_soc_dapm_disable_pin(codec, "HPRCOM");
 
 	/* Add N810 specific controls */
 	for (i = 0; i < ARRAY_SIZE(aic33_n810_controls); i++) {
@@ -255,7 +266,7 @@ static int n810_aic33_init(struct snd_soc_codec *codec)
 	/* Set up N810 specific audio path audio_map */
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index edeea63..db18ef6 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -50,47 +50,51 @@ static int corgi_spk_func;
 
 static void corgi_ext_control(struct snd_soc_codec *codec)
 {
-	int spk = 0, mic = 0, line = 0, hp = 0, hs = 0;
-
 	/* set up jack connection */
 	switch (corgi_jack_func) {
 	case CORGI_HP:
-		hp = 1;
 		/* set = unmute headphone */
 		set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_L);
 		set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_R);
+		snd_soc_dapm_disable_pin(codec, "Mic Jack");
+		snd_soc_dapm_disable_pin(codec, "Line Jack");
+		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
 		break;
 	case CORGI_MIC:
-		mic = 1;
 		/* reset = mute headphone */
 		reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_L);
 		reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_R);
+		snd_soc_dapm_enable_pin(codec, "Mic Jack");
+		snd_soc_dapm_disable_pin(codec, "Line Jack");
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
 		break;
 	case CORGI_LINE:
-		line = 1;
 		reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_L);
 		reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_R);
+		snd_soc_dapm_disable_pin(codec, "Mic Jack");
+		snd_soc_dapm_enable_pin(codec, "Line Jack");
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
 		break;
 	case CORGI_HEADSET:
-		hs = 1;
-		mic = 1;
 		reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_L);
 		set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_MUTE_R);
+		snd_soc_dapm_enable_pin(codec, "Mic Jack");
+		snd_soc_dapm_disable_pin(codec, "Line Jack");
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_enable_pin(codec, "Headset Jack");
 		break;
 	}
 
 	if (corgi_spk_func == CORGI_SPK_ON)
-		spk = 1;
-
-	/* set the enpoints to their new connetion states */
-	snd_soc_dapm_set_endpoint(codec, "Ext Spk", spk);
-	snd_soc_dapm_set_endpoint(codec, "Mic Jack", mic);
-	snd_soc_dapm_set_endpoint(codec, "Line Jack", line);
-	snd_soc_dapm_set_endpoint(codec, "Headphone Jack", hp);
-	snd_soc_dapm_set_endpoint(codec, "Headset Jack", hs);
+		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	else
+		snd_soc_dapm_disable_pin(codec, "Ext Spk");
 
 	/* signal a DAPM event */
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 }
 
 static int corgi_startup(struct snd_pcm_substream *substream)
@@ -285,8 +289,8 @@ static int corgi_wm8731_init(struct snd_soc_codec *codec)
 {
 	int i, err;
 
-	snd_soc_dapm_set_endpoint(codec, "LLINEIN", 0);
-	snd_soc_dapm_set_endpoint(codec, "RLINEIN", 0);
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
 
 	/* Add corgi specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8731_corgi_controls); i++) {
@@ -303,7 +307,7 @@ static int corgi_wm8731_init(struct snd_soc_codec *codec)
 	/* Set up corgi specific audio path audio_map */
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 810f1fe..36cbf69 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -48,8 +48,6 @@ static int poodle_spk_func;
 
 static void poodle_ext_control(struct snd_soc_codec *codec)
 {
-	int spk = 0;
-
 	/* set up jack connection */
 	if (poodle_jack_func == POODLE_HP) {
 		/* set = unmute headphone */
@@ -57,23 +55,23 @@ static void poodle_ext_control(struct snd_soc_codec *codec)
 			POODLE_LOCOMO_GPIO_MUTE_L, 1);
 		locomo_gpio_write(&poodle_locomo_device.dev,
 			POODLE_LOCOMO_GPIO_MUTE_R, 1);
-		snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 1);
+		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
 	} else {
 		locomo_gpio_write(&poodle_locomo_device.dev,
 			POODLE_LOCOMO_GPIO_MUTE_L, 0);
 		locomo_gpio_write(&poodle_locomo_device.dev,
 			POODLE_LOCOMO_GPIO_MUTE_R, 0);
-		snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 0);
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
 	}
 
-	if (poodle_spk_func == POODLE_SPK_ON)
-		spk = 1;
-
 	/* set the enpoints to their new connetion states */
-	snd_soc_dapm_set_endpoint(codec, "Ext Spk", spk);
+	if (poodle_spk_func == POODLE_SPK_ON)
+		snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	else
+		snd_soc_dapm_disable_pin(codec, "Ext Spk");
 
 	/* signal a DAPM event */
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 }
 
 static int poodle_startup(struct snd_pcm_substream *substream)
@@ -248,9 +246,9 @@ static int poodle_wm8731_init(struct snd_soc_codec *codec)
 {
 	int i, err;
 
-	snd_soc_dapm_set_endpoint(codec, "LLINEIN", 0);
-	snd_soc_dapm_set_endpoint(codec, "RLINEIN", 0);
-	snd_soc_dapm_set_endpoint(codec, "MICIN", 1);
+	snd_soc_dapm_disable_pin(codec, "LLINEIN");
+	snd_soc_dapm_disable_pin(codec, "RLINEIN");
+	snd_soc_dapm_enable_pin(codec, "MICIN");
 
 	/* Add poodle specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8731_poodle_controls); i++) {
@@ -267,7 +265,7 @@ static int poodle_wm8731_init(struct snd_soc_codec *codec)
 	/* Set up poodle specific audio path audio_map */
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 092b5c7..ec18163 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -51,60 +51,60 @@ static int spitz_spk_func;
 static void spitz_ext_control(struct snd_soc_codec *codec)
 {
 	if (spitz_spk_func == SPITZ_SPK_ON)
-		snd_soc_dapm_set_endpoint(codec, "Ext Spk", 1);
+		snd_soc_dapm_enable_pin(codec, "Ext Spk");
 	else
-		snd_soc_dapm_set_endpoint(codec, "Ext Spk", 0);
+		snd_soc_dapm_disable_pin(codec, "Ext Spk");
 
 	/* set up jack connection */
 	switch (spitz_jack_func) {
 	case SPITZ_HP:
 		/* enable and unmute hp jack, disable mic bias */
-		snd_soc_dapm_set_endpoint(codec, "Headset Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Mic Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Line Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 1);
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(codec, "Mic Jack");
+		snd_soc_dapm_disable_pin(codec, "Line Jack");
+		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
 		set_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_L);
 		set_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_R);
 		break;
 	case SPITZ_MIC:
 		/* enable mic jack and bias, mute hp */
-		snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Line Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Mic Jack", 1);
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(codec, "Line Jack");
+		snd_soc_dapm_enable_pin(codec, "Mic Jack");
 		reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_L);
 		reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_R);
 		break;
 	case SPITZ_LINE:
 		/* enable line jack, disable mic bias and mute hp */
-		snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Mic Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Line Jack", 1);
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(codec, "Mic Jack");
+		snd_soc_dapm_enable_pin(codec, "Line Jack");
 		reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_L);
 		reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_R);
 		break;
 	case SPITZ_HEADSET:
 		/* enable and unmute headset jack enable mic bias, mute L hp */
-		snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Mic Jack", 1);
-		snd_soc_dapm_set_endpoint(codec, "Line Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Jack", 1);
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_enable_pin(codec, "Mic Jack");
+		snd_soc_dapm_disable_pin(codec, "Line Jack");
+		snd_soc_dapm_enable_pin(codec, "Headset Jack");
 		reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_L);
 		set_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_R);
 		break;
 	case SPITZ_HP_OFF:
 
 		/* jack removed, everything off */
-		snd_soc_dapm_set_endpoint(codec, "Headphone Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Mic Jack", 0);
-		snd_soc_dapm_set_endpoint(codec, "Line Jack", 0);
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
+		snd_soc_dapm_disable_pin(codec, "Mic Jack");
+		snd_soc_dapm_disable_pin(codec, "Line Jack");
 		reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_L);
 		reset_scoop_gpio(&spitzscoop_device.dev, SPITZ_SCP_MUTE_R);
 		break;
 	}
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 }
 
 static int spitz_startup(struct snd_pcm_substream *substream)
@@ -291,13 +291,13 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	int i, err;
 
 	/* NC codec pins */
-	snd_soc_dapm_set_endpoint(codec, "RINPUT1", 0);
-	snd_soc_dapm_set_endpoint(codec, "LINPUT2", 0);
-	snd_soc_dapm_set_endpoint(codec, "RINPUT2", 0);
-	snd_soc_dapm_set_endpoint(codec, "LINPUT3", 0);
-	snd_soc_dapm_set_endpoint(codec, "RINPUT3", 0);
-	snd_soc_dapm_set_endpoint(codec, "OUT3", 0);
-	snd_soc_dapm_set_endpoint(codec, "MONO", 0);
+	snd_soc_dapm_disable_pin(codec, "RINPUT1");
+	snd_soc_dapm_disable_pin(codec, "LINPUT2");
+	snd_soc_dapm_disable_pin(codec, "RINPUT2");
+	snd_soc_dapm_disable_pin(codec, "LINPUT3");
+	snd_soc_dapm_disable_pin(codec, "RINPUT3");
+	snd_soc_dapm_disable_pin(codec, "OUT3");
+	snd_soc_dapm_disable_pin(codec, "MONO");
 
 	/* Add spitz specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8750_spitz_controls); i++) {
@@ -314,7 +314,7 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	/* Set up spitz specific audio paths */
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 	return 0;
 }
 
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 465ff0f..dba7689 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -52,29 +52,31 @@ static int tosa_spk_func;
 
 static void tosa_ext_control(struct snd_soc_codec *codec)
 {
-	int spk = 0, mic_int = 0, hp = 0, hs = 0;
-
 	/* set up jack connection */
 	switch (tosa_jack_func) {
 	case TOSA_HP:
-		hp = 1;
+		snd_soc_dapm_disable_pin(codec, "Mic (Internal)");
+		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
 		break;
 	case TOSA_MIC_INT:
-		mic_int = 1;
+		snd_soc_dapm_enable_pin(codec, "Mic (Internal)");
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_disable_pin(codec, "Headset Jack");
 		break;
 	case TOSA_HEADSET:
-		hs = 1;
+		snd_soc_dapm_disable_pin(codec, "Mic (Internal)");
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+		snd_soc_dapm_enable_pin(codec, "Headset Jack");
 		break;
 	}
 
 	if (tosa_spk_func == TOSA_SPK_ON)
-		spk = 1;
+		snd_soc_dapm_enable_pin(codec, "Speaker");
+	else
+		snd_soc_dapm_disable_pin(codec, "Speaker");
 
-	snd_soc_dapm_set_endpoint(codec, "Speaker", spk);
-	snd_soc_dapm_set_endpoint(codec, "Mic (Internal)", mic_int);
-	snd_soc_dapm_set_endpoint(codec, "Headphone Jack", hp);
-	snd_soc_dapm_set_endpoint(codec, "Headset Jack", hs);
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 }
 
 static int tosa_startup(struct snd_pcm_substream *substream)
@@ -191,8 +193,8 @@ static int tosa_ac97_init(struct snd_soc_codec *codec)
 {
 	int i, err;
 
-	snd_soc_dapm_set_endpoint(codec, "OUT3", 0);
-	snd_soc_dapm_set_endpoint(codec, "MONOOUT", 0);
+	snd_soc_dapm_disable_pin(codec, "OUT3");
+	snd_soc_dapm_disable_pin(codec, "MONOOUT");
 
 	/* add tosa specific controls */
 	for (i = 0; i < ARRAY_SIZE(tosa_controls); i++) {
@@ -209,7 +211,7 @@ static int tosa_ac97_init(struct snd_soc_codec *codec)
 	/* set up tosa specific audio path audio_map */
 	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 	return 0;
 }
 
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 3485123..f053e85 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -250,77 +250,77 @@ static int set_scenario_endpoints(struct snd_soc_codec *codec, int scenario)
 
 	switch (neo1973_scenario) {
 	case NEO_AUDIO_OFF:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 		break;
 	case NEO_GSM_CALL_AUDIO_HANDSET:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    1);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 1);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  1);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     1);
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_enable_pin(codec, "Call Mic");
 		break;
 	case NEO_GSM_CALL_AUDIO_HEADSET:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    1);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 1);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  1);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  1);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line In");
+		snd_soc_dapm_enable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 		break;
 	case NEO_GSM_CALL_AUDIO_BLUETOOTH:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 1);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  1);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_enable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 		break;
 	case NEO_STEREO_TO_SPEAKERS:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    1);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 		break;
 	case NEO_STEREO_TO_HEADPHONES:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    1);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_enable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 		break;
 	case NEO_CAPTURE_HANDSET:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     1);
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_enable_pin(codec, "Call Mic");
 		break;
 	case NEO_CAPTURE_HEADSET:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  1);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_enable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 		break;
 	case NEO_CAPTURE_BLUETOOTH:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 		break;
 	default:
-		snd_soc_dapm_set_endpoint(codec, "Audio Out",    0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
-		snd_soc_dapm_set_endpoint(codec, "GSM Line In",  0);
-		snd_soc_dapm_set_endpoint(codec, "Headset Mic",  0);
-		snd_soc_dapm_set_endpoint(codec, "Call Mic",     0);
+		snd_soc_dapm_disable_pin(codec, "Audio Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line Out");
+		snd_soc_dapm_disable_pin(codec, "GSM Line In");
+		snd_soc_dapm_disable_pin(codec, "Headset Mic");
+		snd_soc_dapm_disable_pin(codec, "Call Mic");
 	}
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 
 	return 0;
 }
@@ -511,12 +511,12 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 	DBG("Entered %s\n", __func__);
 
 	/* set up NC codec pins */
-	snd_soc_dapm_set_endpoint(codec, "LOUT2", 0);
-	snd_soc_dapm_set_endpoint(codec, "ROUT2", 0);
-	snd_soc_dapm_set_endpoint(codec, "OUT3",  0);
-	snd_soc_dapm_set_endpoint(codec, "OUT4",  0);
-	snd_soc_dapm_set_endpoint(codec, "LINE1", 0);
-	snd_soc_dapm_set_endpoint(codec, "LINE2", 0);
+	snd_soc_dapm_disable_pin(codec, "LOUT2");
+	snd_soc_dapm_disable_pin(codec, "ROUT2");
+	snd_soc_dapm_disable_pin(codec, "OUT3");
+	snd_soc_dapm_disable_pin(codec, "OUT4");
+	snd_soc_dapm_disable_pin(codec, "LINE1");
+	snd_soc_dapm_disable_pin(codec, "LINE2");
 
 
 	/* set endpoints to default mode */
@@ -539,7 +539,7 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 	err = snd_soc_dapm_add_routes(codec, dapm_routes,
 				      ARRAY_SIZE(dapm_routes));
 
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 	return 0;
 }
 
diff --git a/sound/soc/sh/sh7760-ac97.c b/sound/soc/sh/sh7760-ac97.c
index 2f91de8..846d1b3 100644
--- a/sound/soc/sh/sh7760-ac97.c
+++ b/sound/soc/sh/sh7760-ac97.c
@@ -25,7 +25,7 @@ extern struct snd_soc_platform sh7760_soc_platform;
 
 static int machine_init(struct snd_soc_codec *codec)
 {
-	snd_soc_dapm_sync_endpoints(codec);
+	snd_soc_dapm_sync(codec);
 	return 0;
 }
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 91cbbef..94296b5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -880,8 +880,25 @@ static void dapm_free_widgets(struct snd_soc_codec *codec)
 	}
 }
 
+static int snd_soc_dapm_set_pin(struct snd_soc_codec *codec,
+	char *pin, int status)
+{
+	struct snd_soc_dapm_widget *w;
+
+	list_for_each_entry(w, &codec->dapm_widgets, list) {
+		if (!strcmp(w->name, pin)) {
+			dbg("dapm: %s: pin %s\n", codec->name, pin);
+			w->connected = status;
+			return 0;
+		}
+	}
+
+	dbg("dapm: %s: configuring unknown pin %s\n", codec->name, pin);
+	return -EINVAL;
+}
+
 /**
- * snd_soc_dapm_sync_endpoints - scan and power dapm paths
+ * snd_soc_dapm_sync - scan and power dapm paths
  * @codec: audio codec
  *
  * Walks all dapm audio paths and powers widgets according to their
@@ -889,11 +906,11 @@ static void dapm_free_widgets(struct snd_soc_codec *codec)
  *
  * Returns 0 for success.
  */
-int snd_soc_dapm_sync_endpoints(struct snd_soc_codec *codec)
+int snd_soc_dapm_sync(struct snd_soc_codec *codec)
 {
 	return dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
 }
-EXPORT_SYMBOL_GPL(snd_soc_dapm_sync_endpoints);
+EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
 static int snd_soc_dapm_add_route(struct snd_soc_codec *codec,
 	const char *sink, const char *control, const char *source)
@@ -1441,53 +1458,57 @@ int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
 }
 
 /**
- * snd_soc_dapm_set_endpoint - set audio endpoint status
- * @codec: audio codec
- * @endpoint: audio signal endpoint (or start point)
- * @status: point status
- *
- * Set audio endpoint status - connected or disconnected.
+ * snd_soc_dapm_enable_pin - enable pin.
+ * @snd_soc_codec: SoC codec
+ * @pin: pin name
  *
- * Returns 0 for success else error.
+ * Enables input/output pin and it's parents or children widgets iff there is
+ * a valid audio route and active audio stream.
+ * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
+ * do any widget power switching.
  */
-int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec,
-	char *endpoint, int status)
+int snd_soc_dapm_enable_pin(struct snd_soc_codec *codec, char *pin)
 {
-	struct snd_soc_dapm_widget *w;
-
-	list_for_each_entry(w, &codec->dapm_widgets, list) {
-		if (!strcmp(w->name, endpoint)) {
-			w->connected = status;
-			return 0;
-		}
-	}
+	return snd_soc_dapm_set_pin(codec, pin, 1);
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_enable_pin);
 
-	return -ENODEV;
+/**
+ * snd_soc_dapm_disable_pin - disable pin.
+ * @codec: SoC codec
+ * @pin: pin name
+ *
+ * Disables input/output pin and it's parents or children widgets.
+ * NOTE: snd_soc_dapm_sync() needs to be called after this for DAPM to
+ * do any widget power switching.
+ */
+int snd_soc_dapm_disable_pin(struct snd_soc_codec *codec, char *pin)
+{
+	return snd_soc_dapm_set_pin(codec, pin, 0);
 }
-EXPORT_SYMBOL_GPL(snd_soc_dapm_set_endpoint);
+EXPORT_SYMBOL_GPL(snd_soc_dapm_disable_pin);
 
 /**
- * snd_soc_dapm_get_endpoint_status - get audio endpoint status
+ * snd_soc_dapm_get_pin_status - get audio pin status
  * @codec: audio codec
- * @endpoint: audio signal endpoint (or start point)
+ * @pin: audio signal pin endpoint (or start point)
  *
- * Get audio endpoint status - connected or disconnected.
+ * Get audio pin status - connected or disconnected.
  *
- * Returns status
+ * Returns 1 for connected otherwise 0.
  */
-int snd_soc_dapm_get_endpoint_status(struct snd_soc_codec *codec,
-	char *endpoint)
+int snd_soc_dapm_get_pin_status(struct snd_soc_codec *codec, char *pin)
 {
 	struct snd_soc_dapm_widget *w;
 
 	list_for_each_entry(w, &codec->dapm_widgets, list) {
-		if (!strcmp(w->name, endpoint))
+		if (!strcmp(w->name, pin))
 			return w->connected;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(snd_soc_dapm_get_endpoint_status);
+EXPORT_SYMBOL_GPL(snd_soc_dapm_get_pin_status);
 
 /**
  * snd_soc_dapm_free - free dapm resources
-- 
1.5.4.2
