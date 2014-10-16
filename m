From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 1/2] thinkpad-acpi: Try to use full software mute control
Date: Thu, 16 Oct 2014 11:02:17 -0700
Message-ID: <72f375b46a34702fc9f8be419fa83c219fbc28c5.1413481880.git.luto@amacapital.net>
References: <cover.1413481880.git.luto@amacapital.net>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <cover.1413481880.git.luto@amacapital.net>
In-Reply-To: <cover.1413481880.git.luto@amacapital.net>
References: <cover.1413481880.git.luto@amacapital.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net
Cc: Len Brown <len.brown@intel.com>, Jerone Young <jerone.young@canonical.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@MIT.EDU>, Andy Lutomirski <luto@mit.edu>
List-Id: alsa-devel@alsa-project.org

From: Andy Lutomirski <luto@MIT.EDU>

ThinkPads have hardware volume controls and three buttons to control
them.  (These are separate from the standard mixer.)  By default,
the buttons are:

 - Mute: Mutes the hardware volume control and generates KEY_MUTE.
 - Up: Unmutes, generates KEY_VOLUMEUP, and increases volume if
   applicable.  (Newer thinkpads only have hardware mute/unmute.)
 - Down: Unmutes, generates KEY_VOLUMEDOWN, and decreases volume
   if applicable.

This behavior is unfortunate, since modern userspace will also
handle the hotkeys and change the other mixer.  If the software
mixer is muted and the hardware mixer is unmuted and you push mute,
hilarity ensues as they both switch state.

Rather than adding a lot of complex ALSA integration to fix this,
just disable the special ThinkPad volume controls when possible.
This turns the mute and volume buttons into regular buttons, and
standard software controls will work as expected.

ALSA already knows about the mute light on models with a mute light,
so everything should just work.

This should also allow us to remove _OSI(Linux) for all ThinkPads.

For future reference: It turns out that we can ask ACPI for one of
three behaviors directly on very new models.  They are "latch" (the
default), "none" (no automatic control), and "toggle" (mute unmutes
when muted).  All of the modes besides "none" seem to be a bit buggy,
though, and there is no known way to get any notification that the
hardware state has changed other than listening for a mute button
press on the i8042 port.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 drivers/platform/x86/thinkpad_acpi.c | 107 +++++++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3bbc6eb60de5..9c8e17ec4b14 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6559,6 +6559,16 @@ static struct ibm_struct brightness_driver_data = {
  * bits 3-0 (volume).  Other bits in NVRAM may have other functions,
  * such as bit 7 which is used to detect repeated presses of MUTE,
  * and we leave them unchanged.
+ *
+ * The EC or perhaps SMM firmware can optionally automatically change
+ * the volume in response to user input.  Unfortunately, this rarely
+ * works well.  The laptop changes the state of its internal MUTE gate
+ * *and* sends KEY_MUTE, causing any user code that responds to the mute
+ * button to get confused.  The hardware MUTE gate is also unnecessary,
+ * since user code can handle the mute button without kernel or EC help.
+ *
+ * To avoid confusing userspace, we simply disable all EC-based mute
+ * and volume controls when possible.
  */
 
 #ifdef CONFIG_THINKPAD_ACPI_ALSA_SUPPORT
@@ -6613,11 +6623,20 @@ enum tpacpi_volume_capabilities {
 	TPACPI_VOL_CAP_MAX
 };
 
+enum tpacpi_mute_btn_mode {
+	TP_EC_MUTE_BTN_LATCH  = 0,	/* Mute mutes; up/down unmutes */
+	/* We don't know what mode 1 is. */
+	TP_EC_MUTE_BTN_NONE   = 2,	/* Mute and up/down are just keys */
+	TP_EC_MUTE_BTN_TOGGLE = 3,	/* Mute toggles; up/down unmutes */
+};
+
 static enum tpacpi_volume_access_mode volume_mode =
 	TPACPI_VOL_MODE_MAX;
 
 static enum tpacpi_volume_capabilities volume_capabilities;
 static bool volume_control_allowed;
+static bool software_mute_requested = true;
+static bool software_mute_active;
 
 /*
  * Used to syncronize writers to TP_EC_AUDIO and
@@ -6635,6 +6654,8 @@ static void tpacpi_volume_checkpoint_nvram(void)
 		return;
 	if (!volume_control_allowed)
 		return;
+	if (software_mute_active)
+		return;
 
 	vdbg_printk(TPACPI_DBG_MIXER,
 		"trying to checkpoint mixer state to NVRAM...\n");
@@ -6696,6 +6717,12 @@ static int volume_set_status_ec(const u8 status)
 
 	dbg_printk(TPACPI_DBG_MIXER, "set EC mixer to 0x%02x\n", status);
 
+	/*
+	 * On X200s, and possibly on others, it can take a while for
+	 * reads to become correct.
+	 */
+	msleep(1);
+
 	return 0;
 }
 
@@ -6778,6 +6805,38 @@ unlock:
 	return rc;
 }
 
+static int volume_set_software_mute(bool verbose)
+{
+	int rc = 0;
+	int result;
+
+	if (mutex_lock_killable(&volume_mutex) < 0)
+		return -EINTR;
+
+	if (verbose) {
+		if (!acpi_evalf(ec_handle, &result, "HAUM", "qd"))
+			return -EIO;
+
+		dbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
+			    "Initial HAUM setting was %d\n",
+			    result);
+	}
+
+	if (!acpi_evalf(ec_handle, &result, "SAUM", "qdd",
+			(int)TP_EC_MUTE_BTN_NONE)) {
+		rc = -EIO;
+		goto out;
+	}
+
+	if (result != TP_EC_MUTE_BTN_NONE)
+		pr_warn("thinkpad_acpi: Unexpected SAUM result %d\n",
+			result);
+
+out:
+	mutex_unlock(&volume_mutex);
+	return rc;
+}
+
 static int volume_alsa_set_volume(const u8 vol)
 {
 	dbg_printk(TPACPI_DBG_MIXER,
@@ -6885,7 +6944,12 @@ static void volume_suspend(void)
 
 static void volume_resume(void)
 {
-	volume_alsa_notify_change();
+	if (software_mute_active) {
+		if (volume_set_software_mute(false) < 0)
+			pr_warn("thinkpad_acpi: failed to restore software mute\n");
+	} else {
+		volume_alsa_notify_change();
+	}
 }
 
 static void volume_shutdown(void)
@@ -7004,6 +7068,8 @@ static const struct tpacpi_quirk volume_quirk_table[] __initconst = {
 	  .quirks = TPACPI_VOL_Q_MUTEONLY }
 };
 
+static int volume_write(char *buf);
+
 static int __init volume_init(struct ibm_init_struct *iibm)
 {
 	unsigned long quirks;
@@ -7085,16 +7151,33 @@ static int __init volume_init(struct ibm_init_struct *iibm)
 			"mute is supported, volume control is %s\n",
 			str_supported(!tp_features.mixer_no_level_control));
 
-	rc = volume_create_alsa_mixer();
-	if (rc) {
-		pr_err("Could not create the ALSA mixer interface\n");
-		return rc;
-	}
+	if (software_mute_requested && volume_set_software_mute(true) == 0) {
+		char unmute_cmd[] = "unmute,level 14";  /* must be non-const */
+		BUILD_BUG_ON(TP_EC_VOLUME_MAX != 14);
+
+		software_mute_active = true;
+
+		/*
+		 * In software mute mode, the standard codec controls
+		 * take precendence, so we unmute the ThinkPad HW switch
+		 * at startup.  Just on case there are SAUM-capable
+		 * ThinkPads with level controls, set max HW volume as
+		 * well.
+		 */
+		if (volume_write(unmute_cmd) != 0)
+			pr_warn("Failed to unmute ThinkPad HW\n");
+	} else {
+		rc = volume_create_alsa_mixer();
+		if (rc) {
+			pr_err("Could not create the ALSA mixer interface\n");
+			return rc;
+		}
 
-	pr_info("Console audio control enabled, mode: %s\n",
-		(volume_control_allowed) ?
-			"override (read/write)" :
-			"monitor (read only)");
+		pr_info("Console audio control enabled, mode: %s\n",
+			(volume_control_allowed) ?
+				"override (read/write)" :
+				"monitor (read only)");
+	}
 
 	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_MIXER,
 		"registering volume hotkeys as change notification\n");
@@ -9091,6 +9174,10 @@ MODULE_PARM_DESC(volume_control,
 		 "Enables software override for the console audio "
 		 "control when true");
 
+module_param_named(software_mute, software_mute_requested, bool, 0444);
+MODULE_PARM_DESC(software_mute,
+		 "Request full software mute control");
+
 /* ALSA module API parameters */
 module_param_named(index, alsa_index, int, 0444);
 MODULE_PARM_DESC(index, "ALSA index for the ACPI EC Mixer");
-- 
1.9.3
