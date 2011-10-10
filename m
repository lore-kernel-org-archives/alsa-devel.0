From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 8/9] ASoC: sdp4430: Let core to deal with
	the DAPM widgets
Date: Mon, 10 Oct 2011 15:34:15 +0300
Message-ID: <1318250056-26437-9-git-send-email-peter.ujfalusi@ti.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id A654024544
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:35:04 +0200 (CEST)
Received: by mail-yx0-f170.google.com with SMTP id 13so10166828yxi.1
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:35:03 -0700 (PDT)
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
 sound/soc/omap/sdp4430.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 98f05dc..ebe1bbb 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -123,15 +123,6 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, hs_trim;
 
-	/* Add SDP4430 specific widgets */
-	ret = snd_soc_dapm_new_controls(dapm, sdp4430_twl6040_dapm_widgets,
-				ARRAY_SIZE(sdp4430_twl6040_dapm_widgets));
-	if (ret)
-		return ret;
-
-	/* Set up SDP4430 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	/* SDP4430 connected pins */
 	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
 	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
@@ -182,6 +173,11 @@ static struct snd_soc_card snd_soc_sdp4430 = {
 	.name = "SDP4430",
 	.dai_link = &sdp4430_dai,
 	.num_links = 1,
+
+	.dapm_widgets = sdp4430_twl6040_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(sdp4430_twl6040_dapm_widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
 };
 
 static struct platform_device *sdp4430_snd_device;
-- 
1.7.7
