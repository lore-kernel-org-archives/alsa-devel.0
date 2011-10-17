From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix prefixing of DAPM controls
Date: Tue, 18 Oct 2011 00:13:12 +0100
Message-ID: <1318893192-30200-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D56A1038A3
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 01:13:15 +0200 (CEST)
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

We don't want to clear the prefix while we're creating the DAPM controls
for the device as the prefix is applied during control creation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 72c23c6..67724cdf 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1055,13 +1055,13 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	}
 	rtd->card = card;
 
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_new_widgets(&codec->dapm);
+
 	/* machine controls, routes and widgets are not prefixed */
 	temp = codec->name_prefix;
 	codec->name_prefix = NULL;
 
-	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(&codec->dapm);
-
 	/* do machine specific initialization */
 	if (!dailess && dai_link->init)
 		ret = dai_link->init(rtd);
-- 
1.7.6.3
