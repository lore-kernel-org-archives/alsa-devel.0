From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Use standard component set_jack
	callback" to the asoc tree
Date: Thu, 01 Mar 2018 18:06:50 +0000
Message-ID: <E1erSbS-0005qA-HS@debutante>
References: <20180222170738.8508-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 197D0267B35
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:06:59 +0100 (CET)
In-Reply-To: <20180222170738.8508-5-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Use standard component set_jack callback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6f0b819ae2b36614a514824c622ac0e02650b718 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:45 +0100
Subject: [PATCH] ASoC: rt5651: Use standard component set_jack callback

Use the standard component set_jack callback instead of defining a codec
private API for this.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c             | 6 +++---
 sound/soc/codecs/rt5651.h             | 2 --
 sound/soc/intel/boards/bytcr_rt5651.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index c9698229fc33..030889143249 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1593,8 +1593,8 @@ static irqreturn_t rt5651_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int rt5651_set_jack_detect(struct snd_soc_component *component,
-			   struct snd_soc_jack *hp_jack)
+static int rt5651_set_jack(struct snd_soc_component *component,
+			   struct snd_soc_jack *hp_jack, void *data)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
@@ -1658,7 +1658,6 @@ int rt5651_set_jack_detect(struct snd_soc_component *component,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rt5651_set_jack_detect);
 
 static int rt5651_probe(struct snd_soc_component *component)
 {
@@ -1762,6 +1761,7 @@ static const struct snd_soc_component_driver soc_component_dev_rt5651 = {
 	.suspend		= rt5651_suspend,
 	.resume			= rt5651_resume,
 	.set_bias_level		= rt5651_set_bias_level,
+	.set_jack		= rt5651_set_jack,
 	.controls		= rt5651_snd_controls,
 	.num_controls		= ARRAY_SIZE(rt5651_snd_controls),
 	.dapm_widgets		= rt5651_dapm_widgets,
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 8f128d057ff0..f3158488fc89 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2080,6 +2080,4 @@ struct rt5651_priv {
 	bool hp_mute;
 };
 
-int rt5651_set_jack_detect(struct snd_soc_component *component,
-			   struct snd_soc_jack *hp_jack);
 #endif /* __RT5651_H__ */
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index b6bf92191b9a..afb27e5e6756 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -370,7 +370,7 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	rt5651_set_jack_detect(codec, &priv->jack);
+	snd_soc_component_set_jack(codec, &priv->jack, NULL);
 
 	return ret;
 }
-- 
2.16.2
