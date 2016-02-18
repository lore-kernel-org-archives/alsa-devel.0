From: anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] Changed the if-else case to switch case
Date: Thu, 18 Feb 2016 10:36:20 -0800
Message-ID: <1455820580-26501-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 6187C2606A9
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 19:36:27 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id fy10so35181528pac.1
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 10:36:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 sound/soc/codecs/max9867.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index b9d989f..5a8481b 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -212,16 +212,22 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		switch (snd_pcm_format_width(params_format(params))) {
 		case 8:
 		case 16:
-			if (pclk_bclk_ratio == 2)
+			switch (pclk_bclk_ratio) {
+			case 2:
 				bclk_value = MAX9867_IFC1B_PCLK_2;
-			else if (pclk_bclk_ratio == 4)
+				break;
+			case 4:
 				bclk_value = MAX9867_IFC1B_PCLK_4;
-			else if (pclk_bclk_ratio == 8)
+				break;
+			case 8:
 				bclk_value = MAX9867_IFC1B_PCLK_8;
-			else if (pclk_bclk_ratio == 16)
+				break;
+			case 16:
 				bclk_value = MAX9867_IFC1B_PCLK_16;
-			else {
-				dev_err(codec->dev, "unsupported sampling rate\n");
+				break;
+			default:
+				dev_err(codec->dev,
+					"unsupported sampling rate\n");
 				return -EINVAL;
 			}
 			break;
-- 
1.9.3
