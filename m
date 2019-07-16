From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: mediatek: mt8183: make headset codec
	optional
Date: Tue, 16 Jul 2019 11:24:17 +0800
Message-ID: <20190716032417.19015-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com
 [IPv6:2607:f8b0:4864:20::a49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EB78F802BC
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2019 05:24:26 +0200 (CEST)
Received: by mail-vk1-xa49.google.com with SMTP id g68so6001435vkb.1
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 20:24:26 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Make headset codec optional because some variant machines may not
have an audio jack.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 887c932229d0..4c816c86844b 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -352,8 +352,6 @@ static struct snd_soc_card mt8183_mt6358_ts3a227_max98357_card = {
 	.owner = THIS_MODULE,
 	.dai_link = mt8183_mt6358_ts3a227_max98357_dai_links,
 	.num_links = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_dai_links),
-	.aux_dev = &mt8183_mt6358_ts3a227_max98357_headset_dev,
-	.num_aux_devs = 1,
 };
 
 static int
@@ -404,10 +402,9 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 	mt8183_mt6358_ts3a227_max98357_headset_dev.codec_of_node =
 		of_parse_phandle(pdev->dev.of_node,
 				 "mediatek,headset-codec", 0);
-	if (!mt8183_mt6358_ts3a227_max98357_headset_dev.codec_of_node) {
-		dev_err(&pdev->dev,
-			"Property 'mediatek,headset-codec' missing/invalid\n");
-		return -EINVAL;
+	if (mt8183_mt6358_ts3a227_max98357_headset_dev.codec_of_node) {
+		card->aux_dev = &mt8183_mt6358_ts3a227_max98357_headset_dev;
+		card->num_aux_devs = 1;
 	}
 
 	default_pins =
-- 
2.22.0.510.g264f2c817a-goog
