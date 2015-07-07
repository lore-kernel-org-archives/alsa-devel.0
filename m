From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm_widget_show_codec: Use component
	instead of CODEC" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:33 +0100
Message-ID: <E1ZCTNN-0005R0-OD@finisterre>
References: <1436189891-15343-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6CCE26549F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:45 +0200 (CEST)
In-Reply-To: <1436189891-15343-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm_widget_show_codec: Use component instead of CODEC

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

>From b3c25fb7caa30afa5d5cc6b414a5b4d66bed77a7 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 6 Jul 2015 15:38:10 +0200
Subject: [PATCH] ASoC: dapm_widget_show_codec: Use component instead of CODEC

There is nothing snd_soc_codec specific in this function, just use
snd_soc_component instead.

With this also the last reference of snd_soc_codec form soc-dapm.c.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index aa327c9..a6c0ed1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2220,14 +2220,16 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
-static ssize_t dapm_widget_show_codec(struct snd_soc_codec *codec, char *buf)
+static ssize_t dapm_widget_show_component(struct snd_soc_component *cmpnt,
+	char *buf)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
 	struct snd_soc_dapm_widget *w;
 	int count = 0;
 	char *state = "not set";
 
-	list_for_each_entry(w, &codec->component.card->widgets, list) {
-		if (w->dapm != &codec->dapm)
+	list_for_each_entry(w, &cmpnt->card->widgets, list) {
+		if (w->dapm != dapm)
 			continue;
 
 		/* only display widgets that burnm power */
@@ -2255,7 +2257,7 @@ static ssize_t dapm_widget_show_codec(struct snd_soc_codec *codec, char *buf)
 		}
 	}
 
-	switch (codec->dapm.bias_level) {
+	switch (snd_soc_dapm_get_bias_level(dapm)) {
 	case SND_SOC_BIAS_ON:
 		state = "On";
 		break;
@@ -2282,8 +2284,9 @@ static ssize_t dapm_widget_show(struct device *dev,
 	int i, count = 0;
 
 	for (i = 0; i < rtd->num_codecs; i++) {
-		struct snd_soc_codec *codec = rtd->codec_dais[i]->codec;
-		count += dapm_widget_show_codec(codec, buf + count);
+		struct snd_soc_component *cmpnt = rtd->codec_dais[i]->component;
+
+		count += dapm_widget_show_component(cmpnt, buf + count);
 	}
 
 	return count;
-- 
2.1.4
