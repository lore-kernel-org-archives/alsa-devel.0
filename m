From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/9] ALSA: hdspm - Fix sync check reporting on
	all RME HDSPM cards
Date: Fri, 19 Oct 2012 17:42:24 +0200
Message-ID: <1350661350-5000-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, andre.schramm@iosono-sound.com
List-Id: alsa-devel@alsa-project.org

Due to missing breaks and the resulting fall-through, card subtype
selection was effectively missing, thus causing the wrong sync check
functions to be called.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 1131a8a..81d83fa 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -3959,6 +3959,7 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 		default:
 			val = hdspm_s1_sync_check(hdspm, ucontrol->id.index-1);
 		}
+		break;
 
 	case AIO:
 		switch (kcontrol->private_value) {
@@ -3971,6 +3972,7 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 		default:
 			val = hdspm_s1_sync_check(hdspm, ucontrol->id.index-1);
 		}
+		break;
 
 	case MADI:
 		switch (kcontrol->private_value) {
@@ -3983,6 +3985,7 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 		case 3: /* SYNC_IN */
 			val = hdspm_sync_in_sync_check(hdspm); break;
 		}
+		break;
 
 	case MADIface:
 		val = hdspm_madi_sync_check(hdspm); /* MADI */
@@ -4000,6 +4003,7 @@ static int snd_hdspm_get_sync_check(struct snd_kcontrol *kcontrol,
 			 val = hdspm_aes_sync_check(hdspm,
 					 kcontrol->private_value-1);
 		}
+		break;
 
 	}
 
-- 
1.7.10.4
