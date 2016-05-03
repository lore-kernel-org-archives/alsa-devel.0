From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH v4 1/6] ASoC: fsl_ssi: Real hardware channels
	max number is 32
Date: Tue,  3 May 2016 14:13:55 +0200
Message-ID: <1462277640-20052-2-git-send-email-arnaud.mouiche@invoxia.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AAAD126655C
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 14:14:09 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id a17so35465737wme.0
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 05:14:09 -0700 (PDT)
In-Reply-To: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, festevam@gmail.com, caleb@crome.org
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
index 08dcbbf..472141f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1159,14 +1159,14 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
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
