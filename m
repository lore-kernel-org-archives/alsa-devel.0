From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 6/8] ALSA: hdspm - fix sync check on AES32
Date: Wed, 23 Feb 2011 11:43:13 +0100
Message-ID: <1298457795-28114-7-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Fredrik Lingvall <fredrik.lingvall@gmail.com> has discovered wrong
frequency and sync detection on AES32. According to him, the provided
patch fixes these issues.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index ea49ffe..0b0293f 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1082,7 +1082,7 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 	case AES32:
 		status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
 		status = hdspm_read(hdspm, HDSPM_statusRegister);
-		timecode =	hdspm_read(hdspm, HDSPM_timecodeRegister);
+		timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
 
 		syncref = hdspm_autosync_ref(hdspm);
 
@@ -2115,6 +2115,29 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 				hdspm_get_s1_sample_rate(hdspm,
 						ucontrol->id.index-1);
 		}
+
+	case AES32:
+
+		switch (kcontrol->private_value) {
+		case 0: /* WC */
+			ucontrol->value.enumerated.item[0] =
+				hdspm_get_wc_sample_rate(hdspm);
+			break;
+		case 9: /* TCO */
+			ucontrol->value.enumerated.item[0] =
+				hdspm_get_tco_sample_rate(hdspm);
+			break;
+		case 10: /* SYNC_IN */
+			ucontrol->value.enumerated.item[0] =
+				hdspm_get_sync_in_sample_rate(hdspm);
+			break;
+		default: /* AES1 to AES8 */
+			ucontrol->value.enumerated.item[0] =
+				hdspm_get_s1_sample_rate(hdspm,
+						kcontrol->private_value-1);
+			break;
+
+		}
 	default:
 		break;
 	}
@@ -3803,9 +3826,9 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 			val = hdspm_tco_sync_check(hdspm); break;
 		case 10 /* SYNC IN */:
 			val = hdspm_sync_in_sync_check(hdspm); break;
-		default:
+		default: /* AES1 to AES8 */
 			 val = hdspm_aes_sync_check(hdspm,
-					 ucontrol->id.index-1);
+					 kcontrol->private_value-1);
 		}
 
 	}
-- 
1.7.2.3
