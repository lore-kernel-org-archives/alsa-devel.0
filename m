From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v2 2/3] ASoC: Introduce SOC_SINGLE_S8_TLV() macro
Date: Fri, 27 May 2016 14:45:45 +0100
Message-ID: <1464356746-29610-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1464356746-29610-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464356746-29610-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch introduces SOC_SINGLE_S8_TLV() macro for volume control
on chips which supports both negative and positive gains with sign
bit on a 8 bit register, Gain ranges from -128 to +127 with a
predefined step size.
Currently we only have support to DOUBLE_S8_TLV() which does not fit
for cases where we just have separate gain control register for each
channel.

One of the Qualcomm SOC msm8916 has such gain control register whose gain
range is from -38.4dB to +38.4dB with step size of 0.3dB.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a21..b23fc50 100644
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
2.8.2
