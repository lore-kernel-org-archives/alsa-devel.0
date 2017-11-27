From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Add error checking to probe function" to the asoc tree
Date: Mon, 27 Nov 2017 18:52:50 +0000
Message-ID: <E1eJOWQ-00074W-Q2@debutante>
References: <1511238476-10314-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511238476-10314-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, Dominik Behr <dbehr@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.orgDominik Behr <dbehr@chromium.org>, linux-kernel@vger.kernel.orgDaniel Kurtz <djkurtz@chromium.org>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>Alex Deucher <alexander.deucher@amd.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Add error checking to probe function

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

>From fdaa451107ce543d345a339b4d5e20e8e4bac396 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Nov 2017 20:27:56 -0800
Subject: [PATCH] ASoC: amd: Add error checking to probe function

The acp_audio_dma does not perform sufficient error checking in its probe
function. This can result in crashes if a critical error path is
encountered.

Fixes: 7c31335a03b6a ("ASoC: AMD: add AMD ASoC ACP 2.x DMA driver")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dominik Behr <dbehr@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 9f521a55d610..b5e41df6bb3a 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1051,6 +1051,11 @@ static int acp_audio_probe(struct platform_device *pdev)
 	struct resource *res;
 	const u32 *pdata = pdev->dev.platform_data;
 
+	if (!pdata) {
+		dev_err(&pdev->dev, "Missing platform data\n");
+		return -ENODEV;
+	}
+
 	audio_drv_data = devm_kzalloc(&pdev->dev, sizeof(struct audio_drv_data),
 					GFP_KERNEL);
 	if (audio_drv_data == NULL)
@@ -1058,6 +1063,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	audio_drv_data->acp_mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(audio_drv_data->acp_mmio))
+		return PTR_ERR(audio_drv_data->acp_mmio);
 
 	/* The following members gets populated in device 'open'
 	 * function. Till then interrupts are disabled in 'acp_init'
-- 
2.15.0
