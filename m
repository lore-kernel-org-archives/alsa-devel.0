From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 3/5] ASoC: Replace remaining uses of
	snd_soc_cnew with snd_soc_add_controls.
Date: Thu, 12 Mar 2009 11:07:54 +0100
Message-ID: <1236852474-15930-1-git-send-email-philipp.zabel@gmail.com>
References: <20090311224439.GB9001@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id CACFF1038CD
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 11:08:03 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 13so93809fge.44
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 03:08:03 -0700 (PDT)
In-Reply-To: <20090311224439.GB9001@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The drivers are basically duplicating the same code over and over.
As snd_soc_cnew is going to be made static some time after the next
merge window, we might as well convert them now.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/codecs/cs4270.c          |   23 +++++------------------
 sound/soc/codecs/tlv320aic26.c     |   11 ++++-------
 sound/soc/codecs/wm8400.c          |   12 ++----------
 sound/soc/omap/n810.c              |   12 +++++-------
 sound/soc/pxa/corgi.c              |   12 +++++-------
 sound/soc/pxa/palm27x.c            |   13 +++++--------
 sound/soc/pxa/poodle.c             |   12 +++++-------
 sound/soc/pxa/spitz.c              |   12 +++++-------
 sound/soc/pxa/tosa.c               |   12 +++++-------
 sound/soc/s3c24xx/neo1973_wm8753.c |   13 +++++--------
 10 files changed, 46 insertions(+), 86 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 0e0c23e..8e58c81 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -538,7 +538,6 @@ static int cs4270_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = cs4270_codec;
-	unsigned int i;
 	int ret;
 
 	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
@@ -552,23 +551,11 @@ static int cs4270_probe(struct platform_device *pdev)
 	}
 
 	/* Add the non-DAPM controls */
-	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
-		struct snd_kcontrol *kctrl;
-
-		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
-		if (!kctrl) {
-			dev_err(codec->dev, "error creating control '%s'\n",
-			       cs4270_snd_controls[i].name);
-			ret = -ENOMEM;
-			goto error_free_pcms;
-		}
-
-		ret = snd_ctl_add(codec->card, kctrl);
-		if (ret < 0) {
-			dev_err(codec->dev, "error adding control '%s'\n",
-			       cs4270_snd_controls[i].name);
-			goto error_free_pcms;
-		}
+	ret = snd_soc_add_controls(codec, cs4270_snd_controls,
+				ARRAY_SIZE(cs4270_snd_controls));
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to add controls\n");
+		goto error_free_pcms;
 	}
 
 	/* And finally, register the socdev */
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 229e464..633bc4b 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -322,9 +322,8 @@ static int aic26_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec;
-	struct snd_kcontrol *kcontrol;
 	struct aic26 *aic26;
-	int i, ret, err;
+	int ret, err;
 
 	dev_info(&pdev->dev, "Probing AIC26 SoC CODEC driver\n");
 	dev_dbg(&pdev->dev, "socdev=%p\n", socdev);
@@ -351,11 +350,9 @@ static int aic26_probe(struct platform_device *pdev)
 
 	/* register controls */
 	dev_dbg(&pdev->dev, "Registering controls\n");
-	for (i = 0; i < ARRAY_SIZE(aic26_snd_controls); i++) {
-		kcontrol = snd_soc_cnew(&aic26_snd_controls[i], codec, NULL);
-		err = snd_ctl_add(codec->card, kcontrol);
-		WARN_ON(err < 0);
-	}
+	err = snd_soc_add_controls(codec, aic26_snd_controls,
+			ARRAY_SIZE(aic26_snd_controls));
+	WARN_ON(err < 0);
 
 	/* CODEC is setup, we can register the card now */
 	dev_dbg(&pdev->dev, "Registering card\n");
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 9cb73d9..3269121 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -351,16 +351,8 @@ SOC_SINGLE("RIN34 Mute Switch", WM8400_RIGHT_LINE_INPUT_3_4_VOLUME,
 /* add non dapm controls */
 static int wm8400_add_controls(struct snd_soc_codec *codec)
 {
-	int err, i;
-
-	for (i = 0; i < ARRAY_SIZE(wm8400_snd_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8400_snd_controls[i],codec,
-					NULL));
-		if (err < 0)
-			return err;
-	}
-	return 0;
+	return snd_soc_add_controls(codec, wm8400_snd_controls,
+				ARRAY_SIZE(wm8400_snd_controls));
 }
 
 /*
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 9f037cd..86471fd 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -248,7 +248,7 @@ static const struct snd_kcontrol_new aic33_n810_controls[] = {
 
 static int n810_aic33_init(struct snd_soc_codec *codec)
 {
-	int i, err;
+	int err;
 
 	/* Not connected */
 	snd_soc_dapm_nc_pin(codec, "MONO_LOUT");
@@ -256,12 +256,10 @@ static int n810_aic33_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_nc_pin(codec, "HPRCOM");
 
 	/* Add N810 specific controls */
-	for (i = 0; i < ARRAY_SIZE(aic33_n810_controls); i++) {
-		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&aic33_n810_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
+	err = snd_soc_add_controls(codec, aic33_n810_controls,
+				ARRAY_SIZE(aic33_n810_controls));
+	if (err < 0)
+		return err;
 
 	/* Add N810 specific widgets */
 	snd_soc_dapm_new_controls(codec, aic33_dapm_widgets,
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 146973a..02263e5 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -276,18 +276,16 @@ static const struct snd_kcontrol_new wm8731_corgi_controls[] = {
  */
 static int corgi_wm8731_init(struct snd_soc_codec *codec)
 {
-	int i, err;
+	int err;
 
 	snd_soc_dapm_nc_pin(codec, "LLINEIN");
 	snd_soc_dapm_nc_pin(codec, "RLINEIN");
 
 	/* Add corgi specific controls */
-	for (i = 0; i < ARRAY_SIZE(wm8731_corgi_controls); i++) {
-		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&wm8731_corgi_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
+	err = snd_soc_add_controls(codec, wm8731_corgi_controls,
+				ARRAY_SIZE(wm8731_corgi_controls));
+	if (err < 0)
+		return err;
 
 	/* Add corgi specific widgets */
 	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 29958cd..48a73f6 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -146,19 +146,16 @@ static const struct snd_kcontrol_new palm27x_controls[] = {
 
 static int palm27x_ac97_init(struct snd_soc_codec *codec)
 {
-	int i, err;
+	int err;
 
 	snd_soc_dapm_nc_pin(codec, "OUT3");
 	snd_soc_dapm_nc_pin(codec, "MONOOUT");
 
 	/* add palm27x specific controls */
-	for (i = 0; i < ARRAY_SIZE(palm27x_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&palm27x_controls[i],
-						codec, NULL));
-		if (err < 0)
-			return err;
-	}
+	err = snd_soc_add_controls(codec, palm27x_controls,
+				ARRAY_SIZE(palm27x_controls));
+	if (err < 0)
+		return err;
 
 	/* add palm27x specific widgets */
 	snd_soc_dapm_new_controls(codec, palm27x_dapm_widgets,
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index fb17a0a..ef7c6c8 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -241,19 +241,17 @@ static const struct snd_kcontrol_new wm8731_poodle_controls[] = {
  */
 static int poodle_wm8731_init(struct snd_soc_codec *codec)
 {
-	int i, err;
+	int err;
 
 	snd_soc_dapm_nc_pin(codec, "LLINEIN");
 	snd_soc_dapm_nc_pin(codec, "RLINEIN");
 	snd_soc_dapm_enable_pin(codec, "MICIN");
 
 	/* Add poodle specific controls */
-	for (i = 0; i < ARRAY_SIZE(wm8731_poodle_controls); i++) {
-		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&wm8731_poodle_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
+	err = snd_soc_add_controls(codec, wm8731_poodle_controls,
+				ARRAY_SIZE(wm8731_poodle_controls));
+	if (err < 0)
+		return err;
 
 	/* Add poodle specific widgets */
 	snd_soc_dapm_new_controls(codec, wm8731_dapm_widgets,
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 1aafd8c..6ca9f53 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -278,7 +278,7 @@ static const struct snd_kcontrol_new wm8750_spitz_controls[] = {
  */
 static int spitz_wm8750_init(struct snd_soc_codec *codec)
 {
-	int i, err;
+	int err;
 
 	/* NC codec pins */
 	snd_soc_dapm_nc_pin(codec, "RINPUT1");
@@ -290,12 +290,10 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_nc_pin(codec, "MONO1");
 
 	/* Add spitz specific controls */
-	for (i = 0; i < ARRAY_SIZE(wm8750_spitz_controls); i++) {
-		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&wm8750_spitz_controls[i], codec, NULL));
-		if (err < 0)
-			return err;
-	}
+	err = snd_soc_add_controls(codec, wm8750_spitz_controls,
+				ARRAY_SIZE(wm8750_spitz_controls));
+	if (err < 0)
+		return err;
 
 	/* Add spitz specific widgets */
 	snd_soc_dapm_new_controls(codec, wm8750_dapm_widgets,
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 09b5bad..fc78137 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -188,18 +188,16 @@ static const struct snd_kcontrol_new tosa_controls[] = {
 
 static int tosa_ac97_init(struct snd_soc_codec *codec)
 {
-	int i, err;
+	int err;
 
 	snd_soc_dapm_nc_pin(codec, "OUT3");
 	snd_soc_dapm_nc_pin(codec, "MONOOUT");
 
 	/* add tosa specific controls */
-	for (i = 0; i < ARRAY_SIZE(tosa_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&tosa_controls[i],codec, NULL));
-		if (err < 0)
-			return err;
-	}
+	err = snd_soc_add_controls(codec, tosa_controls,
+				ARRAY_SIZE(tosa_controls));
+	if (err < 0)
+		return err;
 
 	/* add tosa specific widgets */
 	snd_soc_dapm_new_controls(codec, tosa_dapm_widgets,
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 5f6aeec..289fadf 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -498,7 +498,7 @@ static const struct snd_kcontrol_new wm8753_neo1973_controls[] = {
  */
 static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 {
-	int i, err;
+	int err;
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -518,13 +518,10 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 	set_scenario_endpoints(codec, NEO_AUDIO_OFF);
 
 	/* add neo1973 specific controls */
-	for (i = 0; i < ARRAY_SIZE(wm8753_neo1973_controls); i++) {
-		err = snd_ctl_add(codec->card,
-				snd_soc_cnew(&wm8753_neo1973_controls[i],
-				codec, NULL));
-		if (err < 0)
-			return err;
-	}
+	err = snd_soc_add_controls(codec, wm8753_neo1973_controls,
+				ARRAY_SIZE(8753_neo1973_controls));
+	if (err < 0)
+		return err;
 
 	/* set up neo1973 specific audio routes */
 	err = snd_soc_dapm_add_routes(codec, dapm_routes,
-- 
1.6.2
