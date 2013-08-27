From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] ASoC: dmic: Convert table based DAPM setup
Date: Tue, 27 Aug 2013 15:50:55 +0200
Message-ID: <1377611461-3638-2-git-send-email-lars@metafoo.de>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-185.synserver.de (smtp-out-185.synserver.de
 [212.40.185.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 7488D260840
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 15:49:36 +0200 (CEST)
In-Reply-To: <1377611461-3638-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Let the core take care of instantiating the DAPM widgets and routes, this makes
the code a bit shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/dmic.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 66967ba..b2090b2 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -50,20 +50,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"DMIC AIF", NULL, "DMic"},
 };
 
-static int dmic_probe(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, dmic_dapm_widgets,
-				  ARRAY_SIZE(dmic_dapm_widgets));
-        snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-	snd_soc_dapm_new_widgets(dapm);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_dmic = {
-	.probe	= dmic_probe,
+	.dapm_widgets = dmic_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(dmic_dapm_widgets),
+	.dapm_routes = intercon,
+	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
 static int dmic_dev_probe(struct platform_device *pdev)
-- 
1.8.0
