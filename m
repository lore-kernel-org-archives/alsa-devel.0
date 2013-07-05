From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 11/31] ALSA: hdspm - Fix S/PDIF Sync status
	and frequency on RME AIO
Date: Fri,  5 Jul 2013 11:28:03 +0200
Message-ID: <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
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

This is a left-over mistake from old code, the correct register offset is
provided in kcontrol->private_value, not in the index.
Cf. RayDAT case, where it has already been corrected.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index ad41636..06e69de 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2312,7 +2312,7 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 		default:
 			ucontrol->value.enumerated.item[0] =
 				hdspm_get_s1_sample_rate(hdspm,
-						ucontrol->id.index-1);
+						kcontrol->private_value-1);
 		}
 		break;
 
@@ -3930,7 +3930,8 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 		case 5: /* SYNC IN */
 			val = hdspm_sync_in_sync_check(hdspm); break;
 		default:
-			val = hdspm_s1_sync_check(hdspm, ucontrol->id.index-1);
+			val = hdspm_s1_sync_check(hdspm,
+					kcontrol->private_value-1);
 		}
 		break;
 
-- 
1.8.3.1
