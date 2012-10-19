From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/9] ALSA: hdspm - Also report
	autosync_sample_rate on MADI and MADIface
Date: Fri, 19 Oct 2012 17:42:26 +0200
Message-ID: <1350661350-5000-6-git-send-email-adi@drcomp.erfurt.thur.de>
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

MADI and MADIface used to report the autosync_sample_rate. This
functionality was lost in commit
0dca1793063c28dde8f6c49c9c72203fe5cb6efc, this commit now adds it back.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 976e3a6..1a679e9 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2225,6 +2225,19 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 			break;
 		}
 		break;
+
+	case MADI:
+	case MADIface:
+		{
+			int rate = hdspm_external_sample_rate(hdspm);
+			int i, selected_rate = 0;
+			for (i = 1; i < 10; i++)
+				if (HDSPM_bit2freq(i) == rate)
+					selected_rate = i;
+			ucontrol->value.enumerated.item[0] = selected_rate;
+		}
+		break;
+
 	default:
 		break;
 	}
@@ -4450,6 +4463,7 @@ static struct snd_kcontrol_new snd_hdspm_controls_madi[] = {
 	HDSPM_PREF_SYNC_REF("Preferred Sync Reference", 0),
 	HDSPM_AUTOSYNC_REF("AutoSync Reference", 0),
 	HDSPM_SYSTEM_SAMPLE_RATE("System Sample Rate", 0),
+	HDSPM_AUTOSYNC_SAMPLE_RATE("External Rate", 0),
 	HDSPM_SYNC_CHECK("WC SyncCheck", 0),
 	HDSPM_SYNC_CHECK("MADI SyncCheck", 1),
 	HDSPM_SYNC_CHECK("TCO SyncCHeck", 2),
-- 
1.7.10.4
