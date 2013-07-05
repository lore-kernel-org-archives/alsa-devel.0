From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 23/31] ALSA: hdspm - AES32: Enable
	TCO/Sync-In in snd_hdspm_put_sync_ref()
Date: Fri,  5 Jul 2013 11:28:15 +0200
Message-ID: <1373016503-9474-24-git-send-email-adi@drcomp.erfurt.thur.de>
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
 <1373016503-9474-23-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-23-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch enables the user to select "TCO" and "Sync In" as a preferred
sync reference on RME AES(32) cards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 80b2247..73d9626 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2954,19 +2954,20 @@ static int snd_hdspm_put_pref_sync_ref(struct snd_kcontrol *kcontrol,
 
 static int hdspm_autosync_ref(struct hdspm *hdspm)
 {
+	/* This looks at the autosync selected sync reference */
 	if (AES32 == hdspm->io_type) {
+
 		unsigned int status = hdspm_read(hdspm, HDSPM_statusRegister);
-		unsigned int syncref =
-			(status >> HDSPM_AES32_syncref_bit) & 0xF;
-		if (syncref == 0)
-			return HDSPM_AES32_AUTOSYNC_FROM_WORD;
-		if (syncref <= 8)
+		unsigned int syncref = (status >> HDSPM_AES32_syncref_bit) & 0xF;
+		if ((syncref >= HDSPM_AES32_AUTOSYNC_FROM_WORD) &&
+				(syncref <= HDSPM_AES32_AUTOSYNC_FROM_SYNC_IN)) {
 			return syncref;
+		}
 		return HDSPM_AES32_AUTOSYNC_FROM_NONE;
+
 	} else if (MADI == hdspm->io_type) {
-		/* This looks at the autosync selected sync reference */
-		unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 
+		unsigned int status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 		switch (status2 & HDSPM_SelSyncRefMask) {
 		case HDSPM_SelSyncRef_WORD:
 			return HDSPM_AUTOSYNC_FROM_WORD;
-- 
1.8.3.1
