From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Export snd_soc_dapm_new_control"
	to the asoc tree
Date: Tue, 05 Jul 2016 16:57:43 +0200
Message-ID: <E1bKRnD-0006Lk-Db@finisterre>
References: <1466999284-14782-11-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B72652651A3
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 16:58:12 +0200 (CEST)
In-Reply-To: <1466999284-14782-11-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, tiwai@suse.de, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Export snd_soc_dapm_new_control

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

>From a5d5639f812f24f10c7affaf0d537c204fdea986 Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 27 Jun 2016 09:18:03 +0530
Subject: [PATCH] ASoC: dapm: Export snd_soc_dapm_new_control

This is useful outside the core, when one dapm element is added
at a time.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 3 +++
 sound/soc/soc-dapm.c     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3101d53468aa..0efeb38ae059 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -382,6 +382,9 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num);
+struct snd_soc_dapm_widget *snd_soc_dapm_new_control(
+		struct snd_soc_dapm_context *dapm,
+		const struct snd_soc_dapm_widget *widget);
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c4464858bf01..cc8f480251e7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3282,6 +3282,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	mutex_unlock(&dapm->card->dapm_mutex);
 	return w;
 }
+EXPORT_SYMBOL_GPL(snd_soc_dapm_new_control);
 
 struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
-- 
2.8.1
