From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 03/11] ALSA: hdspm - Augment
	HDSPM_TOGGLE_SETTING for AIO/RayDAT
Date: Thu,  4 Jul 2013 15:16:30 +0200
Message-ID: <1372943796-18998-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1372943796-18998-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1372943796-18998-3-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1372943796-18998-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

The HDSPM_TOGGLE_SETTING functions alter the control_register on older
cards. On newer cards (AIO/RayDAT), they have to operate on the
settings_register instead.

This patch augments the existing functions to work with AIO/RayDAT, too.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 32a87dc..118d727 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3092,16 +3092,35 @@ static int snd_hdspm_get_tco_ltc_frames(struct snd_kcontrol *kcontrol,
 
 static int hdspm_toggle_setting(struct hdspm *hdspm, u32 regmask)
 {
-	return (hdspm->control_register & regmask) ? 1 : 0;
+	u32 reg;
+
+	if (hdspm_is_raydat_or_aio(hdspm))
+		reg = hdspm->settings_register;
+	else
+		reg = hdspm->control_register;
+
+	return (reg & regmask) ? 1 : 0;
 }
 
 static int hdspm_set_toggle_setting(struct hdspm *hdspm, u32 regmask, int out)
 {
+	u32 *reg;
+	u32 target_reg;
+
+	if (hdspm_is_raydat_or_aio(hdspm)) {
+		reg = &(hdspm->settings_register);
+		target_reg = HDSPM_WR_SETTINGS;
+	} else {
+		reg = &(hdspm->control_register);
+		target_reg = HDSPM_controlRegister;
+	}
+
 	if (out)
-		hdspm->control_register |= regmask;
+		*reg |= regmask;
 	else
-		hdspm->control_register &= ~regmask;
-	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
+		*reg &= ~regmask;
+
+	hdspm_write(hdspm, target_reg, *reg);
 
 	return 0;
 }
-- 
1.8.3.1
