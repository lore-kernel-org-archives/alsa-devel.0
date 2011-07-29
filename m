From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] ALSA: hdspm - Provide MADI speed mode
	selector on RME MADI and MADIface
Date: Fri, 29 Jul 2011 03:11:02 +0200
Message-ID: <1311901864-29021-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <y> <1311901864-29021-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311901864-29021-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When running in slave mode (no clock master), there is no way to
determine the real wirespeed on the MADI link (single/double/quad
speed). Like physical gear, simply provide the user with a tristate
switch to select the appropriate format.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index af130ee..d219649 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3415,6 +3415,91 @@ static int snd_hdspm_put_qs_wire(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
+#define HDSPM_MADI_SPEEDMODE(xname, xindex) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.index = xindex, \
+	.info = snd_hdspm_info_madi_speedmode, \
+	.get = snd_hdspm_get_madi_speedmode, \
+	.put = snd_hdspm_put_madi_speedmode \
+}
+
+static int hdspm_madi_speedmode(struct hdspm *hdspm)
+{
+	if (hdspm->control_register & HDSPM_QuadSpeed)
+		return 2;
+	if (hdspm->control_register & HDSPM_DoubleSpeed)
+		return 1;
+	return 0;
+}
+
+static int hdspm_set_madi_speedmode(struct hdspm *hdspm, int mode)
+{
+	hdspm->control_register &= ~(HDSPM_DoubleSpeed | HDSPM_QuadSpeed);
+	switch (mode) {
+	case 0:
+		break;
+	case 1:
+		hdspm->control_register |= HDSPM_DoubleSpeed;
+		break;
+	case 2:
+		hdspm->control_register |= HDSPM_QuadSpeed;
+		break;
+	}
+	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+
+	return 0;
+}
+
+static int snd_hdspm_info_madi_speedmode(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = { "Single", "Double", "Quad" };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 3;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item =
+		    uinfo->value.enumerated.items - 1;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_hdspm_get_madi_speedmode(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
+
+	spin_lock_irq(&hdspm->lock);
+	ucontrol->value.enumerated.item[0] = hdspm_madi_speedmode(hdspm);
+	spin_unlock_irq(&hdspm->lock);
+	return 0;
+}
+
+static int snd_hdspm_put_madi_speedmode(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
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
+	spin_lock_irq(&hdspm->lock);
+	change = val != hdspm_madi_speedmode(hdspm);
+	hdspm_set_madi_speedmode(hdspm, val);
+	spin_unlock_irq(&hdspm->lock);
+	return change;
+}
 
 #define HDSPM_MIXER(xname, xindex) \
 { .iface = SNDRV_CTL_ELEM_IFACE_HWDEP, \
@@ -4289,7 +4374,8 @@ static struct snd_kcontrol_new snd_hdspm_controls_madi[] = {
 	HDSPM_TX_64("TX 64 channels mode", 0),
 	HDSPM_C_TMS("Clear Track Marker", 0),
 	HDSPM_SAFE_MODE("Safe Mode", 0),
-	HDSPM_INPUT_SELECT("Input Select", 0)
+	HDSPM_INPUT_SELECT("Input Select", 0),
+	HDSPM_MADI_SPEEDMODE("MADI Speed Mode", 0)
 };
 
 
@@ -4302,7 +4388,8 @@ static struct snd_kcontrol_new snd_hdspm_controls_madiface[] = {
 	HDSPM_SYNC_CHECK("MADI SyncCheck", 0),
 	HDSPM_TX_64("TX 64 channels mode", 0),
 	HDSPM_C_TMS("Clear Track Marker", 0),
-	HDSPM_SAFE_MODE("Safe Mode", 0)
+	HDSPM_SAFE_MODE("Safe Mode", 0),
+	HDSPM_MADI_SPEEDMODE("MADI Speed Mode", 0)
 };
 
 static struct snd_kcontrol_new snd_hdspm_controls_aio[] = {
-- 
1.7.5.4
