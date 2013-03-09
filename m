From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/7] ALSA: hdspm - Allow the TCO and SYNC-IN to
	be used in slave mode
Date: Sun, 10 Mar 2013 00:37:22 +0100
Message-ID: <1362872247-29029-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
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

When using the additional Time Code Option module in slave mode or the
SYNC-In wordclock connector, the sample rate needs to be returned by
hdspm_external_sample_rate().

Since this sample rate may contain any value with 1Hz granularity, we
need to round it to a common rate as done by the OSX driver.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 50cba5c..830a899 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1076,6 +1076,17 @@ static int snd_hdspm_use_is_exclusive(struct hdspm *hdspm)
 	return ret;
 }
 
+/* round arbitary sample rates to commonly known rates */
+static int hdspm_round_frequency(int rate)
+{
+	if (rate < 38050)
+		return 32000;
+	if (rate < 46008)
+		return 44100;
+	else
+		return 48000;
+}
+
 /* check for external sample rate */
 static int hdspm_external_sample_rate(struct hdspm *hdspm)
 {
@@ -1217,21 +1228,44 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 				break;
 			}
 
-			/* QS and DS rates normally can not be detected
-			 * automatically by the card. Only exception is MADI
-			 * in 96k frame mode.
-			 *
-			 * So if we read SS values (32 .. 48k), check for
-			 * user-provided DS/QS bits in the control register
-			 * and multiply the base frequency accordingly.
-			 */
-			if (rate <= 48000) {
-				if (hdspm->control_register & HDSPM_QuadSpeed)
-					rate *= 4;
-				else if (hdspm->control_register &
-						HDSPM_DoubleSpeed)
-					rate *= 2;
+		} /* endif HDSPM_madiLock */
+
+		/* check sample rate from TCO or SYNC_IN */
+		{
+			bool is_valid_input = 0;
+			bool has_sync = 0;
+
+			syncref = hdspm_autosync_ref(hdspm);
+			if (HDSPM_AUTOSYNC_FROM_TCO == syncref) {
+				is_valid_input = 1;
+				has_sync = (HDSPM_SYNC_CHECK_SYNC ==
+					hdspm_tco_sync_check(hdspm));
+			} else if (HDSPM_AUTOSYNC_FROM_SYNC_IN == syncref) {
+				is_valid_input = 1;
+				has_sync = (HDSPM_SYNC_CHECK_SYNC ==
+					hdspm_sync_in_sync_check(hdspm));
 			}
+
+			if (is_valid_input && has_sync) {
+				rate = hdspm_round_frequency(
+					hdspm_get_pll_freq(hdspm));
+			}
+		}
+
+		/* QS and DS rates normally can not be detected
+		 * automatically by the card. Only exception is MADI
+		 * in 96k frame mode.
+		 *
+		 * So if we read SS values (32 .. 48k), check for
+		 * user-provided DS/QS bits in the control register
+		 * and multiply the base frequency accordingly.
+		 */
+		if (rate <= 48000) {
+			if (hdspm->control_register & HDSPM_QuadSpeed)
+				rate *= 4;
+			else if (hdspm->control_register &
+					HDSPM_DoubleSpeed)
+				rate *= 2;
 		}
 		break;
 	}
-- 
1.7.10.4
