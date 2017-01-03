From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/2] ucm: Load device-specific configuration
	file based on the card long name
Date: Tue,  3 Jan 2017 13:13:04 +0800
Message-ID: <d19bee968562e9a392f24610424ee8f299bba032.1483286749.git.mengdong.lin@linux.intel.com>
References: <cover.1483286749.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D562266D2C
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 06:10:05 +0100 (CET)
In-Reply-To: <cover.1483286749.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Intel DSP platform drivers are used by many different devices. For user
space to differentiate them, ASoC machine drivers may use the DMI info
(vendor.product.board) as card long name. Possible card long names
are:
DellInc..XPS139343.0310JH
IntelCorp..BroadwellClientplatform.WilsonBeachSDS
ASUSTeKCOMPUTERINC..T100TA.T100TA
Circuitco.MinnowboardMaxD0PLATFORM.MinnowBoardMAX
...

And user space can define configuration files like longname\longname.conf
for a specific device.

When being asked to load configuration file of a card, UCM will try to
find the card in the local machine and get its long name. If the card
long name is available, try to load the file longname\longname.conf to
get the best device-specific configuration; if this file is not available,
fall back to load the default configuration file name\name.conf as
before.

This update is backward compatible, because if ASoC machine drivers don't
explicity use DMI or other means to set the card long name, ASoC core
will use the card name as the long name. So UCM will load the config
file that matches both the card name and the long name.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index c98373a..8e708ec 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -55,6 +55,9 @@ static const char * const component_dir[] = {
 	NULL,		/* terminator */
 };
 
+static int filename_filter(const struct dirent *dirent);
+static int is_component_directory(const char *dir);
+
 static int parse_sequence(snd_use_case_mgr_t *uc_mgr,
 			  struct list_head *base,
 			  snd_config_t *cfg);
@@ -1328,6 +1331,66 @@ static int parse_master_file(snd_use_case_mgr_t *uc_mgr, snd_config_t *cfg)
 	return 0;
 }
 
+/* find the card in the local machine and store the card long name */
+static int get_card_long_name(snd_use_case_mgr_t *mgr)
+{
+	const char *card_name = mgr->card_name;
+	snd_ctl_t *handle;
+	int card, err;
+	snd_ctl_card_info_t *info;
+	const char *_name, *_long_name;
+
+	snd_ctl_card_info_alloca(&info);
+
+	card = -1;
+	if (snd_card_next(&card) < 0 || card < 0) {
+		uc_error("no soundcards found...");
+		return -1;
+	}
+
+	while (card >= 0) {
+		char name[32];
+
+		sprintf(name, "hw:%d", card);
+		err = snd_ctl_open(&handle, name, 0);
+		if (err < 0) {
+			uc_error("control open (%i): %s", card,
+				 snd_strerror(err));
+			goto next_card;
+		}
+
+		err = snd_ctl_card_info(handle, info);
+		if (err < 0) {
+			uc_error("control hardware info (%i): %s", card,
+				 snd_strerror(err));
+			snd_ctl_close(handle);
+			goto next_card;
+		}
+
+		/* Find the local card by comparing the given name with the
+		 * card name and long name. User may open a card by its long
+		 * name, so the given card name may be a long name.
+		 */
+		_name = snd_ctl_card_info_get_name(info);
+		_long_name = snd_ctl_card_info_get_longname(info);
+		if (!strncmp(card_name, _name, MAX_CARD_LONG_NAME)
+		    || !strncmp(card_name, _long_name, MAX_CARD_LONG_NAME)) {
+			strncpy(mgr->card_long_name, _long_name,
+				MAX_CARD_LONG_NAME);
+			snd_ctl_close(handle);
+			return 0;
+		}
+
+		snd_ctl_close(handle);
+next_card:
+		if (snd_card_next(&card) < 0) {
+			uc_error("snd_card_next");
+			break;
+		}
+	}
+
+	return -1;
+}
 static int load_master_config(const char *card_name, snd_config_t **cfg)
 {
 	char filename[MAX_FILE];
@@ -1349,15 +1412,45 @@ static int load_master_config(const char *card_name, snd_config_t **cfg)
 	return 0;
 }
 
-/* load master use case file for sound card */
+/* load master use case file for sound card
+ *
+ * The same ASoC machine driver can be shared by many different devices.
+ * For user space to differentiate them and get the best device-specific
+ * configuration, ASoC machine drivers may use the DMI info
+ * (vendor.product.board) as the card long name. And user space can define
+ * configuration files like longname\longname.conf for a specific device.
+ *
+ * This function will try to find the card in the local machine and get its
+ * long name, then load the file longname\longname.conf to get the best
+ * device-specific configuration. If the card is not found in the local
+ * machine or the device-specific file is not available, fall back to load
+ * the default configuration file name\name.conf.
+ */
 int uc_mgr_import_master_config(snd_use_case_mgr_t *uc_mgr)
 {
 	snd_config_t *cfg;
 	int err;
 
-	err = load_master_config(uc_mgr->card_name, &cfg);
-	if (err < 0)
-		return err;
+	err = get_card_long_name(uc_mgr);
+	if (err == 0)	/* load file that maches the card long name */
+		err = load_master_config(uc_mgr->card_long_name, &cfg);
+
+	if (err == 0) {
+		/* got device-specific file that matches the card long name */
+		strncpy(uc_mgr->conf_file_name, uc_mgr->card_long_name,
+			MAX_CARD_LONG_NAME - 1);
+	} else {
+		/* Fall back to the file that maches the given card name,
+		 * either short name or long name (users may open a card by
+		 * its name or long name).
+		 */
+		err = load_master_config(uc_mgr->card_name, &cfg);
+		if (err < 0)
+			return err;
+		strncpy(uc_mgr->conf_file_name, uc_mgr->card_name,
+			MAX_CARD_LONG_NAME - 1);
+	}
+
 	err = parse_master_file(uc_mgr, cfg);
 	snd_config_delete(cfg);
 	if (err < 0)
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 6d3302f..299a5b9 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -41,6 +41,7 @@
 #include "use-case.h"
 
 #define MAX_FILE		256
+#define MAX_CARD_LONG_NAME	80
 #define ALSA_USE_CASE_DIR	ALSA_CONFIG_DIR "/ucm"
 
 #define SEQUENCE_ELEMENT_TYPE_CDEV	1
@@ -190,6 +191,8 @@ struct use_case_verb {
  */
 struct snd_use_case_mgr {
 	char *card_name;
+	char card_long_name[MAX_CARD_LONG_NAME];
+	char conf_file_name[MAX_CARD_LONG_NAME];
 	char *comment;
 
 	/* use case verb, devices and modifier configs parsed from files */
-- 
2.7.4
