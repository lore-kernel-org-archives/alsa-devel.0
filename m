From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: Avoid putting stream state to
	STOP when FE stream is paused" to the asoc tree
Date: Mon, 09 Jan 2017 20:01:46 +0000
Message-ID: <E1cQg8Y-0006yA-S4@debutante>
References: <1483253079-7978-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DDC27266EE9
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 21:01:52 +0100 (CET)
In-Reply-To: <1483253079-7978-1-git-send-email-plai@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: bgoswami@codeaurora.org, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: Avoid putting stream state to STOP when FE stream is paused

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

>From 9f169b9f52a4afccdab7a7d2311b0c53a78a1e6b Mon Sep 17 00:00:00 2001
From: Patrick Lai <plai@codeaurora.org>
Date: Sat, 31 Dec 2016 22:44:39 -0800
Subject: [PATCH] ASoC: dpcm: Avoid putting stream state to STOP when FE stream
 is paused

When multiple front-ends are using the same back-end, putting state of a
front-end to STOP state upon receiving pause command will result in backend
stream getting released by DPCM framework unintentionally. In order to
avoid backend to be released when another active front-end stream is
present, put the stream state to PAUSED state instead of STOP state.

Signed-off-by: Patrick Lai <plai@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e7a1eaa2772f..6aba14009c92 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2184,9 +2184,11 @@ static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
+		break;
 	}
 
 out:
-- 
2.11.0
