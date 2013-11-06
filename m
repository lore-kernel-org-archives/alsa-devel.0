From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 08/13] ASoC: generic-dmaengine-pcm: Clear
	slave_config memory
Date: Wed,  6 Nov 2013 10:16:20 +0000
Message-ID: <1383732985-18928-9-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A30ED261689
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:17:02 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id aq17so16975365iec.38
 for <alsa-devel@alsa-project.org>; Wed, 06 Nov 2013 02:17:01 -0800 (PST)
In-Reply-To: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
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
Cc: linus.walleij@linaro.org, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We currently assume that the DMA Slave Config will be fully populated
by the platform, however some DMA Engines make decisions based on zero
(default) flags such as DMA_SLAVE_BUSWIDTH_UNDEFINED and as this is a
static declaration we need to memset it to clear the data area.

Cc: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index ee07903..6ad4c7a 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -90,6 +90,8 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct dma_slave_config slave_config;
 	int ret;
 
+	memset(&slave_config, 0, sizeof(slave_config));
+
 	if (!pcm->config)
 		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
 	else
-- 
1.8.1.2
