From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Introduce SOC_SINGLE_S8_TLV() macro" to the asoc tree
Date: Fri, 27 May 2016 21:45:12 +0100
Message-ID: <E1b6Od6-0001X4-KN@debutante>
References: <1464356746-29610-3-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464356746-29610-3-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Introduce SOC_SINGLE_S8_TLV() macro

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 627f3c2fc0c8fd52ebe7c0f28744d98d3955a1d6 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date: Fri, 27 May 2016 14:45:45 +0100
Subject: [PATCH] ASoC: Introduce SOC_SINGLE_S8_TLV() macro

This patch introduces SOC_SINGLE_S8_TLV() macro for volume control
on chips which supports both negative and positive gains with sign
bit on a 8 bit register, Gain ranges from -128 to +127 with a
predefined step size.
Currently we only have support to DOUBLE_S8_TLV() which does not fit
for cases where we just have separate gain control register for each
channel.

One of the Qualcomm SOC msm8916 has such gain control register whose gain
range is from -38.4dB to +38.4dB with step size of 0.3dB.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/sound/soc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fd7b58a58d6f..6144882cc96a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -179,6 +179,17 @@
 	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_S_VALUE(reg_left, reg_right, xshift, \
 					    xmin, xmax, xsign_bit, xinvert) }
+#define SOC_SINGLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
+{	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p  = (tlv_array), \
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
+	.put = snd_soc_put_volsw, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+	{.reg = xreg, .rreg = xreg,  \
+	 .min = xmin, .max = xmax, .platform_max = xmax, \
+	.sign_bit = 7,} }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
