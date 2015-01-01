From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/21] ASoC: ams-delta: Use static DAI format
	setup
Date: Thu,  1 Jan 2015 17:16:16 +0100
Message-ID: <1420128990-6872-8-git-send-email-lars@metafoo.de>
References: <1420128990-6872-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id D49962604B1
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 17:16:43 +0100 (CET)
In-Reply-To: <1420128990-6872-1-git-send-email-lars@metafoo.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Sangbeom Kim <sbkim73@samsung.com>, Denis Carikli <denis@eukrea.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Set the dai_fmt field in the dai_link struct instead of manually calling
snd_soc_dai_fmt(). This makes the code cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/ams-delta.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 4c6afb7..7066130 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -412,21 +412,7 @@ static struct tty_ldisc_ops cx81801_ops = {
  * over the modem port.
  */
 
-static int ams_delta_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	/* Set cpu DAI configuration */
-	return snd_soc_dai_set_fmt(rtd->cpu_dai,
-				   SND_SOC_DAIFMT_DSP_A |
-				   SND_SOC_DAIFMT_NB_NF |
-				   SND_SOC_DAIFMT_CBM_CFM);
-}
-
-static struct snd_soc_ops ams_delta_ops = {
-	.hw_params = ams_delta_hw_params,
-};
+static struct snd_soc_ops ams_delta_ops;
 
 
 /* Digital mute implemented using modem/CPU multiplexer.
@@ -546,6 +532,8 @@ static struct snd_soc_dai_link ams_delta_dai_link = {
 	.platform_name = "omap-mcbsp.1",
 	.codec_name = "cx20442-codec",
 	.ops = &ams_delta_ops,
+	.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 };
 
 /* Audio card driver */
-- 
1.8.0
