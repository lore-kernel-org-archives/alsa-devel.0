From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v2 1/2] ASoC: SDP4430: Add support for Earphone
	speaker
Date: Tue, 18 May 2010 12:44:17 -0500
Message-ID: <1274204658-31614-2-git-send-email-jorge.candelaria@ti.com>
References: <1274204658-31614-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C4DF103888
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 19:56:24 +0200 (CEST)
In-Reply-To: <1274204658-31614-1-git-send-email-jorge.candelaria@ti.com>
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
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Enable earphone speaker in sdp4430 machine driver.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/sdp4430.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 83831ee..3a0c198 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -101,6 +101,7 @@ static const struct snd_soc_dapm_widget sdp4430_twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -120,6 +121,9 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	/* Headset Stereophone (Headphone): HSOL, HSOR */
 	{"Headset Stereophone", NULL, "HSOL"},
 	{"Headset Stereophone", NULL, "HSOR"},
+
+	/* Earphone speaker */
+	{"Earphone Spk", NULL, "EP"},
 };
 
 static int sdp4430_twl6040_init(struct snd_soc_codec *codec)
-- 
1.6.3.3
