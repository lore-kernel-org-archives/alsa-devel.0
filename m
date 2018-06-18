From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Add NULL pointer check" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:26 +0100
Message-ID: <E1fUspe-0000H5-Il@debutante>
References: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.orgMark Brown <broonie@kernel.org>, "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>akshu.agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Add NULL pointer check

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

>From 6e56e5d04191aa20e08430dcb203c081fa247e93 Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Thu, 7 Jun 2018 14:48:43 +0800
Subject: [PATCH] ASoC: AMD: Add NULL pointer check

Fix crash in those platforms whose machine driver does not expose
platform_info. For those platforms we rely on default value and
select I2SSP channel.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 77203841c535..1458b5048498 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -773,7 +773,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
-	rtd->i2s_instance = pinfo->i2s_instance;
+	if (pinfo)
+		rtd->i2s_instance = pinfo->i2s_instance;
 	if (adata->asic_type == CHIP_STONEY) {
 		val = acp_reg_read(adata->acp_mmio,
 				   mmACP_I2S_16BIT_RESOLUTION_EN);
-- 
2.17.1
