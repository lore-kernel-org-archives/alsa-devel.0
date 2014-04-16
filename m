From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 15/18] ASoC: osk5912: Use the same name for
	platform as the cpu_dai
Date: Wed, 16 Apr 2014 12:23:28 +0300
Message-ID: <1397640211-15447-16-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 18C4B26530B
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:24:13 +0200 (CEST)
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
 sound/soc/omap/osk5912.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index d03e57da7708..aa4053bf6710 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -96,7 +96,7 @@ static struct snd_soc_dai_link osk_dai = {
 	.stream_name = "AIC23",
 	.cpu_dai_name = "omap-mcbsp.1",
 	.codec_dai_name = "tlv320aic23-hifi",
-	.platform_name = "omap-pcm-audio",
+	.platform_name = "omap-mcbsp.1",
 	.codec_name = "tlv320aic23-codec",
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
-- 
1.9.2
