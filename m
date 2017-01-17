From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: handle probe deferrals" to the
	asoc tree
Date: Tue, 17 Jan 2017 18:45:06 +0000
Message-ID: <E1cTYkk-0008QN-Qb@debutante>
References: <20170113092352.22474-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 716CD2665B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:14 +0100 (CET)
In-Reply-To: <20170113092352.22474-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: handle probe deferrals

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 37e1df8c95e2c8a57c77eafc097648f6e40a60ff Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Jan 2017 10:23:52 +0100
Subject: [PATCH] ASoC: dapm: handle probe deferrals

This starts to handle probe deferrals on regulators and clocks
on the ASoC DAPM.

I came to this patch after audio stopped working on Ux500 ages
ago and I finally looked into it to see what is wrong. I had
messages like this in the console since a while back:

ab8500-codec.0: ASoC: Failed to request audioclk: -517
ab8500-codec.0: ASoC: Failed to create DAPM control audioclk
ab8500-codec.0: Failed to create new controls -12
snd-soc-mop500.0: ASoC: failed to instantiate card -12
snd-soc-mop500.0: Error: snd_soc_register_card failed (-12)!
snd-soc-mop500: probe of snd-soc-mop500.0 failed with error -12

Apparently because the widget table for the codec looks like
this (sound/soc/codecs/ab8500-codec.c):

static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {

        /* Clocks */
        SND_SOC_DAPM_CLOCK_SUPPLY("audioclk"),

        /* Regulators */
        SND_SOC_DAPM_REGULATOR_SUPPLY("V-AUD", 0, 0),
        SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC1", 0, 0),
        SND_SOC_DAPM_REGULATOR_SUPPLY("V-AMIC2", 0, 0),
        SND_SOC_DAPM_REGULATOR_SUPPLY("V-DMIC", 0, 0),

So when we call snd_soc_register_codec() and any of these widgets
get a deferred probe we do not get an -EPROBE_DEFER (-517) back as
we should and instead we just fail. Apparently the code assumes
that clocks and regulators must be available at this point and
not defer.

After this patch it rather looks like this:

ab8500-codec.0: Failed to create new controls -517
snd-soc-mop500.0: ASoC: failed to instantiate card -517
snd-soc-mop500.0: Error: snd_soc_register_card failed (-517)!
(...)
abx500-clk.0: registered clocks for ab850x
snd-soc-mop500.0: ab8500-codec-dai.0 <-> ux500-msp-i2s.1 mapping ok
snd-soc-mop500.0: ab8500-codec-dai.1 <-> ux500-msp-i2s.3 mapping ok

I'm pretty happy about the patch as it it, but I'm a bit
uncertain on how to proceed: there are a lot of users of the
external functions snd_soc_dapm_new_control() (111 sites)
and that will now return an occassional error pointer, which
is not handled in the calling sites.

I want an indication from the maintainers whether I should just
go in and augment all these call sites, or if deferred probe
is frowned upon when it leads to this much overhead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-topology.c |  9 +++++++++
 2 files changed, 51 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 27dd02e57b31..b218cc7bd994 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -363,6 +363,10 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 				snd_soc_dapm_new_control_unlocked(widget->dapm,
 				&template);
 			kfree(name);
+			if (IS_ERR(data->widget)) {
+				ret = PTR_ERR(data->widget);
+				goto err_data;
+			}
 			if (!data->widget) {
 				ret = -ENOMEM;
 				goto err_data;
@@ -397,6 +401,10 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 			data->widget = snd_soc_dapm_new_control_unlocked(
 						widget->dapm, &template);
 			kfree(name);
+			if (IS_ERR(data->widget)) {
+				ret = PTR_ERR(data->widget);
+				goto err_data;
+			}
 			if (!data->widget) {
 				ret = -ENOMEM;
 				goto err_data;
@@ -3403,11 +3411,22 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
+	/* Do not nag about probe deferrals */
+	if (IS_ERR(w)) {
+		int ret = PTR_ERR(w);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(dapm->dev,
+				"ASoC: Failed to create DAPM control %s (%d)\n",
+				widget->name, ret);
+		goto out_unlock;
+	}
 	if (!w)
 		dev_err(dapm->dev,
 			"ASoC: Failed to create DAPM control %s\n",
 			widget->name);
 
+out_unlock:
 	mutex_unlock(&dapm->card->dapm_mutex);
 	return w;
 }
@@ -3430,6 +3449,8 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->regulator = devm_regulator_get(dapm->dev, w->name);
 		if (IS_ERR(w->regulator)) {
 			ret = PTR_ERR(w->regulator);
+			if (ret == -EPROBE_DEFER)
+				return ERR_PTR(ret);
 			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
 				w->name, ret);
 			return NULL;
@@ -3448,6 +3469,8 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		w->clk = devm_clk_get(dapm->dev, w->name);
 		if (IS_ERR(w->clk)) {
 			ret = PTR_ERR(w->clk);
+			if (ret == -EPROBE_DEFER)
+				return ERR_PTR(ret);
 			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
 				w->name, ret);
 			return NULL;
@@ -3566,6 +3589,16 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
 		w = snd_soc_dapm_new_control_unlocked(dapm, widget);
+		if (IS_ERR(w)) {
+			ret = PTR_ERR(w);
+			/* Do not nag about probe deferrals */
+			if (ret == -EPROBE_DEFER)
+				break;
+			dev_err(dapm->dev,
+				"ASoC: Failed to create DAPM control %s (%d)\n",
+				widget->name, ret);
+			break;
+		}
 		if (!w) {
 			dev_err(dapm->dev,
 				"ASoC: Failed to create DAPM control %s\n",
@@ -3842,6 +3875,15 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
 	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
+	if (IS_ERR(w)) {
+		ret = PTR_ERR(w);
+		/* Do not nag about probe deferrals */
+		if (ret != -EPROBE_DEFER)
+			dev_err(card->dev,
+				"ASoC: Failed to create %s widget (%d)\n",
+				link_name, ret);
+		goto outfree_kcontrol_news;
+	}
 	if (!w) {
 		dev_err(card->dev, "ASoC: Failed to create %s widget\n",
 			link_name);
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 65670b2b408c..37006c63891a 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1556,6 +1556,15 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 		widget = snd_soc_dapm_new_control(dapm, &template);
 	else
 		widget = snd_soc_dapm_new_control_unlocked(dapm, &template);
+	if (IS_ERR(widget)) {
+		ret = PTR_ERR(widget);
+		/* Do not nag about probe deferrals */
+		if (ret != -EPROBE_DEFER)
+			dev_err(tplg->dev,
+				"ASoC: failed to create widget %s controls (%d)\n",
+				w->name, ret);
+		goto hdr_err;
+	}
 	if (widget == NULL) {
 		dev_err(tplg->dev, "ASoC: failed to create widget %s controls\n",
 			w->name);
-- 
2.11.0
