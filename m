From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Invoke pcm_new() for all
	DAI-link" to the asoc tree
Date: Thu, 13 Dec 2018 18:10:57 +0000 (GMT)
Message-ID: <20181213181057.62C0011254D1@debutante.sirena.org.uk>
References: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5526226789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 19:10:59 +0100 (CET)
In-Reply-To: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Invoke pcm_new() for all DAI-link

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

>From de17f14ea576d8a0f2932404467fa916542da94d Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Thu, 1 Nov 2018 18:08:49 +0530
Subject: [PATCH] ASoC: core: Invoke pcm_new() for all DAI-link

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b0db59e6339d..0462b3ec977a 100644
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
2.19.0.rc2
