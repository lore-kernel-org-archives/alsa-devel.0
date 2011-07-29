From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] ALSA: hdspm - Fix reported external sample
	rate on RME MADI and MADIface
Date: Fri, 29 Jul 2011 03:11:03 +0200
Message-ID: <1311901864-29021-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

In slave mode, the card can only detect the base frequency (32..48kHz)
on the MADI link (exception: 96k frames), so the real external sample
rate is this base frequency multiplied by 1, 2 or 4 depending on the
speed mode.

This patch enables 64..192kHz sample rates in clock slave mode, which
failed before due to an alleged sample rate mismatch between the MADI
link (e.g., 48kHz) and the application in DS/QS mode (e.g., 96kHz,
192kHz).

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index d219649..88ae274 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1217,6 +1217,22 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 				rate = 0;
 				break;
 			}
+
+			/* QS and DS rates normally can not be detected
+			 * automatically by the card. Only exception is MADI
+			 * in 96k frame mode.
+			 *
+			 * So if we read SS values (32 .. 48k), check for
+			 * user-provided DS/QS bits in the control register
+			 * and multiply the base frequency accordingly.
+			 */
+			if (rate <= 48000) {
+				if (hdspm->control_register & HDSPM_QuadSpeed)
+					rate *= 4;
+				else if (hdspm->control_register &
+						HDSPM_DoubleSpeed)
+					rate *= 2;
+			}
 		}
 		break;
 	}
-- 
1.7.5.4
