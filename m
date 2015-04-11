From: Michael Gernoth <michael@gernoth.net>
Subject: [PATCH v2] ALSA: emu10k1: add toggles for E-mu 1010
	optical ports
Date: Sat, 11 Apr 2015 18:00:19 +0200
Message-ID: <20150411160019.GA8196@zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eddie.zerfleddert.de (eddie.zerfleddert.de [188.246.9.226])
 by alsa0.perex.cz (Postfix) with ESMTP id A567F260A50
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 18:00:19 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The optical ports on the E-mu 1010 (and dock) can be configured
for ADAT- or S/PDIF-mode, which is currently hardcoded to ADAT.
Add two mixer elements to expose this setting.
Tested on an E-mu 1010 PCIe with connected Micro Dock.

Signed-off-by: Michael Gernoth <michael@gernoth.net>
---
 sound/pci/emu10k1/emumixer.c | 118 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 1de3302..55e5716 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -806,6 +806,108 @@ static struct snd_kcontrol_new snd_emu1010_internal_clock =
 	.put =          snd_emu1010_internal_clock_put
 };
 
+static int snd_emu1010_optical_out_info(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[2] = {
+		"SPDIF", "ADAT"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
+}
+
+static int snd_emu1010_optical_out_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = emu->emu1010.optical_out;
+	return 0;
+}
+
+static int snd_emu1010_optical_out_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+	u32 tmp;
+	int change = 0;
+
+	val = ucontrol->value.enumerated.item[0];
+	/* Limit: uinfo->value.enumerated.items = 2; */
+	if (val >= 2)
+		return -EINVAL;
+	change = (emu->emu1010.optical_out != val);
+	if (change) {
+		emu->emu1010.optical_out = val;
+		tmp = (emu->emu1010.optical_in ? EMU_HANA_OPTICAL_IN_ADAT : 0) |
+			(emu->emu1010.optical_out ? EMU_HANA_OPTICAL_OUT_ADAT : 0);
+		snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, tmp);
+	}
+	return change;
+}
+
+static struct snd_kcontrol_new snd_emu1010_optical_out = {
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         "Optical Output Mode",
+	.count =	1,
+	.info =         snd_emu1010_optical_out_info,
+	.get =          snd_emu1010_optical_out_get,
+	.put =          snd_emu1010_optical_out_put
+};
+
+static int snd_emu1010_optical_in_info(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[2] = {
+		"SPDIF", "ADAT"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
+}
+
+static int snd_emu1010_optical_in_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = emu->emu1010.optical_in;
+	return 0;
+}
+
+static int snd_emu1010_optical_in_put(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_emu10k1 *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+	u32 tmp;
+	int change = 0;
+
+	val = ucontrol->value.enumerated.item[0];
+	/* Limit: uinfo->value.enumerated.items = 2; */
+	if (val >= 2)
+		return -EINVAL;
+	change = (emu->emu1010.optical_in != val);
+	if (change) {
+		emu->emu1010.optical_in = val;
+		tmp = (emu->emu1010.optical_in ? EMU_HANA_OPTICAL_IN_ADAT : 0) |
+			(emu->emu1010.optical_out ? EMU_HANA_OPTICAL_OUT_ADAT : 0);
+		snd_emu1010_fpga_write(emu, EMU_HANA_OPTICAL_TYPE, tmp);
+	}
+	return change;
+}
+
+static struct snd_kcontrol_new snd_emu1010_optical_in = {
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         "Optical Input Mode",
+	.count =	1,
+	.info =         snd_emu1010_optical_in_info,
+	.get =          snd_emu1010_optical_in_get,
+	.put =          snd_emu1010_optical_in_put
+};
+
 static int snd_audigy_i2c_capture_source_info(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
@@ -2051,6 +2153,14 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 			snd_ctl_new1(&snd_emu1010_internal_clock, emu));
 		if (err < 0)
 			return err;
+		err = snd_ctl_add(card,
+			snd_ctl_new1(&snd_emu1010_optical_out, emu));
+		if (err < 0)
+			return err;
+		err = snd_ctl_add(card,
+			snd_ctl_new1(&snd_emu1010_optical_in, emu));
+		if (err < 0)
+			return err;
 
 	} else if (emu->card_capabilities->emu_model) {
 		/* all other e-mu cards for now */
@@ -2086,6 +2196,14 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 			snd_ctl_new1(&snd_emu1010_internal_clock, emu));
 		if (err < 0)
 			return err;
+		err = snd_ctl_add(card,
+			snd_ctl_new1(&snd_emu1010_optical_out, emu));
+		if (err < 0)
+			return err;
+		err = snd_ctl_add(card,
+			snd_ctl_new1(&snd_emu1010_optical_in, emu));
+		if (err < 0)
+			return err;
 	}
 
 	if ( emu->card_capabilities->i2c_adc) {
-- 
2.1.4
