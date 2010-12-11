From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v4 3/3] ASoC: sdp4430: Add Jack support
Date: Fri, 10 Dec 2010 20:45:19 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225CD@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 5072E2464D
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 03:45:22 +0100 (CET)
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

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

Use jack framework to enable detection for the headset microphone
and stereo output in the sdp4430.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/sdp4430.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 0c37c51..189e039 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -24,6 +24,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 
 #include <asm/mach-types.h>
 #include <plat/hardware.h>
@@ -65,6 +66,21 @@ static struct snd_soc_ops sdp4430_ops = {
 	.hw_params = sdp4430_hw_params,
 };
 
+/* Headset jack */
+static struct snd_soc_jack hs_jack;
+
+/*Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headset Stereophone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
 static int sdp4430_get_power_mode(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -160,6 +176,22 @@ static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_enable_pin(dapm, "Headset Stereophone");
 
 	ret = snd_soc_dapm_sync(dapm);
+	if (ret)
+		return ret;
+
+	/* Headset jack detection */
+	ret = snd_soc_jack_new(codec, "Headset Jack",
+				SND_JACK_HEADSET, &hs_jack);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+				hs_jack_pins);
+
+	if (machine_is_omap_4430sdp())
+		twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
+	else
+		snd_soc_jack_report(&hs_jack, SND_JACK_HEADSET, SND_JACK_HEADSET);
 
 	return ret;
 }
-- 
1.7.0.4
