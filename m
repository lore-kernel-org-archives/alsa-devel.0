From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 6/9] ASoC: zoom2: Let core to deal with the
	DAPM widgets
Date: Mon, 10 Oct 2011 15:34:13 +0300
Message-ID: <1318250056-26437-7-git-send-email-peter.ujfalusi@ti.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73]) by alsa0.perex.cz (Postfix) with ESMTP id 2185B24536
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:35:01 +0200 (CEST)
Received: by ywm13 with SMTP id 13so5342264ywm.9
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:35:00 -0700 (PDT)
In-Reply-To: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Pass the DAPM widgets/routes via the snd_soc_card struct
to core.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>
---
 sound/soc/omap/zoom2.c |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 9a8288d..4d01e16 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -98,16 +98,6 @@ static int zoom2_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
-
-	/* Add Zoom2 specific widgets */
-	ret = snd_soc_dapm_new_controls(dapm, zoom2_twl4030_dapm_widgets,
-				ARRAY_SIZE(zoom2_twl4030_dapm_widgets));
-	if (ret)
-		return ret;
-
-	/* Set up Zoom2 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
 	/* Zoom2 connected pins */
 	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
@@ -175,6 +165,11 @@ static struct snd_soc_card snd_soc_zoom2 = {
 	.name = "Zoom2",
 	.dai_link = zoom2_dai,
 	.num_links = ARRAY_SIZE(zoom2_dai),
+
+	.dapm_widgets = zoom2_twl4030_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(zoom2_twl4030_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *zoom2_snd_device;
-- 
1.7.7
