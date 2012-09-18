From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/2] ASoC: fsl_ssi: Let it understand mono
Date: Tue, 18 Sep 2012 13:03:53 -0300
Message-ID: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 by alsa0.perex.cz (Postfix) with ESMTP id C5BD82650CC
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 18:04:16 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@freescale.com, javier.martin@vista-silicon.com
List-Id: alsa-devel@alsa-project.org

Currently there are two variants for the FSL SSI driver:

- fsl_ssi.c is the device tree driver version for the FSL SSI driver
(used by PowerPC and i.MX)

- imx-ssi.c is the non device tree version that runs on some i.MX processors that
are not yet converted to dt.

Commit 0865a7 (ASoC: imx-ssi: Remove mono support) attempted to fix mono audio 
playback issue inside imx-ssi.c, which according to 104c22 
(ASoC: Revert 'ASoC: imx-ssi: Remove mono support' ) caused problem on another 
i.MX platform.

The original mono playback issue was later fixed inside the mc13783 codec driver.

As the long term goal is to move other platforms to dt, then fsl_ssi needs to 
have the same fix for channels_min as in imx-ssi.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Timur,

Can you please try to play a mono track on your PowerPC platform with these 
series applied?

 sound/soc/fsl/fsl_ssi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4ed2afd..7768b93 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -559,14 +559,13 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 /* Template for the CPU dai driver structure */
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.playback = {
-		/* The SSI does not support monaural audio. */
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
 	.capture = {
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
-- 
1.7.9.5
