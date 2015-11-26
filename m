From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v2 1/6] ASoC: fsl_ssi: Real hardware channels
	max number is 32
Date: Thu, 26 Nov 2015 16:05:36 +0100
Message-ID: <1448550341-11765-2-git-send-email-arnaud.mouiche@invoxia.com>
References: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6EA2617E0
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 16:06:10 +0100 (CET)
Received: by wmvv187 with SMTP id v187so35374722wmv.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 07:06:10 -0800 (PST)
In-Reply-To: <1448550341-11765-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>, Roberto Fichera <kernel@tekno-soft.it>, Markus Pargmann <mpa@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

The max number of slots in TDM mode is 32:
- Frame Rate Divider Control is a 5bit value
- Time slot mask registers control 32 slots.

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 37c5cd4..4e5d7db 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1084,14 +1084,14 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.playback = {
 		.stream_name = "CPU-Playback",
 		.channels_min = 1,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
 	.capture = {
 		.stream_name = "CPU-Capture",
 		.channels_min = 1,
-		.channels_max = 2,
+		.channels_max = 32,
 		.rates = FSLSSI_I2S_RATES,
 		.formats = FSLSSI_I2S_FORMATS,
 	},
-- 
1.9.1
