From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 2/5] ALSA: hdspm: Remove unused code
Date: Tue,  1 Jul 2014 17:02:55 +0530
Message-ID: <1404214378-24669-2-git-send-email-sachin.kamat@samsung.com>
References: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 842B3261A83
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 13:36:34 +0200 (CEST)
Received: by mail-pd0-f181.google.com with SMTP id v10so9973464pde.12
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 04:36:33 -0700 (PDT)
In-Reply-To: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, spk.linux@gmail.com
List-Id: alsa-devel@alsa-project.org

Removed the code which is not used in the functions.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/pci/rme9652/hdspm.c |   23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index cb82b593473a..60ee41fda5d1 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1257,14 +1257,13 @@ static int hdspm_rate_multiplier(struct hdspm *hdspm, int rate)
 /* check for external sample rate, returns the sample rate in Hz*/
 static int hdspm_external_sample_rate(struct hdspm *hdspm)
 {
-	unsigned int status, status2, timecode;
+	unsigned int status, status2;
 	int syncref, rate = 0, rate_bits;
 
 	switch (hdspm->io_type) {
 	case AES32:
 		status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 		status = hdspm_read(hdspm, HDSPM_statusRegister);
-		timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
 
 		syncref = hdspm_autosync_ref(hdspm);
 		switch (syncref) {
@@ -4873,18 +4872,15 @@ snd_hdspm_proc_read_madi(struct snd_info_entry *entry,
 			 struct snd_info_buffer *buffer)
 {
 	struct hdspm *hdspm = entry->private_data;
-	unsigned int status, status2, control, freq;
+	unsigned int status, status2;
 
 	char *pref_sync_ref;
 	char *autosync_ref;
 	char *system_clock_mode;
-	char *insel;
 	int x, x2;
 
 	status = hdspm_read(hdspm, HDSPM_statusRegister);
 	status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
-	control = hdspm->control_register;
-	freq = hdspm_read(hdspm, HDSPM_timecodeRegister);
 
 	snd_iprintf(buffer, "%s (Card #%d) Rev.%x Status2first3bits: %x\n",
 			hdspm->card_name, hdspm->card->number + 1,
@@ -4947,17 +4943,6 @@ snd_hdspm_proc_read_madi(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "Line out: %s\n",
 		(hdspm->control_register & HDSPM_LineOut) ? "on " : "off");
 
-	switch (hdspm->control_register & HDSPM_InputMask) {
-	case HDSPM_InputOptical:
-		insel = "Optical";
-		break;
-	case HDSPM_InputCoaxial:
-		insel = "Coaxial";
-		break;
-	default:
-		insel = "Unknown";
-	}
-
 	snd_iprintf(buffer,
 		"ClearTrackMarker = %s, Transmit in %s Channel Mode, "
 		"Auto Input %s\n",
@@ -5202,15 +5187,13 @@ snd_hdspm_proc_read_raydat(struct snd_info_entry *entry,
 			 struct snd_info_buffer *buffer)
 {
 	struct hdspm *hdspm = entry->private_data;
-	unsigned int status1, status2, status3, control, i;
+	unsigned int status1, status2, status3, i;
 	unsigned int lock, sync;
 
 	status1 = hdspm_read(hdspm, HDSPM_RD_STATUS_1); /* s1 */
 	status2 = hdspm_read(hdspm, HDSPM_RD_STATUS_2); /* freq */
 	status3 = hdspm_read(hdspm, HDSPM_RD_STATUS_3); /* s2 */
 
-	control = hdspm->control_register;
-
 	snd_iprintf(buffer, "STATUS1: 0x%08x\n", status1);
 	snd_iprintf(buffer, "STATUS2: 0x%08x\n", status2);
 	snd_iprintf(buffer, "STATUS3: 0x%08x\n", status3);
-- 
1.7.9.5
