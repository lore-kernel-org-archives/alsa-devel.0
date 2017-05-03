From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] conf: Allow dynamic top-level config
	directory
Date: Wed,  3 May 2017 10:01:18 +0200
Message-ID: <20170503080118.11735-2-tiwai@suse.de>
References: <20170503080118.11735-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 320FA266860
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 10:01:25 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DBEC2AAB1
 for <alsa-devel@alsa-project.org>; Wed,  3 May 2017 08:01:24 +0000 (UTC)
In-Reply-To: <20170503080118.11735-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently the top-level config directory is specified only via
configure script option, and is fixed after that.  It's inconvenient
when the library is moved to another base directory, or if you want to
use a library code (e.g. with $LD_PRELOAD) with the incompatible
config setups.

This patch allows user to override the top-level config path via the
environment varialbe, $ALSA_CONFIG_DIR.  For that, a new helper
function, snd_config_topdir(), was introduced, and the codes referring
to the top config dir have been modified to handle it dynamically.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/conf.h            |  2 ++
 src/alisp/alisp.c         |  2 +-
 src/conf.c                | 66 ++++++++++++++++++++++++++++++++---------------
 src/confmisc.c            |  2 +-
 src/mixer/simple_abst.c   |  8 ++++--
 src/topology/data.c       |  7 +++--
 src/topology/tplg_local.h |  1 -
 src/ucm/parser.c          | 26 +++++++++++++------
 src/ucm/ucm_local.h       |  1 -
 9 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/include/conf.h b/include/conf.h
index 5d293d583fbb..efb1176b8b7f 100644
--- a/include/conf.h
+++ b/include/conf.h
@@ -84,6 +84,8 @@ typedef struct _snd_config_update snd_config_update_t;
 
 extern snd_config_t *snd_config;
 
+const char *snd_config_topdir(void);
+
 int snd_config_top(snd_config_t **config);
 
 int snd_config_load(snd_config_t *config, snd_input_t *in);
diff --git a/src/alisp/alisp.c b/src/alisp/alisp.c
index 3c61bb1754c3..4ed4ad1ed02d 100644
--- a/src/alisp/alisp.c
+++ b/src/alisp/alisp.c
@@ -2399,7 +2399,7 @@ struct alisp_object * F_path(struct alisp_instance *instance, struct alisp_objec
 	}
 	if (!strcmp(p1->value.s, "data")) {
 		delete_tree(instance, p1);
-		return new_string(instance, ALSA_CONFIG_DIR);
+		return new_string(instance, snd_config_topdir());
 	}
 	delete_tree(instance, p1);
 	return &alsa_lisp_nil;
diff --git a/src/conf.c b/src/conf.c
index fbd90ac277ca..2b52b44e9144 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -555,6 +555,37 @@ static void free_include_paths(struct filedesc *fd)
 	}
 }
 
+/**
+ * \brief Returns the default top-level config directory
+ * \return The top-level config directory path string
+ *
+ * This function returns the string of the top-level config directory path.
+ * If the path is specified via the environment variable \c ALSA_CONFIG_DIR
+ * and the value is a valid path, it returns this value.  If unspecified, it
+ * returns the default value, "/usr/share/alsa".
+ */
+const char *snd_config_topdir(void)
+{
+	static char *topdir;
+
+	if (!topdir) {
+		topdir = getenv("ALSA_CONFIG_DIR");
+		if (!topdir || *topdir != '/' || strlen(topdir) >= PATH_MAX)
+			topdir = ALSA_CONFIG_DIR;
+	}
+	return topdir;
+}
+
+static char *_snd_config_path(const char *name)
+{
+	const char *root = snd_config_topdir();
+	char *path = malloc(strlen(root) + strlen(name) + 2);
+	if (!path)
+		return NULL;
+	sprintf(path, "%s/%s", root, name);
+	return path;
+}
+
 /*
  * Search and open a file, and creates a new input object reading from the file.
  * param inputp - The functions puts the pointer to the new input object
@@ -589,7 +620,7 @@ static int input_stdio_open(snd_input_t **inputp, const char *file,
 		return err;
 
 	/* search file in top configuration directory /usr/share/alsa */
-	snprintf(full_path, PATH_MAX, "%s/%s", ALSA_CONFIG_DIR, file);
+	snprintf(full_path, PATH_MAX, "%s/%s", snd_config_topdir(), file);
 	err = snd_input_stdio_open(inputp, full_path, "r");
 	if (err == 0)
 		goto out;
@@ -750,16 +781,10 @@ static int get_char_skip_comments(input_t *input)
 
 			if (!strncmp(str, "searchdir:", 10)) {
 				/* directory to search included files */
-				char *tmp;
-
-				tmp = malloc(strlen(ALSA_CONFIG_DIR) + 1
-					     + strlen(str + 10) + 1);
-				if (tmp == NULL) {
-					free(str);
-					return -ENOMEM;
-				}
-				sprintf(tmp, ALSA_CONFIG_DIR "/%s", str + 10);
+				char *tmp = _snd_config_path(str + 10);
 				free(str);
+				if (tmp == NULL)
+					return -ENOMEM;
 				str = tmp;
 
 				dirp = opendir(str);
@@ -781,13 +806,10 @@ static int get_char_skip_comments(input_t *input)
 
 			if (!strncmp(str, "confdir:", 8)) {
 				/* file in the specified directory */
-				char *tmp = malloc(strlen(ALSA_CONFIG_DIR) + 1 + strlen(str + 8) + 1);
-				if (tmp == NULL) {
-					free(str);
-					return -ENOMEM;
-				}
-				sprintf(tmp, ALSA_CONFIG_DIR "/%s", str + 8);
+				char *tmp = _snd_config_path(str + 8);
 				free(str);
+				if (tmp == NULL)
+					return -ENOMEM;
 				str = tmp;
 				err = snd_input_stdio_open(&in, str, "r");
 			} else { /* absolute or relative file path */
@@ -3408,9 +3430,6 @@ int snd_config_search_alias_hooks(snd_config_t *config,
 /** The name of the environment variable containing the files list for #snd_config_update. */
 #define ALSA_CONFIG_PATH_VAR "ALSA_CONFIG_PATH"
 
-/** The name of the default files used by #snd_config_update. */
-#define ALSA_CONFIG_PATH_DEFAULT ALSA_CONFIG_DIR "/alsa.conf"
-
 /**
  * \ingroup Config
  * \brief Configuration top-level node (the global configuration).
@@ -3869,8 +3888,13 @@ int snd_config_update_r(snd_config_t **_top, snd_config_update_t **_update, cons
 	configs = cfgs;
 	if (!configs) {
 		configs = getenv(ALSA_CONFIG_PATH_VAR);
-		if (!configs || !*configs)
-			configs = ALSA_CONFIG_PATH_DEFAULT;
+		if (!configs || !*configs) {
+			const char *topdir = snd_config_topdir();
+			char *s = alloca(strlen(topdir) +
+					 strlen("alsa.conf") + 2);
+			sprintf(s, "%s/alsa.conf", topdir);
+			configs = s;
+		}
 	}
 	for (k = 0, c = configs; (l = strcspn(c, ": ")) > 0; ) {
 		c += l;
diff --git a/src/confmisc.c b/src/confmisc.c
index a985f1434dd9..d5b934b62cb6 100644
--- a/src/confmisc.c
+++ b/src/confmisc.c
@@ -588,7 +588,7 @@ int snd_func_datadir(snd_config_t **dst, snd_config_t *root ATTRIBUTE_UNUSED,
 	err = snd_config_get_id(src, &id);
 	if (err < 0)
 		return err;
-	return snd_config_imake_string(dst, id, ALSA_CONFIG_DIR);
+	return snd_config_imake_string(dst, id, snd_config_topdir());
 }
 #ifndef DOC_HIDDEN
 SND_DLSYM_BUILD_VERSION(snd_func_datadir, SND_CONFIG_DLSYM_VERSION_EVALUATE);
diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
index 5297472a6d26..477c73ff7a1e 100644
--- a/src/mixer/simple_abst.c
+++ b/src/mixer/simple_abst.c
@@ -299,8 +299,12 @@ int snd_mixer_simple_basic_register(snd_mixer_t *mixer,
 	snd_mixer_class_set_private(class, priv);
 	snd_mixer_class_set_private_free(class, private_free);
 	file = getenv("ALSA_MIXER_SIMPLE");
-	if (!file)
-		file = ALSA_CONFIG_DIR "/smixer.conf";
+	if (!file) {
+		const char *topdir = snd_config_topdir();
+		char *s = alloca(strlen(topdir) + strlen("smixer.conf") + 2);
+		sprintf(s, "%s/smixer.conf", topdir);
+		file = s;
+	}
 	err = snd_config_top(&top);
 	if (err >= 0) {
 		err = snd_input_stdio_open(&input, file, "r");
diff --git a/src/topology/data.c b/src/topology/data.c
index 36060eb1bf97..5b83b9fc22e1 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -76,8 +76,11 @@ static int tplg_parse_data_file(snd_config_t *cfg, struct tplg_elem *elem)
 		return -EINVAL;
 
 	/* prepend alsa config directory to path */
-	snprintf(filename, sizeof(filename), "%s/%s",
-		env ? env : ALSA_TPLG_DIR, value);
+	if (env)
+		snprintf(filename, sizeof(filename), "%s/%s", env, value);
+	else
+		snprintf(filename, sizeof(filename), "%s/topology/%s",
+			 snd_config_topdir(), value);
 
 	fp = fopen(filename, "r");
 	if (fp == NULL) {
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index eb7eac5b2305..42e3201db41b 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -31,7 +31,6 @@
 
 #define MAX_FILE		256
 #define TPLG_MAX_PRIV_SIZE	(1024 * 128)
-#define ALSA_TPLG_DIR	ALSA_CONFIG_DIR "/topology"
 
 /** The name of the environment variable containing the tplg directory */
 #define ALSA_CONFIG_TPLG_VAR "ALSA_CONFIG_TPLG"
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index b79b92dbf7b1..8aa7099483ed 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -1082,9 +1082,12 @@ static int parse_verb_file(snd_use_case_mgr_t *uc_mgr,
 	}
 
 	/* open Verb file for reading */
-	snprintf(filename, sizeof(filename), "%s/%s/%s",
-		env ? env : ALSA_USE_CASE_DIR,
-		uc_mgr->card_name, file);
+	if (env)
+		snprintf(filename, sizeof(filename), "%s/%s/%s",
+			 env, uc_mgr->card_name, file);
+	else
+		snprintf(filename, sizeof(filename), "%s/ucm/%s/%s",
+			 snd_config_topdir(), uc_mgr->card_name, file);
 	filename[sizeof(filename)-1] = '\0';
 	
 	err = uc_mgr_config_load(filename, &cfg);
@@ -1404,9 +1407,13 @@ static int load_master_config(const char *card_name, snd_config_t **cfg)
 		return -EINVAL;
 	}
 
-	snprintf(filename, sizeof(filename)-1,
-		"%s/%s/%s.conf", env ? env : ALSA_USE_CASE_DIR,
-		card_name, card_name);
+	if (env)
+		snprintf(filename, sizeof(filename)-1,
+			 "%s/%s/%s.conf", env, card_name, card_name);
+	else
+		snprintf(filename, sizeof(filename)-1,
+			 "%s/ucm/%s/%s.conf", snd_config_topdir(),
+			 card_name, card_name);
 	filename[MAX_FILE-1] = '\0';
 
 	err = uc_mgr_config_load(filename, cfg);
@@ -1514,8 +1521,11 @@ int uc_mgr_scan_master_configs(const char **_list[])
 	ssize_t ss;
 	struct dirent **namelist;
 
-	snprintf(filename, sizeof(filename)-1,
-		"%s", env ? env : ALSA_USE_CASE_DIR);
+	if (env)
+		snprintf(filename, sizeof(filename)-1, "%s", env);
+	else
+		snprintf(filename, sizeof(filename)-1, "%s/ucm",
+			 snd_config_topdir());
 	filename[MAX_FILE-1] = '\0';
 
 #if defined(_GNU_SOURCE) && !defined(__NetBSD__) && !defined(__FreeBSD__) && !defined(__sun)
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index 299a5b96dba5..e5f59cea721f 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -42,7 +42,6 @@
 
 #define MAX_FILE		256
 #define MAX_CARD_LONG_NAME	80
-#define ALSA_USE_CASE_DIR	ALSA_CONFIG_DIR "/ucm"
 
 #define SEQUENCE_ELEMENT_TYPE_CDEV	1
 #define SEQUENCE_ELEMENT_TYPE_CSET	2
-- 
2.12.2
