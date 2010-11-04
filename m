From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 7/7] ASoC: i.MX: we can do mono
Date: Thu,  4 Nov 2010 17:05:45 +0100
Message-ID: <1288886745-25977-8-git-send-email-s.hauer@pengutronix.de>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CBFEC10389D
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 17:05:48 +0100 (CET)
In-Reply-To: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Whether we can do mono or not depends on the codec. No need
to limit this in the ssi driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-ssi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index d2d98c7..ad21f81 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -456,13 +456,13 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver imx_ssi_dai = {
 	.probe = imx_ssi_dai_probe,
 	.playback = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_96000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-- 
1.7.2.3
