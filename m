From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: sdp440: No need to call
	snd_soc_dapm_enable_pin at init time
Date: Fri,  7 Oct 2011 10:49:31 +0300
Message-ID: <1317973772-14127-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id D453924651
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 09:49:24 +0200 (CEST)
Received: by bkbzs8 with SMTP id zs8so7430899bkb.27
	for <alsa-devel@alsa-project.org>; Fri, 07 Oct 2011 00:49:16 -0700 (PDT)
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

All DAPM widgets are connected after they have added. Machine driver
only need to mark not connected pins.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 10972fb..3069226 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -132,14 +132,6 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	/* Set up SDP4430 specific audio path audio_map */
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
-	/* SDP4430 connected pins */
-	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
-	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-	snd_soc_dapm_enable_pin(dapm, "AFML");
-	snd_soc_dapm_enable_pin(dapm, "AFMR");
-	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
-	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
-
 	ret = snd_soc_dapm_new_widgets(dapm);
 	if (ret)
 		return ret;
-- 
1.7.7
