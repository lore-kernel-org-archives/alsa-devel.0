From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] ALSA: hdspm - Implement generic function
	to toggle settings
Date: Mon,  3 Dec 2012 14:55:49 +0100
Message-ID: <1354542951-1588-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1354542951-1588-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1354542951-1588-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

The driver contains at least six similar functions that change only a
single bit in the control register, only the bit position varies.

This patch implements a generic function to toggle a certain bit
position that will be used to replace the old code.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 748e36c..002e692 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2887,6 +2887,63 @@ static int snd_hdspm_get_autosync_ref(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+#define HDSPM_TOGGLE_SETTING(xname, xindex) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.private_value = xindex, \
+	.info = snd_hdspm_info_toggle_setting, \
+	.get = snd_hdspm_get_toggle_setting, \
+	.put = snd_hdspm_put_toggle_setting \
+}
+
+static int hdspm_toggle_setting(struct hdspm *hdspm, u32 regmask)
+{
+	return (hdspm->control_register & regmask) ? 1 : 0;
+}
+
+static int hdspm_set_toggle_setting(struct hdspm *hdspm, u32 regmask, int out)
+{
+	if (out)
+		hdspm->control_register |= regmask;
+	else
+		hdspm->control_register &= ~regmask;
+	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+
+	return 0;
+}
+
+#define snd_hdspm_info_toggle_setting		snd_ctl_boolean_mono_info
+
+static int snd_hdspm_get_toggle_setting(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	u32 regmask = kcontrol->private_value;
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.integer.value[0] = hdspm_toggle_setting(hdspm, regmask);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_toggle_setting(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+	u32 regmask = kcontrol->private_value;
+	int change;
+	unsigned int val;
+
+	if (!snd_hdspm_use_is_exclusive(hdspm))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0] & 1;
+	spin_lock_irq(&hdspm->lock);
+	change = (int) val != hdspm_toggle_setting(hdspm, regmask);
+	hdspm_set_toggle_setting(hdspm, regmask, val);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
+
 
 #define HDSPM_LINE_OUT(xname, xindex) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-- 
1.7.10.4
