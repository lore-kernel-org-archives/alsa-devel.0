From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/4] ASoC: Convert tavorevb3 to table based
	DAPM init
Date: Sat, 31 Dec 2011 08:45:01 +0800
Message-ID: <1325292301.3270.3.camel@phoenix>
References: <1325292030.3270.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C4D3103B65
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 01:45:08 +0100 (CET)
Received: by ghbz2 with SMTP id z2so3547115ghb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:45:07 -0800 (PST)
In-Reply-To: <1325292030.3270.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Also remove a unsued ret variable to silence the build warning.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/tavorevb3.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
index 46ac1fe..8b5ab8f 100644
--- a/sound/soc/pxa/tavorevb3.c
+++ b/sound/soc/pxa/tavorevb3.c
@@ -51,7 +51,7 @@ static const struct snd_soc_dapm_widget evb3_dapm_widgets[] = {
 };
 
 /* tavorevb3 machine audio map */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route evb3_audio_map[] = {
 	{"Headset Stereophone", NULL, "HS1"},
 	{"Headset Stereophone", NULL, "HS2"},
 
@@ -120,17 +120,17 @@ static struct snd_soc_card snd_soc_card_evb3 = {
 	.owner = THIS_MODULE,
 	.dai_link = evb3_dai,
 	.num_links = ARRAY_SIZE(evb3_dai),
+
+	.dapm_widgets = evb3_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(evb3_dapm_widgets),
+	.dapm_routes = evb3_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(evb3_audio_map),
 };
 
 static int evb3_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	snd_soc_dapm_new_controls(dapm, evb3_dapm_widgets,
-				  ARRAY_SIZE(evb3_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* connected pins */
 	snd_soc_dapm_enable_pin(dapm, "Ext Speaker");
-- 
1.7.5.4
