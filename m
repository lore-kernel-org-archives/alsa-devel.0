From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Thu, 30 Jan 2014 17:56:58 +0100
Message-ID: <20140130175658.11469081@skate>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/xsu106k+RNZ87Ra1tUFAUzV"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id F3D2D2654DB
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 17:57:00 +0100 (CET)
In-Reply-To: <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

--MP_/xsu106k+RNZ87Ra1tUFAUzV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Brian Austin,

On Thu, 30 Jan 2014 09:37:44 -0600, Brian Austin wrote:

> > I have an L73 just up now and will check those register values and get back 
> > to you real soon.
> 
> So with v3.12 with the CS42L73 I can use SOC_DOUBLE_R_SX_TLV and adjust 
> the gain correctly and the register settings are reflected correctly as 
> well when I do an i2cdump of the device. Let me hunt down an L51 CDB and 
> see what is going on with that device.

I've tried again, and I confirm the problem. When the PCM is muted, I
can only toggle it between the values 62 and 64. When the PCM is
unmuted, I can only toggle it between the values 60 and 61.

The ugly attached patch fixes the problem for me (the patch is a
partial revert of your patch).

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--MP_/xsu106k+RNZ87Ra1tUFAUzV
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0007-sound-partial-revert-of-1d99f2436d0d1c7741d6dfd9d27b.patch

>From bdc427d58a4fa7dbb25d770618776cc25aa0f184 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 30 Jan 2014 15:14:41 +0100
Subject: [PATCH 7/9] sound: partial revert of
 1d99f2436d0d1c7741d6dfd9d27b5376cdbbca40

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/sound/soc.h        | 43 ++++++++++-----------
 sound/soc/codecs/cs42l51.c |  6 +--
 sound/soc/soc-core.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1f741cb..118736b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -70,18 +70,6 @@
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
 	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
-#define SOC_SINGLE_SX_TLV(xname, xreg, xshift, xmin, xmax, tlv_array) \
-{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-	SNDRV_CTL_ELEM_ACCESS_READWRITE, \
-	.tlv.p  = (tlv_array),\
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_sx,\
-	.put = snd_soc_put_volsw_sx, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xreg, \
-		.shift = xshift, .rshift = xshift, \
-		.max = xmax, .min = xmin} }
 #define SOC_SINGLE_RANGE_TLV(xname, xreg, xshift, xmin, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -140,18 +128,6 @@
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
 	.private_value = SOC_DOUBLE_R_RANGE_VALUE(reg_left, reg_right, \
 					    xshift, xmin, xmax, xinvert) }
-#define SOC_DOUBLE_R_SX_TLV(xname, xreg, xrreg, xshift, xmin, xmax, tlv_array) \
-{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-	SNDRV_CTL_ELEM_ACCESS_READWRITE, \
-	.tlv.p  = (tlv_array), \
-	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_sx, \
-	.put = snd_soc_put_volsw_sx, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .rreg = xrreg, \
-		.shift = xshift, .rshift = xshift, \
-		.max = xmax, .min = xmin} }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
@@ -162,6 +138,19 @@
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .min = xmin, .max = xmax, \
 		 .platform_max = xmax} }
+#define SOC_DOUBLE_R_SX_TLV(xname, xreg_left, xreg_right, xshift,\
+               xmin, xmax, tlv_array) \
+{      .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+       .access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |	     \
+       SNDRV_CTL_ELEM_ACCESS_READWRITE,			     \
+       .tlv.p = (tlv_array),				     \
+       .info = snd_soc_info_volsw_2r_sx,		     \
+       .get = snd_soc_get_volsw_2r_sx,			     \
+       .put = snd_soc_put_volsw_2r_sx,				   \
+       .private_value = (unsigned long)&(struct soc_mixer_control) \
+       {.reg = xreg_left,					   \
+	.rreg = xreg_right, .shift = xshift,			   \
+	.min = xmin, .max = xmax} }
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmax, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.max = xmax, .texts = xtexts, \
@@ -518,6 +507,12 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	const char *name, int max);
+int snd_soc_info_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+       struct snd_ctl_elem_info *uinfo);
+int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+       struct snd_ctl_elem_value *ucontrol);
+int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+       struct snd_ctl_elem_value *ucontrol);
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_info *uinfo);
 int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 4a7a733..d1a4ffb 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -141,15 +141,15 @@ static const struct soc_enum cs42l51_chan_mix =
 static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 	SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
 			CS42L51_PCMA_VOL, CS42L51_PCMB_VOL,
-			6, 0x19, 0x7F, adc_pcm_tlv),
+			7, 0xffffff99, 0x18, adc_pcm_tlv),
 	SOC_DOUBLE_R("PCM Playback Switch",
 			CS42L51_PCMA_VOL, CS42L51_PCMB_VOL, 7, 1, 1),
 	SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
 			CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
-			0, 0x34, 0xE4, aout_tlv),
+			8, 0xffffff19, 0x18, aout_tlv),
 	SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
 			CS42L51_ADCA_VOL, CS42L51_ADCB_VOL,
-			6, 0x19, 0x7F, adc_pcm_tlv),
+			7, 0xffffff99, 0x18, adc_pcm_tlv),
 	SOC_DOUBLE_R("ADC Mixer Switch",
 			CS42L51_ADCA_VOL, CS42L51_ADCB_VOL, 7, 1, 1),
 	SOC_SINGLE("Playback Deemphasis Switch", CS42L51_DAC_CTL, 3, 1, 0),
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a66783e..bc476a8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3177,6 +3177,100 @@ int snd_soc_limit_volume(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_limit_volume);
 
+/**
+ * snd_soc_info_volsw_2r_sx - double with tlv and variable data size
+ *  mixer info callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_info_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+                       struct snd_ctl_elem_info *uinfo)
+{
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       int max = mc->max;
+       int min = mc->min;
+
+       uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+       uinfo->count = 2;
+       uinfo->value.integer.min = 0;
+       uinfo->value.integer.max = max-min;
+
+       return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r_sx);
+
+/**
+ * snd_soc_get_volsw_2r_sx - double with tlv and variable data size
+ *  mixer get callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+                       struct snd_ctl_elem_value *ucontrol)
+{
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       unsigned int mask = (1<<mc->shift)-1;
+       int min = mc->min;
+       int val = snd_soc_read(codec, mc->reg) & mask;
+       int valr = snd_soc_read(codec, mc->rreg) & mask;
+
+       ucontrol->value.integer.value[0] = ((val & 0xff)-min) & mask;
+       ucontrol->value.integer.value[1] = ((valr & 0xff)-min) & mask;
+       return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);
+
+
+/**
+ * snd_soc_put_volsw_2r_sx - double with tlv and variable data size
+ *  mixer put callback
+ * @kcontrol: mixer control
+ * @uinfo: control element information
+ *
+ * Returns 0 for success.
+ */
+int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
+                       struct snd_ctl_elem_value *ucontrol)
+{
+       struct soc_mixer_control *mc =
+               (struct soc_mixer_control *)kcontrol->private_value;
+       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       unsigned int mask = (1<<mc->shift)-1;
+       int min = mc->min;
+       int ret;
+       unsigned int val, valr, oval, ovalr;
+
+       val = ((ucontrol->value.integer.value[0]+min) & 0xff);
+       val &= mask;
+       valr = ((ucontrol->value.integer.value[1]+min) & 0xff);
+       valr &= mask;
+
+       oval = snd_soc_read(codec, mc->reg) & mask;
+       ovalr = snd_soc_read(codec, mc->rreg) & mask;
+
+       ret = 0;
+       if (oval != val) {
+               ret = snd_soc_write(codec, mc->reg, val);
+               if (ret < 0)
+                       return ret;
+       }
+       if (ovalr != valr) {
+               ret = snd_soc_write(codec, mc->rreg, valr);
+               if (ret < 0)
+                       return ret;
+       }
+
+       return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r_sx);
+
 int snd_soc_bytes_info(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_info *uinfo)
 {
-- 
1.8.3.2


--MP_/xsu106k+RNZ87Ra1tUFAUzV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/xsu106k+RNZ87Ra1tUFAUzV--
