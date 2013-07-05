From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 13/31] ALSA: hdspm - AES32: Fix TCO sync
	check reporting
Date: Fri,  5 Jul 2013 11:28:05 +0200
Message-ID: <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
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

HDSPM_tco_lock and HDSPM_tcoLock were too close, so the previous code
didn't honour the difference between the two.

Let's be more verbose and use HDSPM_tcoLockMadi for MADI cards,
HDSPM_tcoLockAes for AES(32) and fix the code that makes use of both.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 58b2104..bdd8c77 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -360,11 +360,11 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_madiLock           (1<<3)	/* MADI Locked =1, no=0 */
 #define HDSPM_madiSync          (1<<18) /* MADI is in sync */
 
-#define HDSPM_tcoLock    0x00000020 /* Optional TCO locked status FOR HDSPe MADI! */
-#define HDSPM_tcoSync    0x10000000 /* Optional TCO sync status */
+#define HDSPM_tcoLockMadi    0x00000020 /* Optional TCO locked status for HDSPe MADI*/
+#define HDSPM_tcoSync    0x10000000 /* Optional TCO sync status for HDSPe MADI and AES32!*/
 
-#define HDSPM_syncInLock 0x00010000 /* Sync In lock status FOR HDSPe MADI! */
-#define HDSPM_syncInSync 0x00020000 /* Sync In sync status FOR HDSPe MADI! */
+#define HDSPM_syncInLock 0x00010000 /* Sync In lock status for HDSPe MADI! */
+#define HDSPM_syncInSync 0x00020000 /* Sync In sync status for HDSPe MADI! */
 
 #define HDSPM_BufferPositionMask 0x000FFC0 /* Bit 6..15 : h/w buffer pointer */
 			/* since 64byte accurate, last 6 bits are not used */
@@ -382,7 +382,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 					 * Interrupt
 					 */
 #define HDSPM_tco_detect         0x08000000
-#define HDSPM_tco_lock	         0x20000000
+#define HDSPM_tcoLockAes         0x20000000 /* Optional TCO locked status for HDSPe AES */
 
 #define HDSPM_s2_tco_detect      0x00000040
 #define HDSPM_s2_AEBO_D          0x00000080
@@ -480,7 +480,9 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_AES32_AUTOSYNC_FROM_AES6 6
 #define HDSPM_AES32_AUTOSYNC_FROM_AES7 7
 #define HDSPM_AES32_AUTOSYNC_FROM_AES8 8
-#define HDSPM_AES32_AUTOSYNC_FROM_NONE 9
+#define HDSPM_AES32_AUTOSYNC_FROM_TCO 9
+#define HDSPM_AES32_AUTOSYNC_FROM_SYNC_IN 10
+#define HDSPM_AES32_AUTOSYNC_FROM_NONE 11
 
 /*  status2 */
 /* HDSPM_LockAES_bit is given by HDSPM_LockAES >> (AES# - 1) */
@@ -3868,9 +3870,18 @@ static int hdspm_tco_sync_check(struct hdspm *hdspm)
 	if (hdspm->tco) {
 		switch (hdspm->io_type) {
 		case MADI:
+			status = hdspm_read(hdspm, HDSPM_statusRegister);
+			if (status & HDSPM_tcoLockMadi) {
+				if (status & HDSPM_tcoSync)
+					return 2;
+				else
+					return 1;
+			}
+			return 0;
+			break;
 		case AES32:
 			status = hdspm_read(hdspm, HDSPM_statusRegister);
-			if (status & HDSPM_tcoLock) {
+			if (status & HDSPM_tcoLockAes) {
 				if (status & HDSPM_tcoSync)
 					return 2;
 				else
-- 
1.8.3.1
