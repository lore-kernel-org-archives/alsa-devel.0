From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: gtm601: Remove .owner field from
	platform driver
Date: Wed, 24 Jun 2015 10:56:31 +0800
Message-ID: <1435114591.2082.2.camel@ingics.com>
References: <1435114524.2082.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id F17252657C6
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 04:56:37 +0200 (CEST)
Received: by pactm7 with SMTP id tm7so19328590pac.2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 19:56:36 -0700 (PDT)
In-Reply-To: <1435114524.2082.1.camel@ingics.com>
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

Remove .owner field because the core will set it.
Also clean up the code a bit to fix indent and make soc_codec_dev_gtm601
const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/gtm601.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index a696e3e..a652f19 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -51,7 +51,7 @@ struct snd_soc_dai_driver gtm601_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_gtm601 = {
+static const struct snd_soc_codec_driver soc_codec_dev_gtm601 = {
 	.dapm_widgets = gtm601_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(gtm601_dapm_widgets),
 	.dapm_routes = gtm601_dapm_routes,
@@ -80,11 +80,9 @@ MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
 
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
-			.name = "gtm601",
-			.owner = THIS_MODULE,
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
