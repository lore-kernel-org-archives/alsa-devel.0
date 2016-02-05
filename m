From: Florian Vaussard <florian.vaussard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/2] ASoC: ads117x: Add device tree compatible string
Date: Fri,  5 Feb 2016 16:32:14 +0100
Message-ID: <1454686334-9668-3-git-send-email-florian.vaussard@heig-vd.ch>
References: <1454686334-9668-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454686334-9668-1-git-send-email-florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds the necessary device tree compatible string to allow DT
probing.

Signed-off-by: Florian Vaussard <florian.vaussard-EWQkb/GNqlFyDzI6CaY1VQ@public.gmane.org>
---
 sound/soc/codecs/ads117x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 1222282..c5be1bd 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -20,6 +20,8 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+#include <linux/of.h>
+
 #define ADS117X_RATES (SNDRV_PCM_RATE_8000_48000)
 #define ADS117X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
 
@@ -75,9 +77,19 @@ static int ads117x_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id ads117x_dt_ids[] = {
+	{ .compatible = "ti,ads1174" },
+	{ .compatible = "ti,ads1178" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads117x_dt_ids);
+#endif
+
 static struct platform_driver ads117x_codec_driver = {
 	.driver = {
 			.name = "ads117x-codec",
+			.of_match_table = of_match_ptr(ads117x_dt_ids),
 	},
 
 	.probe = ads117x_probe,
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
