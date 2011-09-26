From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH resend 4/4] ASoC: sdp4430: Configure McPDM
	offset cancellation
Date: Mon, 26 Sep 2011 16:05:59 +0300
Message-ID: <1317042359-27127-5-git-send-email-peter.ujfalusi@ti.com>
References: <1317042359-27127-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 3672A103850
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:06:27 +0200 (CEST)
Received: by mail-bw0-f42.google.com with SMTP id r4so5802607bka.29
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:06:25 -0700 (PDT)
In-Reply-To: <1317042359-27127-1-git-send-email-peter.ujfalusi@ti.com>
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

Based on the values from twl6040 codec (HSOTRIM L/R) we can configure
the McPDM offset cancellation.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 4200eb4..249d84b 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -121,7 +121,7 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int ret;
+	int ret, hs_trim;
 
 	/* Add SDP4430 specific widgets */
 	ret = snd_soc_dapm_new_controls(dapm, sdp4430_twl6040_dapm_widgets,
@@ -144,6 +144,14 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret)
 		return ret;
 
+	/*
+	 * Configure McPDM offset cancellation based on the HSOTRIM value from
+	 * twl6040.
+	 */
+	hs_trim = twl6040_get_trim_value(codec, TWL6040_TRIM_HSOTRIM);
+	omap_mcpdm_configure_dn_offsets(rtd, TWL6040_HSF_TRIM_LEFT(hs_trim),
+					TWL6040_HSF_TRIM_RIGHT(hs_trim));
+
 	/* Headset jack detection */
 	ret = snd_soc_jack_new(codec, "Headset Jack",
 				SND_JACK_HEADSET, &hs_jack);
-- 
1.7.6.1
