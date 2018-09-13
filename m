From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: hisilicon: fix fall-through annotations
Date: Thu, 13 Sep 2018 14:11:07 -0500
Message-ID: <20180913191107.GA11390@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com
 [192.185.146.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 7801D2677BB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 21:11:37 +0200 (CEST)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id 6B016145036
 for <alsa-devel@alsa-project.org>;
 Thu, 13 Sep 2018 14:11:35 -0500 (CDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/hisilicon/hi6210-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 53344a3..a69e5b11 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -269,13 +269,13 @@ static int hi6210_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U16_LE:
 		signed_data = HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_FORMAT_S16_LE:
 		bits = HII2S_BITS_16;
 		break;
 	case SNDRV_PCM_FORMAT_U24_LE:
 		signed_data = HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_FORMAT_S24_LE:
 		bits = HII2S_BITS_24;
 		break;
-- 
2.7.4
