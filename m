From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdspm - Fix wordclock status on AES32
Date: Wed,  9 Jan 2013 14:40:18 +0100
Message-ID: <1357738818-29526-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1355495521-1445-1-git-send-email-andre.schramm@iosono-sound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1355495521-1445-1-git-send-email-andre.schramm@iosono-sound.com>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Andre Schramm <andre.schramm@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

From: Andre Schramm <andre.schramm@iosono-sound.com>

Use correct bitmask for AES32 cards to determine wordclock lock state,
add missing bitmask for sync check and make output of the corresponding
control and /proc coherent.

Signed-off-by: Andre Schramm <andre.schramm@iosono-sound.com>
Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 6e02e06..36e247f 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -441,6 +441,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 */
 /* status */
 #define HDSPM_AES32_wcLock	0x0200000
+#define HDSPM_AES32_wcSync	0x0100000
 #define HDSPM_AES32_wcFreq_bit  22
 /* (status >> HDSPM_AES32_wcFreq_bit) & 0xF gives WC frequency (cf function
   HDSPM_bit2freq */
@@ -3467,10 +3468,12 @@ static int hdspm_wc_sync_check(struct hdspm *hdspm)
 	switch (hdspm->io_type) {
 	case AES32:
 		status = hdspm_read(hdspm, HDSPM_statusRegister);
-		if (status & HDSPM_wcSync)
-			return 2;
-		else if (status & HDSPM_wcLock)
-			return 1;
+		if (status & HDSPM_AES32_wcLock) {
+			if (status & HDSPM_AES32_wcSync)
+				return 2;
+			else
+				return 1;
+		}
 		return 0;
 		break;
 
@@ -4658,6 +4661,7 @@ snd_hdspm_proc_read_aes32(struct snd_info_entry * entry,
 	unsigned int status;
 	unsigned int status2;
 	unsigned int timecode;
+	unsigned int wcLock, wcSync;
 	int pref_syncref;
 	char *autosync_ref;
 	int x;
@@ -4751,8 +4755,11 @@ snd_hdspm_proc_read_aes32(struct snd_info_entry * entry,
 
 	snd_iprintf(buffer, "--- Status:\n");
 
+	wcLock = status & HDSPM_AES32_wcLock;
+	wcSync = wcLock && (status & HDSPM_AES32_wcSync);
+
 	snd_iprintf(buffer, "Word: %s  Frequency: %d\n",
-		    (status & HDSPM_AES32_wcLock) ? "Sync   " : "No Lock",
+		    (wcLock) ? (wcSync ? "Sync   " : "Lock") : "No Lock",
 		    HDSPM_bit2freq((status >> HDSPM_AES32_wcFreq_bit) & 0xF));
 
 	for (x = 0; x < 8; x++) {
-- 
1.7.10.4
