From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] ALSA: hdspm - Refactor SS/DS/QS clock
	multiplier into function
Date: Fri, 31 May 2013 12:57:10 +0200
Message-ID: <1369997831-7274-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1369997831-7274-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1369997831-7274-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

When the DoubleSpeed or QuadSpeed bit is set, the SingleSpeed frequency
has to be multiplied accordingly. Since this functionality will be
required at least twice, refactor it into a separate function.

The second reference to the newly introduced hdspm_rate_multiplier()
will be in a separate commit.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index e070ea8..8eb2070 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1091,6 +1091,26 @@ static int hdspm_round_frequency(int rate)
 		return 48000;
 }
 
+/* QS and DS rates normally can not be detected
+ * automatically by the card. Only exception is MADI
+ * in 96k frame mode.
+ *
+ * So if we read SS values (32 .. 48k), check for
+ * user-provided DS/QS bits in the control register
+ * and multiply the base frequency accordingly.
+ */
+static int hdspm_rate_multiplier(struct hdspm *hdspm, int rate)
+{
+	if (rate <= 48000) {
+		if (hdspm->control_register & HDSPM_QuadSpeed)
+			return rate * 4;
+		else if (hdspm->control_register &
+				HDSPM_DoubleSpeed)
+			return rate * 2;
+	};
+	return rate;
+}
+
 static int hdspm_tco_sync_check(struct hdspm *hdspm);
 static int hdspm_sync_in_sync_check(struct hdspm *hdspm);
 
@@ -1268,21 +1288,8 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 			}
 		}
 
-		/* QS and DS rates normally can not be detected
-		 * automatically by the card. Only exception is MADI
-		 * in 96k frame mode.
-		 *
-		 * So if we read SS values (32 .. 48k), check for
-		 * user-provided DS/QS bits in the control register
-		 * and multiply the base frequency accordingly.
-		 */
-		if (rate <= 48000) {
-			if (hdspm->control_register & HDSPM_QuadSpeed)
-				rate *= 4;
-			else if (hdspm->control_register &
-					HDSPM_DoubleSpeed)
-				rate *= 2;
-		}
+		rate = hdspm_rate_multiplier(hdspm, rate);
+
 		break;
 	}
 
-- 
1.7.10.4
