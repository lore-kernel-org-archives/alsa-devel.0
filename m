From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH v3 3/4] ALSA: hdsp - Use HDSP_TOGGLE_SETTING to
	alter settings
Date: Tue, 15 Jan 2013 18:52:22 +0100
Message-ID: <1358272343-19606-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1358272343-19606-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1358272343-19606-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1358272343-19606-3-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1358272343-19606-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

HDSP_TOGGLE_SETTING and its corresponding functions allow to change
settings in the control register. Instead of using the specialised
functions, use the generic code to make the code DRY.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 4ebd283..ae79695 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3288,7 +3288,7 @@ static struct snd_kcontrol_new snd_hdsp_9632_controls[] = {
 HDSP_DA_GAIN("DA Gain", 0),
 HDSP_AD_GAIN("AD Gain", 0),
 HDSP_PHONE_GAIN("Phones Gain", 0),
-HDSP_XLR_BREAKOUT_CABLE("XLR Breakout Cable", 0),
+HDSP_TOGGLE_SETTING("XLR Breakout Cable", HDSP_XLRBreakoutCable),
 HDSP_DDS_OFFSET("DDS Sample Rate Offset", 0)
 };
 
@@ -3330,10 +3330,10 @@ static struct snd_kcontrol_new snd_hdsp_controls[] = {
 },
 HDSP_MIXER("Mixer", 0),
 HDSP_SPDIF_IN("IEC958 Input Connector", 0),
-HDSP_SPDIF_OUT("IEC958 Output also on ADAT1", 0),
-HDSP_SPDIF_PROFESSIONAL("IEC958 Professional Bit", 0),
-HDSP_SPDIF_EMPHASIS("IEC958 Emphasis Bit", 0),
-HDSP_SPDIF_NON_AUDIO("IEC958 Non-audio Bit", 0),
+HDSP_TOGGLE_SETTING("IEC958 Output also on ADAT1", HDSP_SPDIFOpticalOut),
+HDSP_TOGGLE_SETTING("IEC958 Professional Bit", HDSP_SPDIFProfessional),
+HDSP_TOGGLE_SETTING("IEC958 Emphasis Bit", HDSP_SPDIFEmphasis),
+HDSP_TOGGLE_SETTING("IEC958 Non-audio Bit", HDSP_SPDIFNonAudio),
 /* 'Sample Clock Source' complies with the alsa control naming scheme */
 HDSP_CLOCK_SOURCE("Sample Clock Source", 0),
 {
@@ -3353,7 +3353,7 @@ HDSP_AUTOSYNC_SAMPLE_RATE("External Rate", 0),
 HDSP_WC_SYNC_CHECK("Word Clock Lock Status", 0),
 HDSP_SPDIF_SYNC_CHECK("SPDIF Lock Status", 0),
 HDSP_ADATSYNC_SYNC_CHECK("ADAT Sync Lock Status", 0),
-HDSP_LINE_OUT("Line Out", 0),
+HDSP_TOGGLE_SETTING("Line Out", HDSP_LineOut),
 HDSP_PRECISE_POINTER("Precise Pointer", 0),
 HDSP_USE_MIDI_TASKLET("Use Midi Tasklet", 0),
 };
@@ -3670,7 +3670,9 @@ static struct snd_kcontrol_new snd_hdsp_rpm_controls[] = {
 	HDSP_MIXER("Mixer", 0)
 };
 
-static struct snd_kcontrol_new snd_hdsp_96xx_aeb = HDSP_AEB("Analog Extension Board", 0);
+static struct snd_kcontrol_new snd_hdsp_96xx_aeb =
+	HDSP_TOGGLE_SETTING("Analog Extension Board",
+			HDSP_AnalogExtensionBoard);
 static struct snd_kcontrol_new snd_hdsp_adat_sync_check = HDSP_ADAT_SYNC_CHECK;
 
 static int snd_hdsp_create_controls(struct snd_card *card, struct hdsp *hdsp)
@@ -4093,7 +4095,9 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		}
 		snd_iprintf(buffer, "Phones Gain : %s\n", tmp);
 
-		snd_iprintf(buffer, "XLR Breakout Cable : %s\n", hdsp_xlr_breakout_cable(hdsp) ? "yes" : "no");
+		snd_iprintf(buffer, "XLR Breakout Cable : %s\n",
+			hdsp_toggle_setting(hdsp, HDSP_XLRBreakoutCable) ?
+			"yes" : "no");
 
 		if (hdsp->control_register & HDSP_AnalogExtensionBoard)
 			snd_iprintf(buffer, "AEB : on (ADAT1 internal)\n");
@@ -5124,29 +5128,38 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		for (i = 0; i < ((hdsp->io_type != Multiface && hdsp->io_type != RPM && hdsp->io_type != H9632) ? 3 : 1); ++i)
 			info.adat_sync_check[i] = (unsigned char)hdsp_adat_sync_check(hdsp, i);
 		info.spdif_in = (unsigned char)hdsp_spdif_in(hdsp);
-		info.spdif_out = (unsigned char)hdsp_spdif_out(hdsp);
-		info.spdif_professional = (unsigned char)hdsp_spdif_professional(hdsp);
-		info.spdif_emphasis = (unsigned char)hdsp_spdif_emphasis(hdsp);
-		info.spdif_nonaudio = (unsigned char)hdsp_spdif_nonaudio(hdsp);
+		info.spdif_out = (unsigned char)hdsp_toggle_setting(hdsp,
+				HDSP_SPDIFOpticalOut);
+		info.spdif_professional = (unsigned char)
+			hdsp_toggle_setting(hdsp, HDSP_SPDIFProfessional);
+		info.spdif_emphasis = (unsigned char)
+			hdsp_toggle_setting(hdsp, HDSP_SPDIFEmphasis);
+		info.spdif_nonaudio = (unsigned char)
+			hdsp_toggle_setting(hdsp, HDSP_SPDIFNonAudio);
 		info.spdif_sample_rate = hdsp_spdif_sample_rate(hdsp);
 		info.system_sample_rate = hdsp->system_sample_rate;
 		info.autosync_sample_rate = hdsp_external_sample_rate(hdsp);
 		info.system_clock_mode = (unsigned char)hdsp_system_clock_mode(hdsp);
 		info.clock_source = (unsigned char)hdsp_clock_source(hdsp);
 		info.autosync_ref = (unsigned char)hdsp_autosync_ref(hdsp);
-		info.line_out = (unsigned char)hdsp_line_out(hdsp);
+		info.line_out = (unsigned char)
+			hdsp_toggle_setting(hdsp, HDSP_LineOut);
 		if (hdsp->io_type == H9632) {
 			info.da_gain = (unsigned char)hdsp_da_gain(hdsp);
 			info.ad_gain = (unsigned char)hdsp_ad_gain(hdsp);
 			info.phone_gain = (unsigned char)hdsp_phone_gain(hdsp);
-			info.xlr_breakout_cable = (unsigned char)hdsp_xlr_breakout_cable(hdsp);
+			info.xlr_breakout_cable =
+				(unsigned char)hdsp_toggle_setting(hdsp,
+					HDSP_XLRBreakoutCable);
 
 		} else if (hdsp->io_type == RPM) {
 			info.da_gain = (unsigned char) hdsp_rpm_input12(hdsp);
 			info.ad_gain = (unsigned char) hdsp_rpm_input34(hdsp);
 		}
 		if (hdsp->io_type == H9632 || hdsp->io_type == H9652)
-			info.analog_extension_board = (unsigned char)hdsp_aeb(hdsp);
+			info.analog_extension_board =
+				(unsigned char)hdsp_toggle_setting(hdsp,
+					    HDSP_AnalogExtensionBoard);
 		spin_unlock_irqrestore(&hdsp->lock, flags);
 		if (copy_to_user(argp, &info, sizeof(info)))
 			return -EFAULT;
-- 
1.7.10.4
