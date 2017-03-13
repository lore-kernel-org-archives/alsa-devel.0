From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't dereference NULL pcm_{new,
	free}" to the asoc tree
Date: Mon, 13 Mar 2017 13:19:49 +0100
Message-ID: <E1cnOx3-0001rb-M5@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C154C266E42
 for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2017 14:06:35 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Norris <briannorris@chromium.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't dereference NULL pcm_{new,free}

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

>From d6c098a1db468b7fd4635e831f276851dfd8852c Mon Sep 17 00:00:00 2001
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 8 Mar 2017 15:18:54 -0800
Subject: [PATCH] ASoC: don't dereference NULL pcm_{new,free}

Not all platform drivers have pcm_{new,free} callbacks. Seen with a
"snd-soc-dummy" codec from sound/soc/rockchip/rk3399_gru_sound.c.

Fixes: 99b04f4c4051 ("ASoC: add Component level pcm_new/pcm_free")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6dca408faae3..2722bb0c5573 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3326,7 +3326,10 @@ static int snd_soc_platform_drv_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_platform *platform = rtd->platform;
 
-	return platform->driver->pcm_new(rtd);
+	if (platform->driver->pcm_new)
+		return platform->driver->pcm_new(rtd);
+	else
+		return 0;
 }
 
 static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
@@ -3334,7 +3337,8 @@ static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
 	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 
-	platform->driver->pcm_free(pcm);
+	if (platform->driver->pcm_free)
+		platform->driver->pcm_free(pcm);
 }
 
 /**
-- 
2.11.0
