From: Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 7/9] ASoC: cygnus: Remove set_fmt from SPDIF dai ops
Date: Mon, 14 Aug 2017 15:06:55 -0700
Message-ID: <1502748417-26417-8-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The SPDIF port cannot modify its format so a set_fmt function is not
needed.  Previously, we used a generic set_fmt for all ports and returned
an error code for the SPDIF port.  It is cleaner to not populate the
set_fmt field.

Signed-off-by: Lori Hikichi <lori.hikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 sound/soc/bcm/cygnus-ssp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 5292c04..e72d8a8 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1222,6 +1222,13 @@ static void update_ssp_cfg(struct cygnus_aio_port *aio)
 	.set_pll	= cygnus_ssp_set_pll,
 };
 
+static const struct snd_soc_dai_ops cygnus_spdif_dai_ops = {
+	.startup	= cygnus_ssp_startup,
+	.shutdown	= cygnus_ssp_shutdown,
+	.trigger	= cygnus_ssp_trigger,
+	.hw_params	= cygnus_ssp_hw_params,
+	.set_sysclk	= cygnus_ssp_set_sysclk,
+};
 
 #define INIT_CPU_DAI(num) { \
 	.name = "cygnus-ssp" #num, \
@@ -1255,9 +1262,9 @@ static void update_ssp_cfg(struct cygnus_aio_port *aio)
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_KNOT,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE |
-			SNDRV_PCM_FMTBIT_S32_LE,
+				SNDRV_PCM_FMTBIT_S32_LE,
 	},
-	.ops = &cygnus_ssp_dai_ops,
+	.ops = &cygnus_spdif_dai_ops,
 };
 
 static struct snd_soc_dai_driver cygnus_ssp_dai[CYGNUS_MAX_PORTS];
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
