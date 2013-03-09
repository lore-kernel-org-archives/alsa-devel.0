From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/7] ALSA: hdspm - Also check for TCO sync
	states
Date: Sun, 10 Mar 2013 00:37:25 +0100
Message-ID: <1362872247-29029-6-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1362872247-29029-5-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362872247-29029-5-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch prepares snd_hdspm_get_sync_check() to also check the TCO
sync state. The added feature will be exposed to the user in a later
commit.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 9c79803e..9b5382f 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3444,6 +3444,16 @@ static int snd_hdspm_put_playback_mixer(struct snd_kcontrol *kcontrol,
 	.get = snd_hdspm_get_sync_check \
 }
 
+#define HDSPM_TCO_LOCK_CHECK(xname, xindex) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.private_value = xindex, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
+	.info = snd_hdspm_tco_info_lock_check, \
+	.get = snd_hdspm_get_sync_check \
+}
+
+
 
 static int snd_hdspm_info_sync_check(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo)
@@ -3453,6 +3463,14 @@ static int snd_hdspm_info_sync_check(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int snd_hdspm_tco_info_lock_check(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[] = { "No Lock", "Lock" };
+	ENUMERATED_CTL_INFO(uinfo, texts);
+	return 0;
+}
+
 static int hdspm_wc_sync_check(struct hdspm *hdspm)
 {
 	int status, status2;
@@ -3582,6 +3600,14 @@ static int hdspm_aes_sync_check(struct hdspm *hdspm, int idx)
 	return 0;
 }
 
+static int hdspm_tco_input_check(struct hdspm *hdspm, u32 mask)
+{
+	u32 status;
+	status = hdspm_read(hdspm, HDSPM_RD_TCO + 4);
+
+	return (status & mask) ? 1 : 0;
+}
+
 
 static int hdspm_tco_sync_check(struct hdspm *hdspm)
 {
@@ -3689,6 +3715,22 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 
 	}
 
+	if (hdspm->tco) {
+		switch (kcontrol->private_value) {
+		case 11:
+			/* Check TCO for lock state of its current input */
+			val = hdspm_tco_input_check(hdspm, HDSPM_TCO1_TCO_lock);
+			break;
+		case 12:
+			/* Check TCO for valid time code on LTC input. */
+			val = hdspm_tco_input_check(hdspm,
+				HDSPM_TCO1_LTC_Input_valid);
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (-1 == val)
 		val = 3;
 
-- 
1.7.10.4
