From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/3] ASoC: ux500_pcm: Differentiate between
	pdata and DT initialisation
Date: Mon,  2 Dec 2013 18:00:21 +0000
Message-ID: <1386007222-10081-2-git-send-email-lee.jones@linaro.org>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D76F4264F2D
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 19:00:31 +0100 (CET)
Received: by mail-ie0-f169.google.com with SMTP id e14so21479950iej.14
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 10:00:31 -0800 (PST)
In-Reply-To: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, broonie@kernel.org, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

If booting with full DT support (i.e. DMA too, the last piece of the
puzzle), then we don't need to use the compatible request channel call
back. We also require slightly different flags to inform the core that
we are booting with DT.

Cc: alsa-devel@alsa-project.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_pcm.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 2f1bdb7..00cdd7b 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -134,15 +134,31 @@ static const struct snd_dmaengine_pcm_config ux500_dmaengine_pcm_config = {
 	.prepare_slave_config = ux500_pcm_prepare_slave_config,
 };
 
+static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
+	.prepare_slave_config = ux500_pcm_prepare_slave_config,
+};
+
 int ux500_pcm_register_platform(struct platform_device *pdev)
 {
+	const struct snd_dmaengine_pcm_config *pcm_config;
+	struct device_node *np = pdev->dev.of_node;
+	unsigned int pcm_flags;
 	int ret;
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev,
-			&ux500_dmaengine_pcm_config,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
-			SND_DMAENGINE_PCM_FLAG_COMPAT |
-			SND_DMAENGINE_PCM_FLAG_NO_DT);
+	if (np) {
+		pcm_config = &ux500_dmaengine_of_pcm_config;
+
+		pcm_flags = SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+			SND_DMAENGINE_PCM_FLAG_COMPAT;
+	} else {
+		pcm_config = &ux500_dmaengine_pcm_config;
+
+		pcm_flags = SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+			SND_DMAENGINE_PCM_FLAG_NO_DT |
+			SND_DMAENGINE_PCM_FLAG_COMPAT;
+	}
+
+	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config, pcm_flags);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
-- 
1.8.3.2
