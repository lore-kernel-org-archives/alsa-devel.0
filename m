From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/4] ALSA: hdsp - Implement generic function to
	toggle settings
Date: Tue, 15 Jan 2013 15:18:11 +0100
Message-ID: <1358259493-17974-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1358259493-17974-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1358259493-17974-2-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1358259493-17974-2-git-send-email-adi@drcomp.erfurt.thur.de>
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

The driver contains multiple similar functions that change only a single
bit in the control register, only the bit position varies.

This patch implements a generic function to toggle a certain bit
position that will be used to replace the old code.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index ba190d5..cdc2b20 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1712,6 +1712,65 @@ static int snd_hdsp_put_spdif_in(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return change;
 }
 
+#define HDSP_TOGGLE_SETTING(xname, xindex) \
+{   .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.private_value = xindex, \
+	.info = snd_hdsp_info_toggle_setting, \
+	.get = snd_hdsp_get_toggle_setting, \
+	.put = snd_hdsp_put_toggle_setting \
+}
+
+static int hdsp_toggle_setting(struct hdsp *hdsp, u32 regmask)
+{
+	return (hdsp->control_register & regmask) ? 1 : 0;
+}
+
+static int hdsp_set_toggle_setting(struct hdsp *hdsp, u32 regmask, int out)
+{
+	if (out)
+		hdsp->control_register |= regmask;
+	else
+		hdsp->control_register &= ~regmask;
+	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
+
+	return 0;
+}
+
+#define snd_hdsp_info_toggle_setting		   snd_ctl_boolean_mono_info
+
+static int snd_hdsp_get_toggle_setting(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
+	u32 regmask = kcontrol->private_value;
+
+	spin_lock_irq(&hdsp->lock);
+	ucontrol->value.integer.value[0] = hdsp_toggle_setting(hdsp, regmask);
+	spin_unlock_irq(&hdsp->lock);
+	return 0;
+}
+
+static int snd_hdsp_put_toggle_setting(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
+	u32 regmask = kcontrol->private_value;
+	int change;
+	unsigned int val;
+
+	if (!snd_hdsp_use_is_exclusive(hdsp))
+		return -EBUSY;
+	val = ucontrol->value.integer.value[0] & 1;
+	spin_lock_irq(&hdsp->lock);
+	change = (int) val != hdsp_toggle_setting(hdsp, regmask);
+	if (change)
+		hdsp_set_toggle_setting(hdsp, regmask, val);
+	spin_unlock_irq(&hdsp->lock);
+	return change;
+}
+
+
 #define HDSP_SPDIF_OUT(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
   .info = snd_hdsp_info_spdif_bits, \
-- 
1.7.10.4
