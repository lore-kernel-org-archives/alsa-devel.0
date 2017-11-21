From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ASoC: amd: Add error checking to probe function
Date: Mon, 20 Nov 2017 20:27:56 -0800
Message-ID: <1511238476-10314-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 0104B267096
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 05:28:10 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id 4so9204795pge.1
 for <alsa-devel@alsa-project.org>; Mon, 20 Nov 2017 20:28:10 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Dominik Behr <dbehr@chromium.org>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

The acp_audio_dma does not perform sufficient error checking in its probe
function. This can result in crashes if a critical error path is
encountered.

Fixes: 7c31335a03b6a ("ASoC: AMD: add AMD ASoC ACP 2.x DMA driver")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Dominik Behr <dbehr@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I didn't add an error check to acp_init() since I was not sure if
its return value is ignored on purpose.

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
2.7.4
