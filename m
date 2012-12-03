From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] ALSA: hdspm - Use HDSPM_TOGGLE_SETTING to
	alter settings
Date: Mon,  3 Dec 2012 14:55:50 +0100
Message-ID: <1354542951-1588-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

HDSPM_TOGGLE_SETTING and its corresponding functions allow to change
settings in the control register. Instead of using the specialised
functions, use the generic code to make the code DRY.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 002e692..f958e20 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -4533,10 +4533,10 @@ static struct snd_kcontrol_new snd_hdspm_controls_madi[] = {
 	HDSPM_SYNC_CHECK("MADI SyncCheck", 1),
 	HDSPM_SYNC_CHECK("TCO SyncCheck", 2),
 	HDSPM_SYNC_CHECK("SYNC IN SyncCheck", 3),
-	HDSPM_LINE_OUT("Line Out", 0),
-	HDSPM_TX_64("TX 64 channels mode", 0),
-	HDSPM_C_TMS("Clear Track Marker", 0),
-	HDSPM_SAFE_MODE("Safe Mode", 0),
+	HDSPM_TOGGLE_SETTING("Line Out", HDSPM_LineOut),
+	HDSPM_TOGGLE_SETTING("TX 64 channels mode", HDSPM_TX_64ch),
+	HDSPM_TOGGLE_SETTING("Clear Track Marker", HDSPM_clr_tms),
+	HDSPM_TOGGLE_SETTING("Safe Mode", HDSPM_AutoInp),
 	HDSPM_INPUT_SELECT("Input Select", 0),
 	HDSPM_MADI_SPEEDMODE("MADI Speed Mode", 0)
 };
@@ -4549,9 +4549,9 @@ static struct snd_kcontrol_new snd_hdspm_controls_madiface[] = {
 	HDSPM_SYSTEM_SAMPLE_RATE("System Sample Rate", 0),
 	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 0),
 	HDSPM_SYNC_CHECK("MADI SyncCheck", 0),
-	HDSPM_TX_64("TX 64 channels mode", 0),
-	HDSPM_C_TMS("Clear Track Marker", 0),
-	HDSPM_SAFE_MODE("Safe Mode", 0),
+	HDSPM_TOGGLE_SETTING("TX 64 channels mode", HDSPM_TX_64ch),
+	HDSPM_TOGGLE_SETTING("Clear Track Marker", HDSPM_clr_tms),
+	HDSPM_TOGGLE_SETTING("Safe Mode", HDSPM_AutoInp),
 	HDSPM_MADI_SPEEDMODE("MADI Speed Mode", 0)
 };
 
@@ -4644,11 +4644,11 @@ static struct snd_kcontrol_new snd_hdspm_controls_aes32[] = {
 	HDSPM_AUTOSYNC_SAMPLE_RATE("AES8 Frequency", 8),
 	HDSPM_AUTOSYNC_SAMPLE_RATE("TCO Frequency", 9),
 	HDSPM_AUTOSYNC_SAMPLE_RATE("SYNC IN Frequency", 10),
-	HDSPM_LINE_OUT("Line Out", 0),
-	HDSPM_EMPHASIS("Emphasis", 0),
-	HDSPM_DOLBY("Non Audio", 0),
-	HDSPM_PROFESSIONAL("Professional", 0),
-	HDSPM_C_TMS("Clear Track Marker", 0),
+	HDSPM_TOGGLE_SETTING("Line Out", HDSPM_LineOut),
+	HDSPM_TOGGLE_SETTING("Emphasis", HDSPM_Emphasis),
+	HDSPM_TOGGLE_SETTING("Non Audio", HDSPM_Dolby),
+	HDSPM_TOGGLE_SETTING("Professional", HDSPM_Professional),
+	HDSPM_TOGGLE_SETTING("Clear Track Marker", HDSPM_clr_tms),
 	HDSPM_DS_WIRE("Double Speed Wire Mode", 0),
 	HDSPM_QS_WIRE("Quad Speed Wire Mode", 0),
 };
@@ -6323,7 +6323,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 		info.system_clock_mode = hdspm_system_clock_mode(hdspm);
 		info.clock_source = hdspm_clock_source(hdspm);
 		info.autosync_ref = hdspm_autosync_ref(hdspm);
-		info.line_out = hdspm_line_out(hdspm);
+		info.line_out = hdspm_toggle_setting(hdspm, HDSPM_LineOut);
 		info.passthru = 0;
 		spin_unlock_irq(&hdspm->lock);
 		if (copy_to_user(argp, &info, sizeof(info)))
-- 
1.7.10.4
