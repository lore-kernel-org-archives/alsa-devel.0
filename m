From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 6/6] ASoC: samsung: Remove
	SND_DMAENGINE_PCM_FLAG_NO_RESIDUE flag
Date: Sat, 11 Jan 2014 14:02:21 +0100
Message-ID: <1389445341-17227-7-git-send-email-lars@metafoo.de>
References: <1389445341-17227-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id DE971261A9B
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 14:02:04 +0100 (CET)
In-Reply-To: <1389445341-17227-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The Samsung dmaengine ASoC driver is used with two different dmaengine drivers.
The pl80x, which properly supports residue reporting and the pl330, which
reports that it does not support residue reporting. So there is no need to
manually set the NO_RESIDUE flag. This has the advantage that a proper (race
condition free) PCM pointer() implementation is used when the pl80x driver is
used. Also once the pl330 driver supports residue reporting the ASoC PCM driver
will automatically start using it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v2
New in v2
---
 sound/soc/samsung/dmaengine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 3be479d..750ce58 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -68,7 +68,6 @@ int samsung_asoc_dma_platform_register(struct device *dev)
 {
 	return snd_dmaengine_pcm_register(dev, &samsung_dmaengine_pcm_config,
 					  SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME |
-					  SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 					  SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 EXPORT_SYMBOL_GPL(samsung_asoc_dma_platform_register);
-- 
1.8.0
