From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 16/31] ALSA: hdspm - AES32: Add TCO and
	Sync-In text entries
Date: Fri,  5 Jul 2013 11:28:08 +0200
Message-ID: <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-16-git-send-email-adi@drcomp.erfurt.thur.de>
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

Provide the text for the two new clock options "TCO" and "Sync In" on
AES32 cards.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index d1e0582..8e6ce14 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -561,10 +561,13 @@ static char *hdspm_speed_names[] = { "single", "double", "quad" };
 static char *texts_autosync_aes_tco[] = { "Word Clock",
 					  "AES1", "AES2", "AES3", "AES4",
 					  "AES5", "AES6", "AES7", "AES8",
-					  "TCO" };
+					  "TCO", "Sync In"
+};
 static char *texts_autosync_aes[] = { "Word Clock",
 				      "AES1", "AES2", "AES3", "AES4",
-				      "AES5", "AES6", "AES7", "AES8" };
+				      "AES5", "AES6", "AES7", "AES8",
+				      "Sync In"
+};
 static char *texts_autosync_madi_tco[] = { "Word Clock",
 					   "MADI", "TCO", "Sync In" };
 static char *texts_autosync_madi[] = { "Word Clock",
@@ -2941,11 +2944,11 @@ static int snd_hdspm_info_autosync_ref(struct snd_kcontrol *kcontrol,
 
 	if (AES32 == hdspm->io_type) {
 		static char *texts[] = { "WordClock", "AES1", "AES2", "AES3",
-			"AES4",	"AES5", "AES6", "AES7", "AES8", "None"};
+			"AES4",	"AES5", "AES6", "AES7", "AES8", "TCO", "Sync In", "None"};
 
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 		uinfo->count = 1;
-		uinfo->value.enumerated.items = 10;
+		uinfo->value.enumerated.items = ARRAY_SIZE(texts);
 		if (uinfo->value.enumerated.item >=
 		    uinfo->value.enumerated.items)
 			uinfo->value.enumerated.item =
-- 
1.8.3.1
