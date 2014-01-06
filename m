From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: atmel-pcm-dma: Remove
	SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
Date: Mon,  6 Jan 2014 15:30:29 +0100
Message-ID: <1389018629-11513-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id BB53A2610A8
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 15:30:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Elen Song <elen.song@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Since commit d48de6f1a ("DMA: AT91: Get residual bytes in dma buffer") the
at91-dma driver has support for residue reporting. So there is no need to
specify the SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag. This allows for a finer
grained resolution of the PCM pointer as well as avoids the race condition that
can occur with the period counting that is used when the dmaengine driver does
not support residue reporting.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
I don't have the hardware, so only compile tested. It should work though if the
residue calculation in the dma driver is implemented correctly.
---
 sound/soc/atmel/atmel-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 06082e5..ba1366a 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -129,8 +129,7 @@ static const struct snd_dmaengine_pcm_config atmel_dmaengine_pcm_config = {
 
 int atmel_pcm_dma_platform_register(struct device *dev)
 {
-	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
-			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
+	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config, 0);
 }
 EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
 
-- 
1.8.0
