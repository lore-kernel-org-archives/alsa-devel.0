From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ASoC: Keep index within stac9766_reg[]
Date: Mon, 13 Jul 2009 02:17:21 +0200
Message-ID: <4A5A7D11.5000004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com
	[209.85.219.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 01E971037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jul 2009 02:15:53 +0200 (CEST)
Received: by ewy26 with SMTP id 26so2024450ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2009 17:15:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Keep index within stac9766_reg[]

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 8ad4b7b..11f467e 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -149,7 +149,7 @@ static int stac9766_ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 		stac9766_ac97_write(codec, AC97_INT_PAGING, 1);
 		return 0;
 	}
-	if (reg / 2 > ARRAY_SIZE(stac9766_reg))
+	if (reg / 2 >= ARRAY_SIZE(stac9766_reg))
 		return -EIO;
 
 	soc_ac97_ops.write(codec->ac97, reg, val);
