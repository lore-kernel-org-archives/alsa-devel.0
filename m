From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ucm: Set default include path
Date: Thu, 29 Nov 2018 09:45:16 +0100
Message-ID: <20181129084516.21365-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C0176267AF3
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 09:45:19 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 39166AE58
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2018 08:45:19 +0000 (UTC)
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

Many UCM profiles include the UCM profile components under ucm/*
subdirectories and thusly put <searchdir:ucm> at each place.  This is
rather cumbersome.

This patch makes the UCM parser to set the default include path, so
that each profile no longer needs to set searchdir.  All the
<searchdir:ucm> lines currently found in the profiles are removed
gracefully, too.

For the needed implementation, a new helper,
_snd_config_load_with_include() is introduced.  It's not exported,
only for the use inside alsa-lib.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/local.h                               |  3 ++
 src/conf.c                                    | 32 +++++++++++++++++--
 .../HiFi.conf                                 |  1 -
 .../bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf |  1 -
 .../bytcr-rt5640-mono-spk-in1-mic/HiFi.conf   |  1 -
 .../bytcr-rt5640-mono-spk-in3-mic/HiFi.conf   |  1 -
 .../HiFi.conf                                 |  1 -
 .../bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf |  1 -
 .../bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf |  1 -
 src/conf/ucm/bytcr-rt5640/HiFi.conf           |  1 -
 .../bytcr-rt5651-mono-spk-in1-mic/HiFi.conf   |  1 -
 .../HiFi.conf                                 |  1 -
 .../bytcr-rt5651-mono-spk-in2-mic/HiFi.conf   |  1 -
 .../bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf |  1 -
 .../HiFi.conf                                 |  1 -
 .../bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf |  1 -
 src/conf/ucm/bytcr-rt5651/HiFi.conf           |  1 -
 src/conf/ucm/chtnau8824/HiFi.conf             |  1 -
 src/conf/ucm/chtrt5645/HiFi.conf              |  1 -
 .../HiFi.conf                                 |  1 -
 src/ucm/parser.c                              |  3 --
 src/ucm/ucm_local.h                           |  3 ++
 src/ucm/utils.c                               |  7 +++-
 23 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/include/local.h b/include/local.h
index b5e7b6f00ff5..03d8f0ccdc58 100644
--- a/include/local.h
+++ b/include/local.h
@@ -354,6 +354,9 @@ int snd_config_search_alias_hooks(snd_config_t *config,
 
 int _snd_conf_generic_id(const char *id);
 
+int _snd_config_load_with_include(snd_config_t *config, snd_input_t *in,
+				  const char *default_include_path);
+
 /* convenience macros */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
 
diff --git a/src/conf.c b/src/conf.c
index 254c485868b5..1f9bad7b3a97 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -1832,7 +1832,8 @@ int snd_config_top(snd_config_t **config)
 	return _snd_config_make(config, 0, SND_CONFIG_TYPE_COMPOUND);
 }
 
-static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override)
+static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override,
+			    char *default_include_path)
 {
 	int err;
 	input_t input;
@@ -1847,6 +1848,11 @@ static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override)
 	fd->column = 0;
 	fd->next = NULL;
 	INIT_LIST_HEAD(&fd->include_paths);
+	if (default_include_path) {
+		err = add_include_path(fd, default_include_path);
+		if (err < 0)
+			goto _end;
+	}
 	input.current = fd;
 	input.unget = 0;
 	err = parse_defs(config, &input, 0, override);
@@ -1915,9 +1921,29 @@ static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override)
  */
 int snd_config_load(snd_config_t *config, snd_input_t *in)
 {
-	return snd_config_load1(config, in, 0);
+	return snd_config_load1(config, in, 0, NULL);
 }
 
+#ifndef DOC_HIDDEN
+/* load config with the default include path; used internally for UCM parser */
+int _snd_config_load_with_include(snd_config_t *config, snd_input_t *in,
+				  const char *default_include_path)
+{
+	int err;
+	char *s = NULL;
+
+	if (default_include_path) {
+		s = strdup(default_include_path);
+		if (!s)
+			return -ENOMEM;
+	}
+	err = snd_config_load1(config, in, 0, s);
+	if (err < 0)
+		free(s);
+	return err;
+}
+#endif
+
 /**
  * \brief Loads a configuration tree and overrides existing configuration nodes.
  * \param config Handle to a top level configuration node.
@@ -1930,7 +1956,7 @@ int snd_config_load(snd_config_t *config, snd_input_t *in)
  */
 int snd_config_load_override(snd_config_t *config, snd_input_t *in)
 {
-	return snd_config_load1(config, in, 1);
+	return snd_config_load1(config, in, 1, NULL);
 }
 
 /**
diff --git a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
index facc73ac3b2b..b931b7914ce7 100644
--- a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
+++ b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
@@ -1,4 +1,3 @@
-<searchdir:ucm>
 
 SectionVerb {
 
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
index c78cdfb80a44..0e21d6e1abf9 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Use case Configuration for bytcr-rt5640
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
index 34a5d53d363c..d8ca499a5799 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Use case Configuration for bytcr-rt5640
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
index 0aa0c0266412..e4fb28df546f 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Use case Configuration for bytcr-rt5640
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
index e358d4f23f12..bb31bf531633 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Use case Configuration for bytcr-rt5640
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
index 097560d02d12..9474a64e84ff 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Use case Configuration for bytcr-rt5640
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
index 8a018f63c9c6..478130e67ae4 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Use case Configuration for bytcr-rt5640
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5640/HiFi.conf b/src/conf/ucm/bytcr-rt5640/HiFi.conf
index 20ebe2dd36e2..54dd2517dbd7 100644
--- a/src/conf/ucm/bytcr-rt5640/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640/HiFi.conf
@@ -1,6 +1,5 @@
 # Use case Configuration for bytcr-rt5640
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
index ca8a7d9078fb..b93e0be33cbd 100644
--- a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
index 60ef6b332ea2..ef048626732e 100644
--- a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
@@ -1,6 +1,5 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
index e75210d4aa7e..c324c14ad542 100644
--- a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
index 2b7675bce831..aa1a1cde7856 100644
--- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
index 7a8c94bc5d6b..343aed211bb4 100644
--- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
index 45c7837c6fb9..6f6d74cf2e68 100644
--- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
@@ -1,6 +1,5 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index d3928e9b9976..fddd8a3ca19a 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -1,6 +1,5 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
-<searchdir:ucm>
 
 SectionVerb {
 	EnableSequence [
diff --git a/src/conf/ucm/chtnau8824/HiFi.conf b/src/conf/ucm/chtnau8824/HiFi.conf
index 97a7ac7ba366..845cbcaffe5f 100644
--- a/src/conf/ucm/chtnau8824/HiFi.conf
+++ b/src/conf/ucm/chtnau8824/HiFi.conf
@@ -1,4 +1,3 @@
-<searchdir:ucm>
 
 SectionVerb {
 
diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index 6a3c6875f301..422f3b7eef4f 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -1,4 +1,3 @@
-<searchdir:ucm>
 
 SectionVerb {
 	# ALSA PCM
diff --git a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
index facc73ac3b2b..b931b7914ce7 100644
--- a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
+++ b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
@@ -1,4 +1,3 @@
-<searchdir:ucm>
 
 SectionVerb {
 
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 2b6f1159aa7d..5e1a8862fac1 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -34,9 +34,6 @@
 #include <dirent.h>
 #include <limits.h>
 
-/** The name of the environment variable containing the UCM directory */
-#define ALSA_CONFIG_UCM_VAR "ALSA_CONFIG_UCM"
-
 /* Directories to store UCM configuration files for components, like
  * off-soc codecs or embedded DSPs. Components can define their own
  * devices and sequences, to be reused by sound cards/machines. UCM
diff --git a/src/ucm/ucm_local.h b/src/ucm/ucm_local.h
index ce2fc6ea18eb..8e7ac7ea48e9 100644
--- a/src/ucm/ucm_local.h
+++ b/src/ucm/ucm_local.h
@@ -243,3 +243,6 @@ void uc_mgr_free_sequence_element(struct sequence_element *seq);
 void uc_mgr_free_transition_element(struct transition_sequence *seq);
 void uc_mgr_free_verb(snd_use_case_mgr_t *uc_mgr);
 void uc_mgr_free(snd_use_case_mgr_t *uc_mgr);
+
+/** The name of the environment variable containing the UCM directory */
+#define ALSA_CONFIG_UCM_VAR "ALSA_CONFIG_UCM"
diff --git a/src/ucm/utils.c b/src/ucm/utils.c
index 18785488db07..ea5ac5dd1b01 100644
--- a/src/ucm/utils.c
+++ b/src/ucm/utils.c
@@ -54,6 +54,7 @@ int uc_mgr_config_load(const char *file, snd_config_t **cfg)
 	FILE *fp;
 	snd_input_t *in;
 	snd_config_t *top;
+	const char *default_path;
 	int err;
 
 	fp = fopen(file, "r");
@@ -70,7 +71,11 @@ int uc_mgr_config_load(const char *file, snd_config_t **cfg)
 	err = snd_config_top(&top);
 	if (err < 0)
 		return err;
-	err = snd_config_load(top, in);
+
+	default_path = getenv(ALSA_CONFIG_UCM_VAR);
+	if (!default_path || !*default_path)
+		default_path = ALSA_CONFIG_DIR "/ucm";
+	err = _snd_config_load_with_include(top, in, default_path);
 	if (err < 0) {
 		uc_error("could not load configuration file %s", file);
 		snd_config_delete(top);
-- 
2.19.1
