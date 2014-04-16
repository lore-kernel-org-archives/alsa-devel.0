From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 16/20] ASoC: omap3pandora: Use the same name
	for platform as the cpu_dai
Date: Wed, 16 Apr 2014 15:46:26 +0300
Message-ID: <1397652390-852-17-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 287C926533D
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:47:17 +0200 (CEST)
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
 sound/soc/omap/omap3pandora.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 02181bb70400..076bec606d78 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -197,7 +197,7 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 		.stream_name = "HiFi Out",
 		.cpu_dai_name = "omap-mcbsp.2",
 		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-pcm-audio",
+		.platform_name = "omap-mcbsp.2",
 		.codec_name = "twl4030-codec",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
@@ -208,7 +208,7 @@ static struct snd_soc_dai_link omap3pandora_dai[] = {
 		.stream_name = "Line/Mic In",
 		.cpu_dai_name = "omap-mcbsp.4",
 		.codec_dai_name = "twl4030-hifi",
-		.platform_name = "omap-pcm-audio",
+		.platform_name = "omap-mcbsp.4",
 		.codec_name = "twl4030-codec",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
-- 
1.9.2
