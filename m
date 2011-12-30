From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: Convert poodle to table based DAPM
 and control init
Date: Fri, 30 Dec 2011 09:19:32 +0800
Message-ID: <1325207972.9599.4.camel@phoenix>
References: <1325207771.9599.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FF5A103A99
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 02:19:38 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8742968ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 17:19:38 -0800 (PST)
In-Reply-To: <1325207771.9599.1.camel@phoenix>
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
 sound/soc/pxa/poodle.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index c9e24bf..a321b4d 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -214,7 +214,7 @@ SND_SOC_DAPM_SPK("Ext Spk", poodle_amp_event),
 };
 
 /* Corgi machine connections to the codec pins */
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route poodle_audio_map[] = {
 
 	/* headphone connected to LHPOUT1, RHPOUT1 */
 	{"Headphone Jack", NULL, "LHPOUT"},
@@ -246,25 +246,11 @@ static int poodle_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int err;
 
 	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
 	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
 	snd_soc_dapm_enable_pin(dapm, "MICIN");
 
-	/* Add poodle specific controls */
-	err = snd_soc_add_controls(codec, wm8731_poodle_controls,
-				ARRAY_SIZE(wm8731_poodle_controls));
-	if (err < 0)
-		return err;
-
-	/* Add poodle specific widgets */
-	snd_soc_dapm_new_controls(dapm, wm8731_dapm_widgets,
-				  ARRAY_SIZE(wm8731_dapm_widgets));
-
-	/* Set up poodle specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	return 0;
 }
 
@@ -286,6 +272,13 @@ static struct snd_soc_card poodle = {
 	.dai_link = &poodle_dai,
 	.num_links = 1,
 	.owner = THIS_MODULE,
+
+	.controls = wm8731_poodle_controls,
+	.num_controls = ARRAY_SIZE(wm8731_poodle_controls),
+	.dapm_widgets = wm8731_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8731_dapm_widgets),
+	.dapm_routes = poodle_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(poodle_audio_map),
 };
 
 static int __devinit poodle_probe(struct platform_device *pdev)
-- 
1.7.5.4
