From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/21] ASoC: Fix WM8580 volume update handling
	for large register changes
Date: Thu, 23 Apr 2009 20:55:40 +0100
Message-ID: <1240516555-22249-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F14041038A3
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:07 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver is out of sync with the core functions it is using.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 41aab4a..9f6be3d 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -268,9 +268,11 @@ static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
 static int wm8580_out_vu(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
-	int reg2 = (kcontrol->private_value >> 24) & 0xff;
+	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
 	int ret;
 	u16 val;
 
@@ -292,15 +294,17 @@ static int wm8580_out_vu(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-#define SOC_WM8580_OUT_DOUBLE_R_TLV(xname, reg_left, reg_right, shift, max, invert, tlv_array) \
+#define SOC_WM8580_OUT_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, \
+				    xinvert, tlv_array)			\
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		SNDRV_CTL_ELEM_ACCESS_READWRITE,  \
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = wm8580_out_vu, \
-	.private_value = (reg_left) | ((shift) << 8)  |		\
-		((max) << 12) | ((invert) << 20) | ((reg_right) << 24) }
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
+		.max = xmax, .invert = xinvert} }
 
 static const struct snd_kcontrol_new wm8580_snd_controls[] = {
 SOC_WM8580_OUT_DOUBLE_R_TLV("DAC1 Playback Volume",
-- 
1.5.6.3
