From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 07/15] ASoC: twl6040: Support other sample rates
Date: Mon, 6 Dec 2010 18:18:02 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCCD@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id C685210399D
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:18:04 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The twl6040 can support more sample rates other than 88.2 and 96k.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 45d6f2d..e6a7bf9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -39,7 +39,7 @@
 
 #include "twl6040.h"
 
-#define TWL6040_RATES	 (SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
+#define TWL6040_RATES		SNDRV_PCM_RATE_8000_96000
 #define TWL6040_FORMATS	 (SNDRV_PCM_FMTBIT_S32_LE)
 
 struct twl6040_jack_data {
@@ -837,10 +837,17 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 
 	rate = params_rate(params);
 	switch (rate) {
+	case 11250:
+	case 22500:
+	case 44100:
 	case 88200:
 		lppllctl |= TWL6040_LPLLFIN;
 		priv->sysclk = 17640000;
 		break;
+	case 8000:
+	case 16000:
+	case 32000:
+	case 48000:
 	case 96000:
 		lppllctl &= ~TWL6040_LPLLFIN;
 		priv->sysclk = 19200000;
-- 
1.7.0.4
