From: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] sound/soc/codecs: Make tlv320aic32x4 codec selectable on it's own
Date: Tue, 30 Jun 2015 13:25:09 +0300
Message-ID: <934af0a78cd591f5c8a670a4a3bea085aab7f44a.1435569929.git.kimmo.saarela@gmail.com>
References: <cover.1435569929.git.kimmo.saarela@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1435569929.git.kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Kimmo Saarela <kimmo.saarela-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efaafce..ff297bc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -649,7 +649,8 @@ config SND_SOC_TLV320AIC31XX
 	select REGMAP_I2C
 
 config SND_SOC_TLV320AIC32X4
-	tristate
+	tristate "Texas Instruments TLV320AIC32x4 CODECs"
+	depends on I2C
 
 config SND_SOC_TLV320AIC3X
 	tristate "Texas Instruments TLV320AIC3x CODECs"
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
