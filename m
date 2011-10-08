From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert Goni to data based DAPM init
Date: Sat,  8 Oct 2011 12:02:13 +0100
Message-ID: <1318071733-4197-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F353B10383B
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Oct 2011 13:02:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/goni_wm8994.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/samsung/goni_wm8994.c b/sound/soc/samsung/goni_wm8994.c
index dcaf656..60ed59b 100644
--- a/sound/soc/samsung/goni_wm8994.c
+++ b/sound/soc/samsung/goni_wm8994.c
@@ -100,14 +100,6 @@ static int goni_wm8994_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	/* add goni specific widgets */
-	snd_soc_dapm_new_controls(dapm, goni_dapm_widgets,
-			ARRAY_SIZE(goni_dapm_widgets));
-
-	/* set up goni specific audio routes */
-	snd_soc_dapm_add_routes(dapm, goni_dapm_routes,
-			ARRAY_SIZE(goni_dapm_routes));
-
 	/* set endpoints to not connected */
 	snd_soc_dapm_nc_pin(dapm, "IN2LP:VXRN");
 	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
@@ -256,6 +248,11 @@ static struct snd_soc_card goni = {
 	.name = "goni",
 	.dai_link = goni_dai,
 	.num_links = ARRAY_SIZE(goni_dai),
+
+	.dapm_widgets = goni_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(goni_dapm_widgets),
+	.dapm_routes = goni_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(goni_dapm_routes),
 };
 
 static int __init goni_init(void)
-- 
1.7.6.3
