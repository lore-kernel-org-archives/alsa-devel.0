From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix a typo in jive_wm8750
Date: Wed, 07 Dec 2011 17:44:47 +0800
Message-ID: <1323251087.27710.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A4431246D5
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 10:44:55 +0100 (CET)
Received: by ghbg15 with SMTP id g15so290325ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2011 01:44:53 -0800 (PST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lrg@ti.com>, Ben Dooks <ben-linux@fluff.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Fix a typo in jive_wm8750 that introduces below build error.
Also removes an unused err variable.

  CC      sound/soc/samsung/jive_wm8750.o
sound/soc/samsung/jive_wm8750.c: In function 'jive_wm8750_init':
sound/soc/samsung/jive_wm8750.c:104: warning: unused variable 'err'
sound/soc/samsung/jive_wm8750.c: At top level:
sound/soc/samsung/jive_wm8750.c:134: error: unknown field 'dapm_widgtets' specified in initializer
sound/soc/samsung/jive_wm8750.c:134: warning: initialization from incompatible pointer type
make[3]: *** [sound/soc/samsung/jive_wm8750.o] Error 1
make[2]: *** [sound/soc/samsung] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/jive_wm8750.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 1826acf..8e523fd 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -101,7 +101,6 @@ static int jive_wm8750_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
 
 	/* These endpoints are not being used. */
 	snd_soc_dapm_nc_pin(dapm, "LINPUT2");
@@ -131,7 +130,7 @@ static struct snd_soc_card snd_soc_machine_jive = {
 	.dai_link	= &jive_dai,
 	.num_links	= 1,
 
-	.dapm_widgtets	= wm8750_dapm_widgets,
+	.dapm_widgets	= wm8750_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(wm8750_dapm_widgets),
 	.dapm_routes	= audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
-- 
1.7.5.4
