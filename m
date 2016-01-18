From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v3 1/6] ASoC: fsl_ssi: Real hardware channels
	max number is 32
Date: Mon, 18 Jan 2016 16:26:06 +0100
Message-ID: <1453130771-24419-2-git-send-email-arnaud.mouiche@invoxia.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A1D260534
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 16:26:39 +0100 (CET)
Received: by mail-wm0-f41.google.com with SMTP id b14so128389467wmb.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 07:26:39 -0800 (PST)
In-Reply-To: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Caleb Crome <caleb@crome.org>
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
index 40dfd8a..cfc78b8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1167,14 +1167,14 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
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
