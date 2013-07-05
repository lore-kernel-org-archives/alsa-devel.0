From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 25/31] ALSA: hdspm - Introduce
	hdspm_external_rate_to_enum() helper function
Date: Fri,  5 Jul 2013 11:28:17 +0200
Message-ID: <1373016503-9474-26-git-send-email-adi@drcomp.erfurt.thur.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-25-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch refactors the code to query the external sample rate and its
translation into the corresponding enum into a helper function to
prevent future code duplication.

A later commit will make use of this new helper function.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index f6e922c..26f10fd 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2303,6 +2303,21 @@ static void snd_hdspm_set_infotext(struct snd_ctl_elem_info *uinfo,
 	snd_hdspm_set_infotext(info, texts, ARRAY_SIZE(texts))
 
 
+/* Helper function to query the external sample rate and return the
+ * corresponding enum to be returned to userspace.
+ */
+static int hdspm_external_rate_to_enum(struct hdspm *hdspm)
+{
+	int rate = hdspm_external_sample_rate(hdspm);
+	int i, selected_rate = 0;
+	for (i = 1; i < 10; i++)
+		if (HDSPM_bit2freq(i) == rate) {
+			selected_rate = i;
+			break;
+		}
+	return selected_rate;
+}
+
 
 #define HDSPM_AUTOSYNC_SAMPLE_RATE(xname, xindex) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
@@ -2396,18 +2411,9 @@ static int snd_hdspm_get_autosync_sample_rate(struct snd_kcontrol *kcontrol,
 
 	case MADI:
 	case MADIface:
-		{
-			int rate = hdspm_external_sample_rate(hdspm);
-			int i, selected_rate = 0;
-			for (i = 1; i < 10; i++)
-				if (HDSPM_bit2freq(i) == rate) {
-					selected_rate = i;
-					break;
-				}
-			ucontrol->value.enumerated.item[0] = selected_rate;
-		}
+		ucontrol->value.enumerated.item[0] =
+			hdspm_external_rate_to_enum(hdspm);
 		break;
-
 	default:
 		break;
 	}
-- 
1.8.3.1
