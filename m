From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 7/9] ASoC: zoom2: No need to call
	dapm_pin_enable at init time
Date: Mon, 10 Oct 2011 15:34:14 +0300
Message-ID: <1318250056-26437-8-git-send-email-peter.ujfalusi@ti.com>
References: <1318250056-26437-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C5C42453A
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 14:35:03 +0200 (CEST)
Received: by ggnk1 with SMTP id k1so4430971ggn.15
	for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2011 05:35:02 -0700 (PDT)
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
 sound/soc/omap/zoom2.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 4d01e16..7cf35c8 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -99,13 +99,6 @@ static int zoom2_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	/* Zoom2 connected pins */
-	snd_soc_dapm_enable_pin(dapm, "Ext Mic");
-	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
-	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
-	snd_soc_dapm_enable_pin(dapm, "Aux In");
-
 	/* TWL4030 not connected pins */
 	snd_soc_dapm_nc_pin(dapm, "CARKITMIC");
 	snd_soc_dapm_nc_pin(dapm, "DIGIMIC0");
-- 
1.7.7
