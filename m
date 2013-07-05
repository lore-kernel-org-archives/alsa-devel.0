From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 26/31] ALSA: hdspm - AES32: Report external
	sample rate to userspace
Date: Fri,  5 Jul 2013 11:28:18 +0200
Message-ID: <1373016503-9474-27-git-send-email-adi@drcomp.erfurt.thur.de>
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
 <1373016503-9474-24-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-25-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-26-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-26-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch adds a new ALSA control to read the external sample rate from
userspace on RME AES(32) cards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 26f10fd..2f58e07 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2401,10 +2401,15 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 			ucontrol->value.enumerated.item[0] =
 				hdspm_get_sync_in_sample_rate(hdspm);
 			break;
+		case 11: /* External Rate */
+			ucontrol->value.enumerated.item[0] =
+				hdspm_external_rate_to_enum(hdspm);
+			break;
 		default: /* AES1 to AES8 */
 			ucontrol->value.enumerated.item[0] =
-				hdspm_get_s1_sample_rate(hdspm,
-						kcontrol->private_value-1);
+				hdspm_get_aes_sample_rate(hdspm,
+						kcontrol->private_value -
+						HDSPM_AES32_AUTOSYNC_FROM_AES1);
 			break;
 		}
 		break;
@@ -4550,7 +4555,7 @@ static struct snd_kcontrol_new snd_hdspm_controls_aes32[] = {
 	HDSPM_PREF_SYNC_REF("Preferred Sync Reference", 0),
 	HDSPM_AUTOSYNC_REF("AutoSync Reference", 0),
 	HDSPM_SYSTEM_SAMPLE_RATE("System Sample Rate", 0),
-	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 0),
+	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 11),
 	HDSPM_SYNC_CHECK("WC Sync Check", 0),
 	HDSPM_SYNC_CHECK("AES1 Sync Check", 1),
 	HDSPM_SYNC_CHECK("AES2 Sync Check", 2),
-- 
1.8.3.1
