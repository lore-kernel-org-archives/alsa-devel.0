From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 1/4] ASoC: Add SOC_DOUBLE_R_EXT
Date: Tue, 29 Sep 2015 16:43:56 +0100
Message-ID: <fe83d50e7e80632f25d4e9830262aba0e9ace671.1443538420.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1443538420.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1443538420.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Jason Coughlan <jason.coughlan-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

_EXT version of SOC_DOUBLE_R required to allow for custom handlers.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
---
 include/sound/soc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 884e728..2d79cb5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -217,6 +217,13 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = \
 		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, max, invert, 0) }
+#define SOC_DOUBLE_R_EXT(xname, reg_left, reg_right, xshift, xmax, xinvert,\
+	 xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.info = snd_soc_info_volsw, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
+					    xmax, xinvert) }
 #define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
--
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
