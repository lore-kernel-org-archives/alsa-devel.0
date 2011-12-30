From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: Convert corgi to table based DAPM
	and control init
Date: Fri, 30 Dec 2011 11:16:32 +0800
Message-ID: <1325214992.2569.6.camel@phoenix>
References: <1325214804.2569.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 73F2024356
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 04:16:39 +0100 (CET)
Received: by yhjj56 with SMTP id j56so8203221yhj.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 19:16:38 -0800 (PST)
In-Reply-To: <1325214804.2569.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/corgi.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 5ff6dac..30ebce2 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -227,7 +227,7 @@ SND_SOC_DAPM_HP("Headset Jack", NULL),
 };
 
 /* Corgi machine audio map (connections to the codec pins) */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route corgi_audio_map[] = {
 
 	/* headset Jack  - in = micin, out = LHPOUT*/
 	{"Headset Jack", NULL, "LHPOUT"},
@@ -269,24 +269,10 @@ static int corgi_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
 
 	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
 	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
 
-	/* Add corgi specific controls */
-	err = snd_soc_add_controls(codec, wm8731_corgi_controls,
-				ARRAY_SIZE(wm8731_corgi_controls));
-	if (err < 0)
-		return err;
-
-	/* Add corgi specific widgets */
-	snd_soc_dapm_new_controls(dapm, wm8731_dapm_widgets,
-				  ARRAY_SIZE(wm8731_dapm_widgets));
-
-	/* Set up corgi specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -310,6 +296,13 @@ static struct snd_soc_card snd_soc_corgi = {
 	.owner = THIS_MODULE,
 	.dai_link = &corgi_dai,
 	.num_links = 1,
+
+	.controls = wm8731_corgi_controls,
+	.num_controls = ARRAY_SIZE(wm8731_corgi_controls),
+	.dapm_widgets = wm8731_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8731_dapm_widgets),
+	.dapm_routes = corgi_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(corgi_audio_map),
 };
 
 static struct platform_device *corgi_snd_device;
-- 
1.7.5.4
