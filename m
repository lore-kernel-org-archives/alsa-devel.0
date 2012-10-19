From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 4/9] ALSA: hdspm - Fix reported
	autosync_sample_rate
Date: Fri, 19 Oct 2012 17:42:25 +0200
Message-ID: <1350661350-5000-5-git-send-email-adi@drcomp.erfurt.thur.de>
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

Missing breaks lead to a fall-through, thus causing the wrong
autosync_sample_rate to be reported.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 81d83fa..976e3a6 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2180,6 +2180,7 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 				hdspm_get_s1_sample_rate(hdspm,
 						kcontrol->private_value-1);
 		}
+		break;
 
 	case AIO:
 		switch (kcontrol->private_value) {
@@ -2200,6 +2201,7 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 				hdspm_get_s1_sample_rate(hdspm,
 						ucontrol->id.index-1);
 		}
+		break;
 
 	case AES32:
 
@@ -2221,8 +2223,8 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 				hdspm_get_s1_sample_rate(hdspm,
 						kcontrol->private_value-1);
 			break;
-
 		}
+		break;
 	default:
 		break;
 	}
-- 
1.7.10.4
