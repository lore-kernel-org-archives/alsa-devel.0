From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/18] ASoC: n810: Use the same name for
	platform as the cpu_dai
Date: Wed, 16 Apr 2014 12:23:26 +0300
Message-ID: <1397640211-15447-14-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F3457265055
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:24:08 +0200 (CEST)
In-Reply-To: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that the platform driver is registered with the cpu_dai's device we
can use the same name for it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/n810.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index fd4d9c809e50..5d7f9cebe041 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -278,7 +278,7 @@ static struct snd_soc_dai_link n810_dai = {
 	.name = "TLV320AIC33",
 	.stream_name = "AIC33",
 	.cpu_dai_name = "omap-mcbsp.2",
-	.platform_name = "omap-pcm-audio",
+	.platform_name = "omap-mcbsp.2",
 	.codec_name = "tlv320aic3x-codec.2-0018",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-- 
1.9.2
