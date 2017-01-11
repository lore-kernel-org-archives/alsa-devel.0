From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] ASoC: rt5651: use msleep for large delays
Date: Wed, 11 Jan 2017 20:45:31 +0100
Message-ID: <1484163931-28170-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

ulseep_range() uses hrtimers and provides no advantage over msleep()
for larger delays. Fix up the 70/80ms delays here to use msleep() and
reduce the load on the hrtimer subsystem.

Link: http://lkml.org/lkml/2017/1/11/377
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

V2: Mark Brown <broonie@kernel.org> suggested to take the lower time
    stamp for such conversions as this is the behavior developers 
    expect rather than the upper that would be closer to the current
    (somewhat odd) usleep_range() behavior.

As these are non-atomic regions and a delay of 70/80 ms implies that
there is almost certainty multiple context switches occurring in the
sleep time and thus relatively high jitter must be assumed with
respect to actual wakeup time implying that there is little point in
using high-resolution timers here.

Patch was compile tested with: x86_64_defconfig + SND_SOC=m
SND_SOC_INTEL_BYTCR_RT5651_MACH=m (implies CONFIG_SND_SOC_RT5651)

Patch is aginast 4.10-rc3 (localversion-next is next-20170111)

 sound/soc/codecs/rt5651.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f5d3415..fb592b0 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -802,7 +802,7 @@ static int rt5651_hp_event(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_PRE_PMD:
 		rt5651->hp_mute = 1;
-		usleep_range(70000, 75000);
+		msleep(70);
 		break;
 
 	default:
@@ -822,7 +822,7 @@ static int rt5651_hp_post_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		if (!rt5651->hp_mute)
-			usleep_range(80000, 85000);
+			msleep(80);
 
 		break;
 
-- 
2.1.4
