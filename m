From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Cosmetic tidy up of
	snd_soc_dapm_new_control" to the asoc tree
Date: Thu,  6 Sep 2018 11:49:04 +0100 (BST)
Message-ID: <20180906104904.6F2A71122A1F@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B670267830
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:49:04 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Cosmetic tidy up of snd_soc_dapm_new_control

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

>From 94e630a35d3383b42f12a873a5404bdf61e38e42 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 5 Sep 2018 15:20:59 +0100
Subject: [PATCH] ASoC: dapm: Cosmetic tidy up of snd_soc_dapm_new_control

Move the function snd_soc_dapm_new_control to be next to
snd_soc_dapm_new_controls and add some kernel doc for it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d13a25ce1275..c111e69b9a09 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3417,20 +3417,6 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
-struct snd_soc_dapm_widget *
-snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
-	const struct snd_soc_dapm_widget *widget)
-{
-	struct snd_soc_dapm_widget *w;
-
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
-	mutex_unlock(&dapm->card->dapm_mutex);
-
-	return w;
-}
-EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
-
 struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget)
@@ -3570,6 +3556,29 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	return ERR_PTR(ret);
 }
 
+/**
+ * snd_soc_dapm_new_control - create new dapm control
+ * @dapm: DAPM context
+ * @widget: widget template
+ *
+ * Creates new DAPM control based upon a template.
+ *
+ * Returns a widget pointer on success or an error pointer on failure
+ */
+struct snd_soc_dapm_widget *
+snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
+			 const struct snd_soc_dapm_widget *widget)
+{
+	struct snd_soc_dapm_widget *w;
+
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
+	w = snd_soc_dapm_new_control_unlocked(dapm, widget);
+	mutex_unlock(&dapm->card->dapm_mutex);
+
+	return w;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
+
 /**
  * snd_soc_dapm_new_controls - create new dapm controls
  * @dapm: DAPM context
-- 
2.19.0.rc1
