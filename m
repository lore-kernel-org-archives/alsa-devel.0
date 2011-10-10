From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 9/9] ASoC: sdp4430: No need to call
	dapm_pin_enable at init time
Date: Mon, 10 Oct 2011 15:34:16 +0300
Message-ID: <1318250056-26437-10-git-send-email-peter.ujfalusi@ti.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76]) by alsa0.perex.cz (Postfix) with ESMTP id 2E56F24548
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:35:06 +0200 (CEST)
Received: by mail-gy0-f171.google.com with SMTP id 3so7575781gyh.16
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:35:05 -0700 (PDT)
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

Widgets are connected by default.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>
---
 sound/soc/omap/sdp4430.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index ebe1bbb..cc3d792 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -120,17 +120,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret, hs_trim;
 
-	/* SDP4430 connected pins */
-	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
-	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-	snd_soc_dapm_enable_pin(dapm, "AFML");
-	snd_soc_dapm_enable_pin(dapm, "AFMR");
-	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
-	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
-
 	/*
 	 * Configure McPDM offset cancellation based on the HSOTRIM value from
 	 * twl6040.
-- 
1.7.7
