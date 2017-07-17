From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: do not close shared backend dailink" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:12 +0100
Message-ID: <E1dX8XE-00052d-Sn@debutante>
References: <1500099305-16438-1-git-send-email-plai@codeaurora.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1500099305-16438-1-git-send-email-plai@codeaurora.org>
Sender: stable-owner@vger.kernel.org
Cc: Gopikrishnaiah Anandan <agopik@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.orgGopikrishnaiah Anandan <agopik@codeaurora.org>Patrick Lai <plai@codeaurora.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: do not close shared backend dailink

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

>From b1cd2e34c69a2f3988786af451b6e17967c293a0 Mon Sep 17 00:00:00 2001
From: Banajit Goswami <bgoswami@codeaurora.org>
Date: Fri, 14 Jul 2017 23:15:05 -0700
Subject: [PATCH] ASoC: do not close shared backend dailink

Multiple frontend dailinks may be connected to a backend
dailink at the same time. When one of frontend dailinks is
closed, the associated backend dailink should not be closed
if it is connected to other active frontend dailinks. Change
ensures that backend dailink is closed only after all
connected frontend dailinks are closed.

Signed-off-by: Gopikrishnaiah Anandan <agopik@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Patrick Lai <plai@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index dcc5ece08668..93999b8a87d3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -181,6 +181,10 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
 		dev_dbg(be->dev, "ASoC: BE %s event %d dir %d\n",
 				be->dai_link->name, event, dir);
 
+		if ((event == SND_SOC_DAPM_STREAM_STOP) &&
+		    (be->dpcm[dir].users >= 1))
+			continue;
+
 		snd_soc_dapm_stream_event(be, dir, event);
 	}
 
-- 
2.13.2
