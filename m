From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH 1/2] ASoC: palm27x: fix widgets and routes in
	dai_link init
Date: Fri, 28 Dec 2012 13:15:59 -0800
Message-ID: <1356729360-14522-2-git-send-email-mikedunn@newsguy.com>
References: <1356729360-14522-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.newsguy.com (smtp.newsguy.com [74.209.136.69])
 by alsa0.perex.cz (Postfix) with ESMTP id BE8DC2615CC
 for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2012 22:16:08 +0100 (CET)
In-Reply-To: <1356729360-14522-1-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Marek Vasut <marex@denx.de>, Mike Dunn <mikedunn@newsguy.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

ASoC core code now handles creation of controls and routing based on contents of
struct snd_soc_card, so remove calls to snd_soc_dapm_new_controls() and
snd_soc_dapm_add_routes() from the snd_soc_dai_link init function, and add
widget and route definitions to struct snd_soc_card.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 sound/soc/pxa/palm27x.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 2074e2d..bb062e6 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -79,17 +79,6 @@ static int palm27x_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int err;
 
-	/* add palm27x specific widgets */
-	err = snd_soc_dapm_new_controls(dapm, palm27x_dapm_widgets,
-				ARRAY_SIZE(palm27x_dapm_widgets));
-	if (err)
-		return err;
-
-	/* set up palm27x specific audio path audio_map */
-	err = snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-	if (err)
-		return err;
-
 	/* connected pins */
 	if (machine_is_palmld())
 		snd_soc_dapm_enable_pin(dapm, "MIC1");
@@ -149,6 +138,10 @@ static struct snd_soc_card palm27x_asoc = {
 	.owner = THIS_MODULE,
 	.dai_link = palm27x_dai,
 	.num_links = ARRAY_SIZE(palm27x_dai),
+	.dapm_widgets = palm27x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(palm27x_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map)
 };
 
 static struct platform_device *palm27x_snd_device;
-- 
1.7.8.6
