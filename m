From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/5] ALSA: pcm_dmaengine: Use the available
	wrapper to get physical width
Date: Wed, 2 Jul 2014 16:29:20 +0300
Message-ID: <1404307763-30557-3-git-send-email-peter.ujfalusi@ti.com>
References: <1404307763-30557-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ADFC265151
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 15:29:36 +0200 (CEST)
In-Reply-To: <1404307763-30557-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, lars@metafoo.de, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

params_physical_width() is available via pcm_params.h

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/core/pcm_dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 76cbb9ec953a..d5611ec80381 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -65,7 +65,7 @@ int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
 	enum dma_slave_buswidth buswidth;
 	int bits;
 
-	bits = snd_pcm_format_physical_width(params_format(params));
+	bits = params_physical_width(params);
 	if (bits < 8 || bits > 64)
 		return -EINVAL;
 	else if (bits == 8)
-- 
2.0.0
