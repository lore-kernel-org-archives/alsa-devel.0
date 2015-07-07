From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: gtm601: Constify soc_codec_dev_gtm601
Date: Tue, 07 Jul 2015 12:57:19 +0800
Message-ID: <1436245039.1605.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D9542612BD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 06:57:24 +0200 (CEST)
Received: by pactm7 with SMTP id tm7so106648691pac.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 21:57:24 -0700 (PDT)
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
Cc: Marek Belisko <marek@goldelico.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Also clean up the code a bit by fixing indent.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/gtm601.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index 12d15e5..0b80052 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -51,7 +51,7 @@ static struct snd_soc_dai_driver gtm601_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_gtm601 = {
+static const struct snd_soc_codec_driver soc_codec_dev_gtm601 = {
 	.dapm_widgets = gtm601_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(gtm601_dapm_widgets),
 	.dapm_routes = gtm601_dapm_routes,
@@ -80,10 +80,9 @@ MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
 
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
-			.name = "gtm601",
-			.of_match_table = of_match_ptr(gtm601_codec_of_match),
+		.name = "gtm601",
+		.of_match_table = of_match_ptr(gtm601_codec_of_match),
 	},
-
 	.probe = gtm601_platform_probe,
 	.remove = gtm601_platform_remove,
 };
-- 
2.1.0
