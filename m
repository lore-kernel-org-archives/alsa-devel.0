From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/4] ASoC: Convert z2 to table based DAPM init
Date: Sat, 31 Dec 2011 08:45:49 +0800
Message-ID: <1325292349.3270.4.camel@phoenix>
References: <1325292030.3270.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 47D17103B6A
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 01:45:56 +0100 (CET)
Received: by ggnv5 with SMTP id v5so9031910ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:45:55 -0800 (PST)
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

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/z2.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index e8f15ce..76ccb17 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -112,7 +112,7 @@ static const struct snd_soc_dapm_widget wm8750_dapm_widgets[] = {
 };
 
 /* Z2 machine audio_map */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route z2_audio_map[] = {
 
 	/* headphone connected to LOUT1, ROUT1 */
 	{"Headphone Jack", NULL, "LOUT1"},
@@ -142,13 +142,6 @@ static int z2_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_disable_pin(dapm, "OUT3");
 	snd_soc_dapm_disable_pin(dapm, "MONO1");
 
-	/* Add z2 specific widgets */
-	snd_soc_dapm_new_controls(dapm, wm8750_dapm_widgets,
-				 ARRAY_SIZE(wm8750_dapm_widgets));
-
-	/* Set up z2 specific audio paths */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	/* Jack detection API stuff */
 	ret = snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
 				&hs_jack);
@@ -195,6 +188,11 @@ static struct snd_soc_card snd_soc_z2 = {
 	.owner		= THIS_MODULE,
 	.dai_link	= &z2_dai,
 	.num_links	= 1,
+
+	.dapm_widgets = wm8750_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
+	.dapm_routes = z2_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(z2_audio_map),
 };
 
 static struct platform_device *z2_snd_device;
-- 
1.7.5.4
