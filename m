From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 08/11] ALSA: hdspm - Introduce generic AIO
	tristate control
Date: Thu,  4 Jul 2013 15:16:35 +0200
Message-ID: <1372943796-18998-9-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1372943796-18998-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-8-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1372943796-18998-8-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AIO cards offer at least four individual settings options with three
states each. Those settings are represented as two bits in the settings
register with the following meaning:

   0*some_base_bit --> Option value 0
   1*some_base_bit --> Option value 1
   2*some_base_bit --> Option value 2
   3*some_base_bit --> mask to select the two involved bits

This patch adds a generic ALSA control macro for such a value-to-bit
pattern mapping. It will be used in a later commit to expose four new
controls.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 50453f9..8b9c9f2 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3348,6 +3348,84 @@ static int snd_hdspm_put_qs_wire(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
+#define HDSPM_CONTROL_TRISTATE(xname, xindex) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.private_value = xindex, \
+	.info = snd_hdspm_info_tristate, \
+	.get = snd_hdspm_get_tristate, \
+	.put = snd_hdspm_put_tristate \
+}
+
+static int hdspm_tristate(struct hdspm *hdspm, u32 regmask)
+{
+	u32 reg = hdspm->settings_register & (regmask * 3);
+	return reg / regmask;
+}
+
+static int hdspm_set_tristate(struct hdspm *hdspm, int mode, u32 regmask)
+{
+	hdspm->settings_register &= ~(regmask * 3);
+	hdspm->settings_register |= (regmask * mode);
+	hdspm_write(hdspm, HDSPM_WR_SETTINGS, hdspm->settings_register);
+
+	return 0;
+}
+
+static int snd_hdspm_info_tristate(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	u32 regmask = kcontrol->private_value;
+
+	static char *texts_spdif[] = { "Optical", "Coaxial", "Internal" };
+	static char *texts_levels[] = { "Hi Gain", "+4 dBu", "-10 dBV" };
+
+	switch (regmask) {
+	case HDSPM_c0_Input0:
+		ENUMERATED_CTL_INFO(uinfo, texts_spdif);
+		break;
+	default:
+		ENUMERATED_CTL_INFO(uinfo, texts_levels);
+		break;
+	}
+	return 0;
+}
+
+static int snd_hdspm_get_tristate(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	u32 regmask = kcontrol->private_value;
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.enumerated.item[0] = hdspm_tristate(hdspm, regmask);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_tristate(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	u32 regmask = kcontrol->private_value;
+	int change;
+	int val;
+
+	if (!snd_hdspm_use_is_exclusive(hdspm))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0];
+	if (val < 0)
+		val = 0;
+	if (val > 2)
+		val = 2;
+
+	spin_lock_irq(&hdspm->lock);
+	change = val != hdspm_tristate(hdspm, regmask);
+	hdspm_set_tristate(hdspm, val, regmask);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
+
 #define HDSPM_MADI_SPEEDMODE(xname, xindex) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 	.name = xname, \
-- 
1.8.3.1
