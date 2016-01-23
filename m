From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH 2/2] ASoC: simple-card: don't fail if sysclk setting is not supported
Date: Sun, 24 Jan 2016 00:36:40 +0200
Message-ID: <1453588600-14831-3-git-send-email-aaro.koskinen@iki.fi>
References: <1453588600-14831-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453588600-14831-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Rick Thomas <rbthomas-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Commit e22579713ae1 ("ASoC: simple card: set cpu-dai sysclk
with mclk-fs") added sysclk / SND_SOC_CLOCK_OUT setting, that makes
asoc_simple_card_hw_params fail if the operation is not supported,
although the intention clearly was to ignore ENOTSUPP. Fix it.

The patch fixes audio playback on Kirkwood / OpenRD client,
where the following errors are seen:

	asoc-simple-card sound: ASoC: machine hw_params failed: -524
	alsa-lib: /alsa-lib-1.0.28/src/pcm/pcm_hw.c:327:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed (-524): Unknown error 524

Fixes: e22579713ae1 ("ASoC: simple card: set cpu-dai sysclk with mclk-fs")
Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 54c3320..ff6fcd9 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -100,7 +100,7 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 		if (ret && ret != -ENOTSUPP)
 			goto err;
 	}
-
+	return 0;
 err:
 	return ret;
 }
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
