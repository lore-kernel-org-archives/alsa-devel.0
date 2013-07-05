From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 22/31] ALSA: hdspm - AES32: Enable TCO input
	in hdspm_external_sample_rate()
Date: Fri,  5 Jul 2013 11:28:14 +0200
Message-ID: <1373016503-9474-23-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-15-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-16-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-18-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-19-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-20-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-21-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-22-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-22-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch adds support to read the TCO sample rate in
hdspm_external_sample_rate() on RME AES(32) cards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index a9f4c7c..80b2247 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1176,17 +1176,36 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 		timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
 
 		syncref = hdspm_autosync_ref(hdspm);
+		switch (syncref) {
+		case HDSPM_AES32_AUTOSYNC_FROM_WORD:
+		/* Check WC sync and get sample rate */
+			if (hdspm_wc_sync_check(hdspm))
+				return HDSPM_bit2freq(hdspm_get_wc_sample_rate(hdspm));
+			break;
+
+		case HDSPM_AES32_AUTOSYNC_FROM_AES1:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES2:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES3:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES4:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES5:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES6:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES7:
+		case HDSPM_AES32_AUTOSYNC_FROM_AES8:
+		/* Check AES sync and get sample rate */
+			if (hdspm_aes_sync_check(hdspm, syncref - HDSPM_AES32_AUTOSYNC_FROM_AES1))
+				return HDSPM_bit2freq(hdspm_get_aes_sample_rate(hdspm,
+							syncref - HDSPM_AES32_AUTOSYNC_FROM_AES1));
+			break;
 
-		if (syncref == HDSPM_AES32_AUTOSYNC_FROM_WORD &&
-				status & HDSPM_AES32_wcLock)
-			return HDSPM_bit2freq((status >> HDSPM_AES32_wcFreq_bit) & 0xF);
 
-		if (syncref >= HDSPM_AES32_AUTOSYNC_FROM_AES1 &&
-				syncref <= HDSPM_AES32_AUTOSYNC_FROM_AES8 &&
-				status2 & (HDSPM_LockAES >>
-				(syncref - HDSPM_AES32_AUTOSYNC_FROM_AES1)))
-			return HDSPM_bit2freq((timecode >> (4*(syncref-HDSPM_AES32_AUTOSYNC_FROM_AES1))) & 0xF);
-		return 0;
+		case HDSPM_AES32_AUTOSYNC_FROM_TCO:
+		/* Check TCO sync and get sample rate */
+			if (hdspm_tco_sync_check(hdspm))
+				return HDSPM_bit2freq(hdspm_get_tco_sample_rate(hdspm));
+			break;
+		default:
+			return 0;
+		} /* end switch(syncref) */
 		break;
 
 	case MADIface:
-- 
1.8.3.1
