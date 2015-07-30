From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm8741: Simplify wm8741_set_dai_sysclk
	implementation
Date: Thu, 30 Jul 2015 10:24:03 +0800
Message-ID: <1438223043.17273.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 19402260687
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 04:24:10 +0200 (CEST)
Received: by pdbnt7 with SMTP id nt7so15759300pdb.0
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 19:24:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm8741.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 430fa7d..9723e44 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -278,51 +278,38 @@ static int wm8741_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	switch (freq) {
 	case 0:
 		wm8741->sysclk_constraints = NULL;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 11289600:
 		wm8741->sysclk_constraints = &constraints_11289;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 12288000:
 		wm8741->sysclk_constraints = &constraints_12288;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 16384000:
 		wm8741->sysclk_constraints = &constraints_16384;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 16934400:
 		wm8741->sysclk_constraints = &constraints_16934;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 18432000:
 		wm8741->sysclk_constraints = &constraints_18432;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 22579200:
 	case 33868800:
 		wm8741->sysclk_constraints = &constraints_22579;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 24576000:
 		wm8741->sysclk_constraints = &constraints_24576;
-		wm8741->sysclk = freq;
-		return 0;
-
+		break;
 	case 36864000:
 		wm8741->sysclk_constraints = &constraints_36864;
-		wm8741->sysclk = freq;
-		return 0;
+		break;
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
+
+	wm8741->sysclk = freq;
+	return 0;
 }
 
 static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
-- 
2.1.0
