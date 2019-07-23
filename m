From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: use existing
	snd_soc_dai_digital_mute()" to the asoc tree
Date: Tue, 23 Jul 2019 18:18:50 +0100 (BST)
Message-ID: <20190723171850.854DA2742B60@ypsilon.sirena.org.uk>
References: <87ef2ihmzo.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2E3FF80227
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:52 +0200 (CEST)
In-Reply-To: <87ef2ihmzo.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: use existing snd_soc_dai_digital_mute()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 88fdffa2eef45fc9f6009ee590741c44a57c49c7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:36:27 +0900
Subject: [PATCH] ASoC: soc-core: use existing snd_soc_dai_digital_mute()

ALSA SoC already has snd_soc_dai_digital_mute() for digital_mute,
let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87ef2ihmzo.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 458b090f026a..7ecfe641ca46 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -487,10 +487,9 @@ int snd_soc_suspend(struct device *dev)
 			continue;
 
 		for_each_rtd_codec_dai(rtd, i, dai) {
-			struct snd_soc_dai_driver *drv = dai->driver;
-
-			if (drv->ops->digital_mute && dai->playback_active)
-				drv->ops->digital_mute(dai, 1);
+			if (dai->playback_active)
+				snd_soc_dai_digital_mute(dai, 1,
+						SNDRV_PCM_STREAM_PLAYBACK);
 		}
 	}
 
@@ -665,10 +664,9 @@ static void soc_resume_deferred(struct work_struct *work)
 			continue;
 
 		for_each_rtd_codec_dai(rtd, i, dai) {
-			struct snd_soc_dai_driver *drv = dai->driver;
-
-			if (drv->ops->digital_mute && dai->playback_active)
-				drv->ops->digital_mute(dai, 0);
+			if (dai->playback_active)
+				snd_soc_dai_digital_mute(dai, 0,
+						SNDRV_PCM_STREAM_PLAYBACK);
 		}
 	}
 
-- 
2.20.1
