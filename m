From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 2/2] ASoC: codec: add DT support in dmic codec
Date: Tue, 25 Jul 2017 10:48:14 +0200
Message-ID: <1500972494-10696-3-git-send-email-arnaud.pouliquen@st.com>
References: <1500972494-10696-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500972494-10696-1-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Add of_table to allows DT probing.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
---
 sound/soc/codecs/dmic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index c82b9dc..d50f142 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -73,9 +73,15 @@ static int dmic_dev_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:dmic-codec");
 
+static const struct of_device_id dmic_dev_match[] = {
+	{.compatible = "dmic-codec"},
+	{}
+};
+
 static struct platform_driver dmic_driver = {
 	.driver = {
 		.name = "dmic-codec",
+		.of_match_table = dmic_dev_match,
 	},
 	.probe = dmic_dev_probe,
 	.remove = dmic_dev_remove,
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
