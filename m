From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 13/20] ASoC: am3517evm: Use the same name
	for platform as the cpu_dai
Date: Wed, 16 Apr 2014 15:46:23 +0300
Message-ID: <1397652390-852-14-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 59FD42654AC
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:47:09 +0200 (CEST)
In-Reply-To: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that the platform driver is registered with the cpu_dai's device we
can use the same name for it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/am3517evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index 994dcf345975..25a33e9d417a 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -77,7 +77,7 @@ static struct snd_soc_dai_link am3517evm_dai = {
 	.stream_name = "AIC23",
 	.cpu_dai_name = "omap-mcbsp.1",
 	.codec_dai_name = "tlv320aic23-hifi",
-	.platform_name = "omap-pcm-audio",
+	.platform_name = "omap-mcbsp.1",
 	.codec_name = "tlv320aic23-codec.2-001a",
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
-- 
1.9.2
