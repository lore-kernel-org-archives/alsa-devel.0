From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/4] ASoC: Convert saarb to table based DAPM
	init
Date: Sat, 31 Dec 2011 08:40:30 +0800
Message-ID: <1325292030.3270.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B694103B47
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 01:40:45 +0100 (CET)
Received: by ggnv5 with SMTP id v5so9031142ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:40:43 -0800 (PST)
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

Also remove a unused ret variable to silence the build warning.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/saarb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/saarb.c b/sound/soc/pxa/saarb.c
index b2be225..c34146b 100644
--- a/sound/soc/pxa/saarb.c
+++ b/sound/soc/pxa/saarb.c
@@ -51,7 +51,7 @@ static const struct snd_soc_dapm_widget saarb_dapm_widgets[] = {
 };
 
 /* saarb machine audio map */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route saarb_audio_map[] = {
 	{"Headset Stereophone", NULL, "HS1"},
 	{"Headset Stereophone", NULL, "HS2"},
 
@@ -121,17 +121,17 @@ static struct snd_soc_card snd_soc_card_saarb = {
 	.owner = THIS_MODULE,
 	.dai_link = saarb_dai,
 	.num_links = ARRAY_SIZE(saarb_dai),
+
+	.dapm_widgets = saarb_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(saarb_dapm_widgets),
+	.dapm_routes = saarb_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(saarb_audio_map),
 };
 
 static int saarb_pm860x_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	snd_soc_dapm_new_controls(dapm, saarb_dapm_widgets,
-				  ARRAY_SIZE(saarb_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* connected pins */
 	snd_soc_dapm_enable_pin(dapm, "Ext Speaker");
-- 
1.7.5.4
