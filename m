From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: Make BE prepare possible in
	suspend state" to the asoc tree
Date: Thu, 29 Oct 2015 09:16:48 +0900
Message-ID: <E1Zratc-0006SQ-1r@finisterre>
References: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1952C265091
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 01:17:03 +0100 (CET)
In-Reply-To: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: Make BE prepare possible in suspend state

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

>From 0fa0697af79f5c8b080f7a1b8af87fe3b422e746 Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Wed, 28 Oct 2015 10:15:34 +0800
Subject: [PATCH] ASoC: dpcm: Make BE prepare possible in suspend state

During suspend/resume, there is a flow that if a driver does not support
SNDRV_PCM_INFO_RESUME, it will fail at snd_pcm_resume(), and user space
can then issue SNDRV_PCM_IOCTL_PREPARE to let audio continue to play.

However, in dpcm_be_dai_prepare() it only allows BEs to be prepared
in state SND_SOC_DPCM_STATE_HW_PARAMS or SND_SOC_DPCM_STATE_STOP.
The BE state will then stay in SND_SOC_DPCM_STATE_SUSPEND, consequently
dpcm_be_dai_shutdown() is skipped in the end of playback and
be_substream->runtime is not cleared while this runtime is actually freed
by snd_pcm_detach_substream(). If another suspend comes, a NULL pointer
dereference will happen in snd_pcm_suspend() when accessing
BE substream's runtime.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 70e4b9d..9cf33b8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2068,7 +2068,8 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
 			continue;
 
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
-- 
2.6.1
