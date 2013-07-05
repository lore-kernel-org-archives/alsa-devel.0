From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 04/31] ALSA: hdspm - Drop duplicate code in
	hdspm_set_system_clock_mode()
Date: Fri,  5 Jul 2013 11:27:56 +0200
Message-ID: <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
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

hdspm_set_system_clock_mode() is almost a one-by-one copy of
hdspm_set_toggle_setting(). To improve code quality, remove the
duplication.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 118d727..631c546 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -995,6 +995,7 @@ static inline void snd_hdspm_initialize_midi_flush(struct hdspm *hdspm);
 static inline int hdspm_get_pll_freq(struct hdspm *hdspm);
 static int hdspm_update_simple_mixer_controls(struct hdspm *hdspm);
 static int hdspm_autosync_ref(struct hdspm *hdspm);
+static int hdspm_set_toggle_setting(struct hdspm *hdspm, u32 regmask, int out);
 static int snd_hdspm_set_defaults(struct hdspm *hdspm);
 static int hdspm_system_clock_mode(struct hdspm *hdspm);
 static void hdspm_set_sgbuf(struct hdspm *hdspm,
@@ -2384,26 +2385,10 @@ static int hdspm_system_clock_mode(struct hdspm *hdspm)
  **/
 static void hdspm_set_system_clock_mode(struct hdspm *hdspm, int mode)
 {
-	switch (hdspm->io_type) {
-	case AIO:
-	case RayDAT:
-		if (0 == mode)
-			hdspm->settings_register |= HDSPM_c0Master;
-		else
-			hdspm->settings_register &= ~HDSPM_c0Master;
-
-		hdspm_write(hdspm, HDSPM_WR_SETTINGS, hdspm->settings_register);
-		break;
-
-	default:
-		if (0 == mode)
-			hdspm->control_register |= HDSPM_ClockModeMaster;
-		else
-			hdspm->control_register &= ~HDSPM_ClockModeMaster;
-
-		hdspm_write(hdspm, HDSPM_controlRegister,
-				hdspm->control_register);
-	}
+	hdspm_set_toggle_setting(hdspm,
+			(hdspm_is_raydat_or_aio(hdspm)) ?
+			HDSPM_c0Master : HDSPM_ClockModeMaster,
+			(0 == mode));
 }
 
 
-- 
1.8.3.1
