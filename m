From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: rt5640: use msleep() for long delays
Date: Thu, 12 Jan 2017 13:09:41 +0100
Message-ID: <1484222981-31335-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

ulseep_range() uses hrtimers and provides no advantage over msleep()
for larger delays. Fix up the 70/80ms delays here passing the "min" 
value to msleep(). This reduces the load on the hrtimer subsystem.

Link: http://lkml.org/lkml/2017/1/11/377
Fixes: commit 246693ba7b0b ("ASoC: rt5640: change widget sequence for depop")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located by coccinelle script

Patch was compile tested with: x86_64_defconfig + SND_SOC=m
SND_SOC_INTEL_BYTCR_RT5640_MACH=m (implies CONFIG_SND_SOC_RT5640)

Patch is aginast 4.10-rc3 (localversion-next is next-20170112)

 sound/soc/codecs/rt5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0f1b216..33e080f 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -995,7 +995,7 @@ static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_PRE_PMD:
 		rt5640->hp_mute = 1;
-		usleep_range(70000, 75000);
+		msleep(70);
 		break;
 
 	default:
@@ -1059,7 +1059,7 @@ static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		if (!rt5640->hp_mute)
-			usleep_range(80000, 85000);
+			msleep(80);
 
 		break;
 
-- 
2.1.4
