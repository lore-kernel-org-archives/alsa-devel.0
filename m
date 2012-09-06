From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: Revert 'ASoC: imx-ssi: Remove mono
	support'
Date: Wed,  5 Sep 2012 21:30:10 -0300
Message-ID: <1346891410-4379-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 53C77264F53
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 02:30:20 +0200 (CEST)
Received: by ghbg2 with SMTP id g2so208861ghb.38
 for <alsa-devel@alsa-project.org>; Wed, 05 Sep 2012 17:30:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

From: Javier Martin <javier.martin@vista-silicon.com>

Revert 0865a75(ASoC: imx-ssi: Remove mono support).

The bug this patch is meant to solve doesn't occur in Visstrim_M10 boards.
Furthermore, after applying this patch sound in Visstrim_M10 is played
at slower rates.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/fsl/imx-ssi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 7074ae6..3c520c4 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -380,14 +380,13 @@ static int imx_ssi_dai_probe(struct snd_soc_dai *dai)
 static struct snd_soc_dai_driver imx_ssi_dai = {
 	.probe = imx_ssi_dai_probe,
 	.playback = {
-		/* The SSI does not support monaural audio. */
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
1.7.9.5
