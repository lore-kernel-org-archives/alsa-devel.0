From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/4] ALSA: hdsp - Remove obsolete settings
	functions
Date: Mon, 14 Jan 2013 21:37:20 +0100
Message-ID: <1358195840-8228-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1358195840-8228-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1358195840-8228-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1358195840-8228-3-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1358195840-8228-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

With HDSP_TOGGLE_SETTING in place, these functions are no longer
required. Removing them makes the code DRY and considerably shorter.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index d264bc3..ac333c1 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1768,185 +1768,6 @@ static int snd_hdsp_put_toggle_setting(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-
-#define HDSP_SPDIF_OUT(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_hdsp_info_spdif_bits, \
-  .get = snd_hdsp_get_spdif_out, .put = snd_hdsp_put_spdif_out }
-
-static int hdsp_spdif_out(struct hdsp *hdsp)
-{
-	return (hdsp->control_register & HDSP_SPDIFOpticalOut) ? 1 : 0;
-}
-
-static int hdsp_set_spdif_output(struct hdsp *hdsp, int out)
-{
-	if (out)
-		hdsp->control_register |= HDSP_SPDIFOpticalOut;
-	else
-		hdsp->control_register &= ~HDSP_SPDIFOpticalOut;
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-	return 0;
-}
-
-#define snd_hdsp_info_spdif_bits	snd_ctl_boolean_mono_info
-
-static int snd_hdsp_get_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.integer.value[0] = hdsp_spdif_out(hdsp);
-	return 0;
-}
-
-static int snd_hdsp_put_spdif_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	int change;
-	unsigned int val;
-
-	if (!snd_hdsp_use_is_exclusive(hdsp))
-		return -EBUSY;
-	val = ucontrol->value.integer.value[0] & 1;
-	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_spdif_out(hdsp);
-	hdsp_set_spdif_output(hdsp, val);
-	spin_unlock_irq(&hdsp->lock);
-	return change;
-}
-
-#define HDSP_SPDIF_PROFESSIONAL(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_hdsp_info_spdif_bits, \
-  .get = snd_hdsp_get_spdif_professional, .put = snd_hdsp_put_spdif_professional }
-
-static int hdsp_spdif_professional(struct hdsp *hdsp)
-{
-	return (hdsp->control_register & HDSP_SPDIFProfessional) ? 1 : 0;
-}
-
-static int hdsp_set_spdif_professional(struct hdsp *hdsp, int val)
-{
-	if (val)
-		hdsp->control_register |= HDSP_SPDIFProfessional;
-	else
-		hdsp->control_register &= ~HDSP_SPDIFProfessional;
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-	return 0;
-}
-
-static int snd_hdsp_get_spdif_professional(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.integer.value[0] = hdsp_spdif_professional(hdsp);
-	return 0;
-}
-
-static int snd_hdsp_put_spdif_professional(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	int change;
-	unsigned int val;
-
-	if (!snd_hdsp_use_is_exclusive(hdsp))
-		return -EBUSY;
-	val = ucontrol->value.integer.value[0] & 1;
-	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_spdif_professional(hdsp);
-	hdsp_set_spdif_professional(hdsp, val);
-	spin_unlock_irq(&hdsp->lock);
-	return change;
-}
-
-#define HDSP_SPDIF_EMPHASIS(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_hdsp_info_spdif_bits, \
-  .get = snd_hdsp_get_spdif_emphasis, .put = snd_hdsp_put_spdif_emphasis }
-
-static int hdsp_spdif_emphasis(struct hdsp *hdsp)
-{
-	return (hdsp->control_register & HDSP_SPDIFEmphasis) ? 1 : 0;
-}
-
-static int hdsp_set_spdif_emphasis(struct hdsp *hdsp, int val)
-{
-	if (val)
-		hdsp->control_register |= HDSP_SPDIFEmphasis;
-	else
-		hdsp->control_register &= ~HDSP_SPDIFEmphasis;
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-	return 0;
-}
-
-static int snd_hdsp_get_spdif_emphasis(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.integer.value[0] = hdsp_spdif_emphasis(hdsp);
-	return 0;
-}
-
-static int snd_hdsp_put_spdif_emphasis(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	int change;
-	unsigned int val;
-
-	if (!snd_hdsp_use_is_exclusive(hdsp))
-		return -EBUSY;
-	val = ucontrol->value.integer.value[0] & 1;
-	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_spdif_emphasis(hdsp);
-	hdsp_set_spdif_emphasis(hdsp, val);
-	spin_unlock_irq(&hdsp->lock);
-	return change;
-}
-
-#define HDSP_SPDIF_NON_AUDIO(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex, \
-  .info = snd_hdsp_info_spdif_bits, \
-  .get = snd_hdsp_get_spdif_nonaudio, .put = snd_hdsp_put_spdif_nonaudio }
-
-static int hdsp_spdif_nonaudio(struct hdsp *hdsp)
-{
-	return (hdsp->control_register & HDSP_SPDIFNonAudio) ? 1 : 0;
-}
-
-static int hdsp_set_spdif_nonaudio(struct hdsp *hdsp, int val)
-{
-	if (val)
-		hdsp->control_register |= HDSP_SPDIFNonAudio;
-	else
-		hdsp->control_register &= ~HDSP_SPDIFNonAudio;
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-	return 0;
-}
-
-static int snd_hdsp_get_spdif_nonaudio(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.integer.value[0] = hdsp_spdif_nonaudio(hdsp);
-	return 0;
-}
-
-static int snd_hdsp_put_spdif_nonaudio(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	int change;
-	unsigned int val;
-
-	if (!snd_hdsp_use_is_exclusive(hdsp))
-		return -EBUSY;
-	val = ucontrol->value.integer.value[0] & 1;
-	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_spdif_nonaudio(hdsp);
-	hdsp_set_spdif_nonaudio(hdsp, val);
-	spin_unlock_irq(&hdsp->lock);
-	return change;
-}
-
 #define HDSP_SPDIF_SAMPLE_RATE(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
   .name = xname, \
@@ -2546,114 +2367,6 @@ static int snd_hdsp_put_phone_gain(struct snd_kcontrol *kcontrol, struct snd_ctl
 	return change;
 }
 
-#define HDSP_XLR_BREAKOUT_CABLE(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdsp_info_xlr_breakout_cable, \
-  .get = snd_hdsp_get_xlr_breakout_cable, \
-  .put = snd_hdsp_put_xlr_breakout_cable \
-}
-
-static int hdsp_xlr_breakout_cable(struct hdsp *hdsp)
-{
-	if (hdsp->control_register & HDSP_XLRBreakoutCable)
-		return 1;
-	return 0;
-}
-
-static int hdsp_set_xlr_breakout_cable(struct hdsp *hdsp, int mode)
-{
-	if (mode)
-		hdsp->control_register |= HDSP_XLRBreakoutCable;
-	else
-		hdsp->control_register &= ~HDSP_XLRBreakoutCable;
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-	return 0;
-}
-
-#define snd_hdsp_info_xlr_breakout_cable	snd_ctl_boolean_mono_info
-
-static int snd_hdsp_get_xlr_breakout_cable(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.enumerated.item[0] = hdsp_xlr_breakout_cable(hdsp);
-	return 0;
-}
-
-static int snd_hdsp_put_xlr_breakout_cable(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	int change;
-	int val;
-
-	if (!snd_hdsp_use_is_exclusive(hdsp))
-		return -EBUSY;
-	val = ucontrol->value.integer.value[0] & 1;
-	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_xlr_breakout_cable(hdsp);
-	hdsp_set_xlr_breakout_cable(hdsp, val);
-	spin_unlock_irq(&hdsp->lock);
-	return change;
-}
-
-/* (De)activates old RME Analog Extension Board
-   These are connected to the internal ADAT connector
-   Switching this on desactivates external ADAT
-*/
-#define HDSP_AEB(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdsp_info_aeb, \
-  .get = snd_hdsp_get_aeb, \
-  .put = snd_hdsp_put_aeb \
-}
-
-static int hdsp_aeb(struct hdsp *hdsp)
-{
-	if (hdsp->control_register & HDSP_AnalogExtensionBoard)
-		return 1;
-	return 0;
-}
-
-static int hdsp_set_aeb(struct hdsp *hdsp, int mode)
-{
-	if (mode)
-		hdsp->control_register |= HDSP_AnalogExtensionBoard;
-	else
-		hdsp->control_register &= ~HDSP_AnalogExtensionBoard;
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-	return 0;
-}
-
-#define snd_hdsp_info_aeb		snd_ctl_boolean_mono_info
-
-static int snd_hdsp_get_aeb(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.enumerated.item[0] = hdsp_aeb(hdsp);
-	return 0;
-}
-
-static int snd_hdsp_put_aeb(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	int change;
-	int val;
-
-	if (!snd_hdsp_use_is_exclusive(hdsp))
-		return -EBUSY;
-	val = ucontrol->value.integer.value[0] & 1;
-	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_aeb(hdsp);
-	hdsp_set_aeb(hdsp, val);
-	spin_unlock_irq(&hdsp->lock);
-	return change;
-}
-
 #define HDSP_PREF_SYNC_REF(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
   .name = xname, \
@@ -2842,58 +2555,6 @@ static int snd_hdsp_get_autosync_ref(struct snd_kcontrol *kcontrol, struct snd_c
 	return 0;
 }
 
-#define HDSP_LINE_OUT(xname, xindex) \
-{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-  .name = xname, \
-  .index = xindex, \
-  .info = snd_hdsp_info_line_out, \
-  .get = snd_hdsp_get_line_out, \
-  .put = snd_hdsp_put_line_out \
-}
-
-static int hdsp_line_out(struct hdsp *hdsp)
-{
-	return (hdsp->control_register & HDSP_LineOut) ? 1 : 0;
-}
-
-static int hdsp_set_line_output(struct hdsp *hdsp, int out)
-{
-	if (out)
-		hdsp->control_register |= HDSP_LineOut;
-	else
-		hdsp->control_register &= ~HDSP_LineOut;
-	hdsp_write(hdsp, HDSP_controlRegister, hdsp->control_register);
-	return 0;
-}
-
-#define snd_hdsp_info_line_out		snd_ctl_boolean_mono_info
-
-static int snd_hdsp_get_line_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-
-	spin_lock_irq(&hdsp->lock);
-	ucontrol->value.integer.value[0] = hdsp_line_out(hdsp);
-	spin_unlock_irq(&hdsp->lock);
-	return 0;
-}
-
-static int snd_hdsp_put_line_out(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
-{
-	struct hdsp *hdsp = snd_kcontrol_chip(kcontrol);
-	int change;
-	unsigned int val;
-
-	if (!snd_hdsp_use_is_exclusive(hdsp))
-		return -EBUSY;
-	val = ucontrol->value.integer.value[0] & 1;
-	spin_lock_irq(&hdsp->lock);
-	change = (int)val != hdsp_line_out(hdsp);
-	hdsp_set_line_output(hdsp, val);
-	spin_unlock_irq(&hdsp->lock);
-	return change;
-}
-
 #define HDSP_PRECISE_POINTER(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_CARD, \
   .name = xname, \
-- 
1.7.10.4
