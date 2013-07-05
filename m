From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 29/31] ALSA: hdspm - Use snd_ctl_enum_info()
	for texts_autosync
Date: Fri,  5 Jul 2013 11:28:21 +0200
Message-ID: <1373016503-9474-30-git-send-email-adi@drcomp.erfurt.thur.de>
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
 <1373016503-9474-27-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-28-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-29-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-29-git-send-email-adi@drcomp.erfurt.thur.de>
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

Also use snd_ctl_enum_info() to fill the autosync enumerated controls.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 5a2eb64..ffd5d7c 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -558,36 +558,36 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 /* names for speed modes */
 static char *hdspm_speed_names[] = { "single", "double", "quad" };
 
-static char *texts_autosync_aes_tco[] = { "Word Clock",
+static const char *const texts_autosync_aes_tco[] = { "Word Clock",
 					  "AES1", "AES2", "AES3", "AES4",
 					  "AES5", "AES6", "AES7", "AES8",
 					  "TCO", "Sync In"
 };
-static char *texts_autosync_aes[] = { "Word Clock",
+static const char *const texts_autosync_aes[] = { "Word Clock",
 				      "AES1", "AES2", "AES3", "AES4",
 				      "AES5", "AES6", "AES7", "AES8",
 				      "Sync In"
 };
-static char *texts_autosync_madi_tco[] = { "Word Clock",
+static const char *const texts_autosync_madi_tco[] = { "Word Clock",
 					   "MADI", "TCO", "Sync In" };
-static char *texts_autosync_madi[] = { "Word Clock",
+static const char *const texts_autosync_madi[] = { "Word Clock",
 				       "MADI", "Sync In" };
 
-static char *texts_autosync_raydat_tco[] = {
+static const char *const texts_autosync_raydat_tco[] = {
 	"Word Clock",
 	"ADAT 1", "ADAT 2", "ADAT 3", "ADAT 4",
 	"AES", "SPDIF", "TCO", "Sync In"
 };
-static char *texts_autosync_raydat[] = {
+static const char *const texts_autosync_raydat[] = {
 	"Word Clock",
 	"ADAT 1", "ADAT 2", "ADAT 3", "ADAT 4",
 	"AES", "SPDIF", "Sync In"
 };
-static char *texts_autosync_aio_tco[] = {
+static const char *const texts_autosync_aio_tco[] = {
 	"Word Clock",
 	"ADAT", "AES", "SPDIF", "TCO", "Sync In"
 };
-static char *texts_autosync_aio[] = { "Word Clock",
+static const char *const texts_autosync_aio[] = { "Word Clock",
 				      "ADAT", "AES", "SPDIF", "Sync In" };
 
 static const char *const texts_freq[] = {
@@ -975,7 +975,7 @@ struct hdspm {
 
 	struct hdspm_tco *tco;  /* NULL if no TCO detected */
 
-	char **texts_autosync;
+	const char *const *texts_autosync;
 	int texts_autosync_items;
 
 	cycles_t last_interrupt;
@@ -2888,16 +2888,7 @@ static int snd_hdspm_info_pref_sync_ref(struct snd_kcontrol *kcontrol,
 {
 	struct hdspm *hdspm = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = hdspm->texts_autosync_items;
-
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item =
-			uinfo->value.enumerated.items - 1;
-
-	strcpy(uinfo->value.enumerated.name,
-			hdspm->texts_autosync[uinfo->value.enumerated.item]);
+	snd_ctl_enum_info(uinfo, 1, hdspm->texts_autosync_items, hdspm->texts_autosync);
 
 	return 0;
 }
-- 
1.8.3.1
