From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/2] ucm: Automatically load the best config
	file based on the card long name
Date: Wed, 21 Dec 2016 21:09:28 +0800
Message-ID: <1482325768-20084-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B3E826058A
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 14:06:49 +0100 (CET)
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
space to differentiate them, ASoC machine driver may include the DMI info
(vendor, product and board) in card long name. Possible card long names
are:
broadwell-rt286-Dell Inc.-XPS 13 9343-0310JH
broadwell-rt286-Intel Corp.-Broadwell Client platform-Wilson Beach SDS
bytcr-rt5640-ASUSTeK COMPUTER INC.-T100TA-T100TA
bytcr-rt5651-Circuitco-Minnowboard Max D0 PLATFORM-MinnowBoard MAX
...

And user space can define configuration files including fields separated
by '.' as below:
broadwell-rt286
broadwell-rt286.Dell.XPS
bytcr-rt5640
bytcr-rt5640.ASUS.T100
bytcr-rt5651.MinnowboardMax
...

When being asked to load configuration file of a card, UCM will try to
find the card long name from the local machine, and then scan all
available configuration file names, search every field of config file
name in the card long name. The more characters match, the higher score
the file has. Finally, the file with the highest score will be loaded to
configure the sound card.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index c98373a..ff75da7 100644
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
@@ -1328,6 +1331,210 @@ static int parse_master_file(snd_use_case_mgr_t *uc_mgr, snd_config_t *cfg)
 	return 0;
 }
 
+/* trim SPACE (0x20) from the string */
+static void trim_space(char *str)
+{
+	int i, j = 0;
+
+	for (i = 0; str[i] && i < MAX_FILE; i++) {
+		if (str[i] != 0x20)
+			str[j++] = str[i];
+	}
+
+	str[j] = '\0';
+}
+
+/* find and store the card long name if the card is in this machine */
+static int get_card_long_name(snd_use_case_mgr_t *mgr)
+{
+	const char *card_name = mgr->card_name;
+	snd_ctl_t *handle;
+	int card, err, dev, idx;
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
+		_name = snd_ctl_card_info_get_name(info);
+		if (!strncmp(card_name, _name, 32)) {
+			_long_name = snd_ctl_card_info_get_longname(info);
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
+
+/* This function will find the best device-specific configuration file based
+ * on the sound card long name.
+ * Different devices may share the same sound driver and thus the same sound
+ * card name (short name), but they may still need different device-specific
+ * configurations. For user space to differentiate them, kernel drivers may
+ * include the DMI info (vendor, product and board) in the card long name.
+ * And user space can define configuration file names appending DMI keywords
+ * to the card name, like:
+ * bytcr-rt5640.ASUS.T100
+ * bytcr-rt5651.MinnowBoard
+ *
+ * When being asked to load the configuration file for a card, this function
+ * will try to find the card long name from the local machine, and then scan
+ * all available configuration file names, search every field of the config
+ * file name in the card long name. The more characters match, the higher
+ * score the file has. Finally, the file with the highest score will be loaded.
+ */
+static void find_best_config_file(snd_use_case_mgr_t *mgr)
+{
+	const char *card_name = mgr->card_name;
+	char name[MAX_FILE];
+	char *env = getenv(ALSA_CONFIG_UCM_VAR);
+	struct dirent **namelist;
+	char card_long_name[MAX_CARD_LONG_NAME];
+	char *lpos, *lpos_next, *lname_end;
+	char *d_name, *dpos, *dpos_next, *d_name_end;
+	int d_name_len, field_len, long_name_len;
+	int i, cnt, err;
+	int score, score_max = 0, d_index = -1;
+	int  is_first_field;
+
+	if (get_card_long_name(mgr) < 0) {
+		/* cannot get long name, use card name as the conf file name */
+		strcpy(mgr->conf_file_name, mgr->card_name);
+		return;
+	}
+
+	strncpy(card_long_name, mgr->card_long_name, MAX_CARD_LONG_NAME);
+	trim_space(card_long_name); /* trim SPACE for matching */
+	lname_end = card_long_name + strlen(card_long_name);
+
+	/* get list of card directories under /usr/share/alsa/ucm */
+	snprintf(name, sizeof(name)-1,
+		"%s", env ? env : ALSA_USE_CASE_DIR);
+	name[MAX_FILE-1] = '\0';
+
+	err = scandir(name, &namelist, filename_filter, alphasort);
+	if (err < 0) {
+		err = -errno;
+		uc_error("error: could not scan directory %s: %s",
+				name, strerror(-err));
+		return;
+	}
+	cnt = err;
+
+	/* scan the card directory names */
+	for (i = 0; i < cnt; i++) {
+
+		/* Skip the directories for component devices */
+		if (is_component_directory(namelist[i]->d_name))
+			continue;
+
+		score = 0;
+		lpos = card_long_name;
+
+		d_name = namelist[i]->d_name;
+		d_name_len = strlen(d_name);
+		d_name_end = d_name + d_name_len;
+		is_first_field = 1;
+		dpos = d_name;
+
+		/* scan fields in the card directory name, separated by '.' */
+		while (1) {
+			dpos_next = strchr(dpos, '.');
+			if (dpos_next == dpos)	/* start with '.' */
+				goto next_field;
+
+			if (!dpos_next) /* last field */
+				field_len = d_name_end - dpos;
+			else
+				field_len = dpos_next - dpos;
+
+			memcpy(name, dpos, field_len);
+			name[field_len] = '\0';
+
+			/* search the field in the given card long name */
+			lpos_next = strstr(lpos, name);
+			if (!lpos_next) {
+				/* first field is the card name, must match */
+				if (is_first_field)
+					break;
+				goto next_field;
+			} else {
+				/* The more characters match,
+				 * the higher the score is.
+				 */
+				score += field_len;
+				if (lpos_next + field_len >= lname_end)
+					break; /* reach end of long name */
+
+				/* Skip the matched field,
+				 * for searching next field.
+				 */
+				lpos = lpos_next + field_len;
+			}
+
+next_field:
+			if (!dpos_next)
+				break; /* no more fields */
+
+			dpos = dpos_next + 1; /* skip the separator '.' */
+			is_first_field = 0;
+			if (dpos >= d_name_end)
+				break;
+		}
+
+		if (score > score_max) {
+			score_max = score;
+			d_index = i;
+		} else if (score == 0 && score_max > 0) {
+			/* passed the card directories that can match,
+			 * since directories are in alphabetical order.
+			 */
+			break;
+		}
+	}
+
+	if (d_index >= 0)
+		strncpy(mgr->conf_file_name, namelist[d_index]->d_name,
+			MAX_CARD_LONG_NAME);
+	else
+		strncpy(mgr->conf_file_name, mgr->card_name,
+			MAX_CARD_LONG_NAME);
+}
+
 static int load_master_config(const char *card_name, snd_config_t **cfg)
 {
 	char filename[MAX_FILE];
@@ -1355,7 +1562,9 @@ int uc_mgr_import_master_config(snd_use_case_mgr_t *uc_mgr)
 	snd_config_t *cfg;
 	int err;
 
-	err = load_master_config(uc_mgr->card_name, &cfg);
+	find_best_config_file(uc_mgr);
+
+	err = load_master_config(uc_mgr->conf_file_name, &cfg);
 	if (err < 0)
 		return err;
 	err = parse_master_file(uc_mgr, cfg);
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
