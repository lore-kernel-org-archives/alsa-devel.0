From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 14/31] ALSA: hdspm - Cosmetics, no real change
Date: Fri,  5 Jul 2013 11:28:06 +0200
Message-ID: <1373016503-9474-15-git-send-email-adi@drcomp.erfurt.thur.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
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

This patch does nothing, it's sole intent is to clean up the code.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index bdd8c77..d95100e 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2926,7 +2926,7 @@ static int hdspm_autosync_ref(struct hdspm *hdspm)
 		case HDSPM_SelSyncRef_NVALID:
 			return HDSPM_AUTOSYNC_FROM_NONE;
 		default:
-			return 0;
+			return HDSPM_AUTOSYNC_FROM_NONE;
 		}
 
 	}
@@ -5260,7 +5260,7 @@ static int snd_hdspm_set_defaults(struct hdspm * hdspm)
 
 	case AES32:
 		hdspm->control_register =
-			HDSPM_ClockModeMaster |	/* Master Cloack Mode on */
+			HDSPM_ClockModeMaster |	/* Master Clock Mode on */
 			hdspm_encode_latency(7) | /* latency max=8192samples */
 			HDSPM_SyncRef0 |	/* AES1 is syncclock */
 			HDSPM_LineOut |	/* Analog output in */
@@ -6737,7 +6737,7 @@ static int snd_hdspm_create(struct snd_card *card,
 			if (NULL != hdspm->tco) {
 				hdspm_tco_write(hdspm);
 			}
-			snd_printk(KERN_INFO "HDSPM: MADI TCO module found\n");
+			snd_printk(KERN_INFO "HDSPM: MADI/AES TCO module found\n");
 		} else {
 			hdspm->tco = NULL;
 		}
@@ -6752,10 +6752,12 @@ static int snd_hdspm_create(struct snd_card *card,
 	case AES32:
 		if (hdspm->tco) {
 			hdspm->texts_autosync = texts_autosync_aes_tco;
-			hdspm->texts_autosync_items = 10;
+			hdspm->texts_autosync_items =
+				ARRAY_SIZE(texts_autosync_aes_tco);
 		} else {
 			hdspm->texts_autosync = texts_autosync_aes;
-			hdspm->texts_autosync_items = 9;
+			hdspm->texts_autosync_items =
+				ARRAY_SIZE(texts_autosync_aes);
 		}
 		break;
 
-- 
1.8.3.1
