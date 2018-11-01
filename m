From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH] ASoC: core: Invoke pcm_new() for all DAI-link
Date: Thu,  1 Nov 2018 18:08:49 +0530
Message-ID: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Remove no_pcm check to invoke pcm_new() for backend dai-links
too. This fixes crash in hdmi codec driver during hdmi_codec_startup()
while accessing chmap_info struct. chmap_info struct memory is
allocated in pcm_new() of hdmi codec driver which is not invoked
in case of DPCM when hdmi codec driver is part of backend dai-link.

Below is the crash stack:

[   61.635493] Unable to handle kernel NULL pointer dereference at virtual address 00000018
..
[   61.666696]   CM = 0, WnR = 1
[   61.669778] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffc0d6633000
[   61.676526] [0000000000000018] *pgd=0000000153fc8003, *pud=0000000153fc8003, *pmd=0000000000000000
[   61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP
[   61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21
..
[   61.740269] PC is at hdmi_codec_startup+0x124/0x164
[   61.745308] LR is at hdmi_codec_startup+0xe4/0x164

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6ddcf12..abdc460 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1467,7 +1467,7 @@ static int soc_link_dai_pcm_new(struct snd_soc_dai **dais, int num_dais,
 	for (i = 0; i < num_dais; ++i) {
 		struct snd_soc_dai_driver *drv = dais[i]->driver;
 
-		if (!rtd->dai_link->no_pcm && drv->pcm_new)
+		if (drv->pcm_new)
 			ret = drv->pcm_new(rtd, dais[i]);
 		if (ret < 0) {
 			dev_err(dais[i]->dev,
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
