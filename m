From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: fix sai driver name initialisation" to the asoc tree
Date: Mon,  8 Apr 2019 14:29:59 +0700 (+07)
Message-ID: <20190408072959.F0485441D3C@finisterre.ee.mobilebroadband>
References: <1554455951-2755-1-git-send-email-arnaud.pouliquen@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554455951-2755-1-git-send-email-arnaud.pouliquen@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgMark Brown <broonie@kernel.org>, Liam@sirena.org.uk, Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi@sirena.org.uk, Iwai <tiwai@suse.com>, arnaud.pouliquen@st.com, Olivier Moysan <olivier.moysan@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: fix sai driver name initialisation

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

>From 17d3069ccf06970e2db3f7cbf4335f207524279e Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Fri, 5 Apr 2019 11:19:11 +0200
Subject: [PATCH] ASoC: stm32: fix sai driver name initialisation

This patch fixes the sai driver structure overwriting which results in
a cpu dai name equal NULL.

Fixes: 3e086ed ("ASoC: stm32: add SAI driver")

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 55d802f51c15..83d8a7ac56f4 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1419,7 +1419,6 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 	if (!sai->cpu_dai_drv)
 		return -ENOMEM;
 
-	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 	if (STM_SAI_IS_PLAYBACK(sai)) {
 		memcpy(sai->cpu_dai_drv, &stm32_sai_playback_dai,
 		       sizeof(stm32_sai_playback_dai));
@@ -1429,6 +1428,7 @@ static int stm32_sai_sub_dais_init(struct platform_device *pdev,
 		       sizeof(stm32_sai_capture_dai));
 		sai->cpu_dai_drv->capture.stream_name = sai->cpu_dai_drv->name;
 	}
+	sai->cpu_dai_drv->name = dev_name(&pdev->dev);
 
 	return 0;
 }
-- 
2.20.1
