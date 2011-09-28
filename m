From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Instantiate DAPM widgets before we do
	the DAI link init
Date: Wed, 28 Sep 2011 20:14:02 +0100
Message-ID: <1317237242-16423-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A0E51039F5
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 21:14:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The DAI init function may want to do something that needs the widgets to
be instantiated.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a58c1fc..1ed8093 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1059,6 +1059,9 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	temp = codec->name_prefix;
 	codec->name_prefix = NULL;
 
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_new_widgets(&codec->dapm);
+
 	/* do machine specific initialization */
 	if (!dailess && dai_link->init)
 		ret = dai_link->init(rtd);
@@ -1070,9 +1073,6 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	}
 	codec->name_prefix = temp;
 
-	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(&codec->dapm);
-
 	/* register the rtd device */
 	rtd->codec = codec;
 	rtd->dev.parent = card->dev;
-- 
1.7.6.3
