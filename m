From: Nicholas Mc Guire <hofrat@opentech.at>
Subject: [PATCH] ASoC: ab8500: add range to usleep_range
Date: Sun,  7 Apr 2019 04:59:34 +0200
Message-ID: <1554605974-25481-1-git-send-email-hofrat@opentech.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@opentech.at>
List-Id: alsa-devel@alsa-project.org

Providing a range for usleep_range() allows the hrtimer subsystem to 
coalesce timers - as this delay has no upper limit anyway (interrupts
or context switch is possible) it should not hurt to extend this
from 2 to 2-4 milliseconds.

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
---

Problem located with an experimental coccinelle script

Basically usleep_range() with min == max never makes much sense notably
in non-atomic context.

Patch was compile tested with: u8500_defconfig (implies CONFIG_SND_SOC_AB8500_CODEC=y)
(with some sparse warnings about not implemented system calls)

Patch is against 5.1-rc3 (localversion-next is next=20190405)

 sound/soc/codecs/ab8500-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 87616b1..19e7f03 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1062,10 +1062,10 @@ static void anc_iir(struct snd_soc_component *component, unsigned int bnk,
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRINIT),
 					BIT(AB8500_ANCCONF1_ANCIIRINIT));
-			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY*2);
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRINIT), 0);
-			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY*2);
 		} else {
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRUPDATE),
-- 
2.1.4
