From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] ASoC: sh: ssi: Convert to
 devm_snd_soc_register_component
Date: Fri, 28 Aug 2015 10:50:53 +0800
Message-ID: <1440730253.11149.2.camel@ingics.com>
References: <1440730115.11149.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D9B4F260469
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 04:50:57 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so45988012pac.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 19:50:57 -0700 (PDT)
In-Reply-To: <1440730115.11149.0.camel@ingics.com>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/sh/ssi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index ab13146..89ed1b1 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -385,14 +385,9 @@ static const struct snd_soc_component_driver sh4_ssi_component = {
 
 static int sh4_soc_dai_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev, &sh4_ssi_component,
-					  sh4_ssi_dai, ARRAY_SIZE(sh4_ssi_dai));
-}
-
-static int sh4_soc_dai_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev, &sh4_ssi_component,
+					       sh4_ssi_dai,
+					       ARRAY_SIZE(sh4_ssi_dai));
 }
 
 static struct platform_driver sh4_ssi_driver = {
@@ -401,7 +396,6 @@ static struct platform_driver sh4_ssi_driver = {
 	},
 
 	.probe = sh4_soc_dai_probe,
-	.remove = sh4_soc_dai_remove,
 };
 
 module_platform_driver(sh4_ssi_driver);
-- 
2.1.0
