From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-twl4030: Fix typo in 2nd dai link's
	platform_name
Date: Fri, 29 Aug 2014 13:30:23 +0300
Message-ID: <1409308223-14281-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 04F922668F9
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 12:30:32 +0200 (CEST)
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
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The platform_name should be omap-mcasp3 for the 2nd link which is used for
voice connection.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-twl4030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index f8a6adc2d81c..4336d1831485 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -260,7 +260,7 @@ static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 		.stream_name = "TWL4030 Voice",
 		.cpu_dai_name = "omap-mcbsp.3",
 		.codec_dai_name = "twl4030-voice",
-		.platform_name = "omap-mcbsp.2",
+		.platform_name = "omap-mcbsp.3",
 		.codec_name = "twl4030-codec",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF |
 			   SND_SOC_DAIFMT_CBM_CFM,
-- 
2.0.4
