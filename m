From: Jaroslav Kysela <perex@perex.cz>
Subject: ["PATCH alsa-lib"] Change snd_dlopen() function to
	return the error string
Date: Mon, 27 Nov 2017 09:50:16 +0100
Message-ID: <20171127085016.11339-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B589266B0F
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 09:50:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The dlopen() function might fail also for another reason than
a missing file, thus return the error string from dlerror().

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 include/global.h        |  2 +-
 src/Versions.in         |  5 +++++
 src/conf.c              | 13 ++++++-----
 src/dlmisc.c            | 60 +++++++++++++++++++++++++++++++++++++++----------
 src/hwdep/hwdep.c       |  6 ++---
 src/mixer/simple_abst.c | 10 ++++-----
 src/pcm/pcm_hooks.c     |  8 +++----
 src/pcm/pcm_meter.c     |  6 ++---
 src/rawmidi/rawmidi.c   |  6 ++---
 src/seq/seq.c           |  6 ++---
 src/timer/timer.c       |  6 ++---
 src/timer/timer_query.c |  6 ++---
 12 files changed, 88 insertions(+), 46 deletions(-)

diff --git a/include/global.h b/include/global.h
index 41680829..d73d333a 100644
--- a/include/global.h
+++ b/include/global.h
@@ -97,7 +97,7 @@ extern struct snd_dlsym_link *snd_dlsym_start;
 /** \brief Returns the version of a dynamic symbol as a string. */
 #define SND_DLSYM_VERSION(version) __STRING(version)
 
-void *snd_dlopen(const char *file, int mode);
+void *snd_dlopen(const char *file, int mode, char *errbuf, size_t errbuflen);
 void *snd_dlsym(void *handle, const char *name, const char *version);
 int snd_dlclose(void *handle);
 
diff --git a/src/Versions.in b/src/Versions.in
index 8d2dd116..2f9e1697 100644
--- a/src/Versions.in
+++ b/src/Versions.in
@@ -129,3 +129,8 @@ ALSA_0.9.7 {
     @SYMBOL_PREFIX@alsa_lisp_*;
 } ALSA_0.9.5;
 
+ALSA_1.1.6 {
+  global:
+
+    @SYMBOL_PREFIX@snd_dlopen;
+} ALSA_1.1.6;
diff --git a/src/conf.c b/src/conf.c
index c410bfb8..e71bb972 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -982,6 +982,7 @@ static int get_freestring(char **string, int id, input_t *input)
 		case '.':
 			if (!id)
 				break;
+			/* fall through */
 		case ' ':
 		case '\f':
 		case '\t':
@@ -3477,7 +3478,7 @@ static int snd_config_hooks_call(snd_config_t *root, snd_config_t *config, snd_c
 {
 	void *h = NULL;
 	snd_config_t *c, *func_conf = NULL;
-	char *buf = NULL;
+	char *buf = NULL, errbuf[256];
 	const char *lib = NULL, *func_name = NULL;
 	const char *str;
 	int (*func)(snd_config_t *root, snd_config_t *config, snd_config_t **dst, snd_config_t *private_data) = NULL;
@@ -3537,11 +3538,11 @@ static int snd_config_hooks_call(snd_config_t *root, snd_config_t *config, snd_c
 		buf[len-1] = '\0';
 		func_name = buf;
 	}
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	func = h ? snd_dlsym(h, func_name, SND_DLSYM_VERSION(SND_CONFIG_DLSYM_VERSION_HOOK)) : NULL;
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s", lib);
+		SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 		err = -ENOENT;
 	} else if (!func) {
 		SNDERR("symbol %s is not defined inside %s", func_name, lib);
@@ -4471,7 +4472,7 @@ static int _snd_config_evaluate(snd_config_t *src,
 {
 	int err;
 	if (pass == SND_CONFIG_WALK_PASS_PRE) {
-		char *buf = NULL;
+		char *buf = NULL, errbuf[256];
 		const char *lib = NULL, *func_name = NULL;
 		const char *str;
 		int (*func)(snd_config_t **dst, snd_config_t *root,
@@ -4530,12 +4531,12 @@ static int _snd_config_evaluate(snd_config_t *src,
 			buf[len-1] = '\0';
 			func_name = buf;
 		}
-		h = snd_dlopen(lib, RTLD_NOW);
+		h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 		if (h)
 			func = snd_dlsym(h, func_name, SND_DLSYM_VERSION(SND_CONFIG_DLSYM_VERSION_EVALUATE));
 		err = 0;
 		if (!h) {
-			SNDERR("Cannot open shared library %s", lib);
+			SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 			err = -ENOENT;
 			goto _errbuf;
 		} else if (!func) {
diff --git a/src/dlmisc.c b/src/dlmisc.c
index f154ebd0..fca843e1 100644
--- a/src/dlmisc.c
+++ b/src/dlmisc.c
@@ -43,12 +43,18 @@ struct snd_dlsym_link *snd_dlsym_start = NULL;
  * \brief Opens a dynamic library - ALSA wrapper for \c dlopen.
  * \param name name of the library, similar to \c dlopen.
  * \param mode mode flags, similar to \c dlopen.
+ * \param errbuf a string buffer for the error message \c dlerror.
+ * \param errbuflen a length of the string buffer for the error message.
  * \return Library handle if successful, otherwise \c NULL.
  *
  * This function can emulate dynamic linking for the static build of
  * the alsa-lib library. In that case, \p name is set to \c NULL.
  */
-void *snd_dlopen(const char *name, int mode)
+#ifndef DOXYGEN
+void *INTERNAL(snd_dlopen)(const char *name, int mode, char *errbuf, size_t errbuflen)
+#else
+void *snd_dlopen(const char *name, int mode, char *errbuf, size_t errbuflen)
+#endif
 {
 #ifndef PIC
 	if (name == NULL)
@@ -73,24 +79,49 @@ void *snd_dlopen(const char *name, int mode)
 	 * via ld.so.conf.
 	 */
 	void *handle = NULL;
-	char *filename;
+	char *filename = NULL;
 
 	if (name && name[0] != '/') {
-		filename = malloc(sizeof(ALSA_PLUGIN_DIR) + 1 + strlen(name) + 1);
-		strcpy(filename, ALSA_PLUGIN_DIR);
-		strcat(filename, "/");
-		strcat(filename, name);
-		handle = dlopen(filename, mode);
-		free(filename);
+		filename = alloca(sizeof(ALSA_PLUGIN_DIR) + 1 + strlen(name) + 1);
+		if (filename) {
+			strcpy(filename, ALSA_PLUGIN_DIR);
+			strcat(filename, "/");
+			strcat(filename, name);
+			handle = dlopen(filename, mode);
+			if (!handle) {
+				/* if the filename exists and cannot be opened */
+				/* return immediately */
+				if (access(filename, X_OK) == 0)
+					goto errpath;
+			}
+		}
 	}
-	if (!handle)
+	if (!handle) {
 		handle = dlopen(name, mode);
+		if (!handle)
+			goto errpath;
+	}
 	return handle;
+errpath:
+	if (errbuf)
+		snprintf(errbuf, errbuflen, "%s: %s", filename, dlerror());
+	return NULL;
+	
 #else
 	return NULL;
 #endif
 }
 
+#ifndef DOXYGEN
+void *INTERNAL(snd_dlopen_old)(const char *name, int mode)
+{
+  return INTERNAL(snd_dlopen)(name, mode, NULL, 0);
+}
+#endif
+
+use_symbol_version(__snd_dlopen_old, snd_dlopen, ALSA_0.9);
+use_default_symbol_version(__snd_dlopen, snd_dlopen, ALSA_1.1.6);
+
 /**
  * \brief Closes a dynamic library - ALSA wrapper for \c dlclose.
  * \param handle Library handle, similar to \c dlclose.
@@ -229,6 +260,7 @@ void *snd_dlobj_cache_get(const char *lib, const char *name,
 	struct list_head *p;
 	struct dlobj_cache *c;
 	void *func, *dlobj;
+	char errbuf[256];
 
 	snd_dlobj_lock();
 	list_for_each(p, &pcm_dlobj_list) {
@@ -247,11 +279,15 @@ void *snd_dlobj_cache_get(const char *lib, const char *name,
 		}
 	}
 
-	dlobj = snd_dlopen(lib, RTLD_NOW);
+	errbuf[0] = '\0';
+	dlobj = snd_dlopen(lib, RTLD_NOW,
+	                   verbose ? errbuf : 0,
+	                   verbose ? sizeof(errbuf) : 0);
 	if (dlobj == NULL) {
 		if (verbose)
-			SNDERR("Cannot open shared library %s",
-						lib ? lib : "[builtin]");
+			SNDERR("Cannot open shared library %s (%s)",
+						lib ? lib : "[builtin]",
+						errbuf);
 		snd_dlobj_unlock();
 		return NULL;
 	}
diff --git a/src/hwdep/hwdep.c b/src/hwdep/hwdep.c
index 29350936..7aa475c0 100644
--- a/src/hwdep/hwdep.c
+++ b/src/hwdep/hwdep.c
@@ -41,7 +41,7 @@ static int snd_hwdep_open_conf(snd_hwdep_t **hwdep,
 			       snd_config_t *hwdep_conf, int mode)
 {
 	const char *str;
-	char buf[256];
+	char buf[256], errbuf[256];
 	int err;
 	snd_config_t *conf, *type_conf = NULL;
 	snd_config_iterator_t i, next;
@@ -116,12 +116,12 @@ static int snd_hwdep_open_conf(snd_hwdep_t **hwdep,
 #ifndef PIC
 	snd_hwdep_open_symbols();
 #endif
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	if (h)
 		open_func = snd_dlsym(h, open_name, SND_DLSYM_VERSION(SND_HWDEP_DLSYM_VERSION));
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s", lib);
+		SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 		err = -ENOENT;
 	} else if (!open_func) {
 		SNDERR("symbol %s is not defined inside %s", open_name, lib);
diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
index 73528393..32a3f621 100644
--- a/src/mixer/simple_abst.c
+++ b/src/mixer/simple_abst.c
@@ -66,7 +66,7 @@ static int try_open(snd_mixer_class_t *class, const char *lib)
 	class_priv_t *priv = snd_mixer_class_get_private(class);
 	snd_mixer_event_t event_func;
 	snd_mixer_sbasic_init_t init_func = NULL;
-	char *xlib, *path;
+	char *xlib, *path, errbuf[256];
 	void *h;
 	int err = 0;
 
@@ -81,9 +81,9 @@ static int try_open(snd_mixer_class_t *class, const char *lib)
 	strcpy(xlib, path);
 	strcat(xlib, "/");
 	strcat(xlib, lib);
-	h = snd_dlopen(xlib, RTLD_NOW);
+	h = snd_dlopen(xlib, RTLD_NOW, errbuf, sizeof(errbuf));
 	if (h == NULL) {
-		SNDERR("Unable to open library '%s'", xlib);
+		SNDERR("Unable to open library '%s' (%s)", xlib, errbuf);
 		free(xlib);
 		return -ENXIO;
 	}
@@ -114,7 +114,7 @@ static int try_open_full(snd_mixer_class_t *class, snd_mixer_t *mixer,
 	class_priv_t *priv = snd_mixer_class_get_private(class);
 	snd_mixer_event_t event_func;
 	snd_mixer_sfbasic_init_t init_func = NULL;
-	char *xlib, *path;
+	char *xlib, *path, errbuf[256];
 	void *h;
 	int err = 0;
 
@@ -128,7 +128,7 @@ static int try_open_full(snd_mixer_class_t *class, snd_mixer_t *mixer,
 	strcat(xlib, "/");
 	strcat(xlib, lib);
 	/* note python modules requires RTLD_GLOBAL */
-	h = snd_dlopen(xlib, RTLD_NOW|RTLD_GLOBAL);
+	h = snd_dlopen(xlib, RTLD_NOW|RTLD_GLOBAL, errbuf, sizeof(errbuf));
 	if (h == NULL) {
 		SNDERR("Unable to open library '%s'", xlib);
 		free(xlib);
diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index adb7230b..1f08bd78 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -341,7 +341,7 @@ even if the specified control doesn't exist.
 static int snd_pcm_hook_add_conf(snd_pcm_t *pcm, snd_config_t *root, snd_config_t *conf)
 {
 	int err;
-	char buf[256];
+	char buf[256], errbuf[256];
 	const char *str, *id;
 	const char *lib = NULL, *install = NULL;
 	snd_config_t *type = NULL, *args = NULL;
@@ -424,12 +424,12 @@ static int snd_pcm_hook_add_conf(snd_pcm_t *pcm, snd_config_t *root, snd_config_
 		install = buf;
 		snprintf(buf, sizeof(buf), "_snd_pcm_hook_%s_install", str);
 	}
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	install_func = h ? snd_dlsym(h, install, SND_DLSYM_VERSION(SND_PCM_DLSYM_VERSION)) : NULL;
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s",
-		       lib ? lib : "[builtin]");
+		SNDERR("Cannot open shared library %s (%s)",
+		       lib ? lib : "[builtin]", errbuf);
 		err = -ENOENT;
 	} else if (!install_func) {
 		SNDERR("symbol %s is not defined inside %s", install,
diff --git a/src/pcm/pcm_meter.c b/src/pcm/pcm_meter.c
index 53685094..75df09ca 100644
--- a/src/pcm/pcm_meter.c
+++ b/src/pcm/pcm_meter.c
@@ -605,7 +605,7 @@ int snd_pcm_meter_open(snd_pcm_t **pcmp, const char *name, unsigned int frequenc
 static int snd_pcm_meter_add_scope_conf(snd_pcm_t *pcm, const char *name,
 					snd_config_t *root, snd_config_t *conf)
 {
-	char buf[256];
+	char buf[256], errbuf[256];
 	snd_config_iterator_t i, next;
 	const char *id;
 	const char *lib = NULL, *open_name = NULL, *str = NULL;
@@ -670,11 +670,11 @@ static int snd_pcm_meter_add_scope_conf(snd_pcm_t *pcm, const char *name,
 		open_name = buf;
 		snprintf(buf, sizeof(buf), "_snd_pcm_scope_%s_open", str);
 	}
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	open_func = h ? dlsym(h, open_name) : NULL;
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s", lib);
+		SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 		err = -ENOENT;
 	} else if (!open_func) {
 		SNDERR("symbol %s is not defined inside %s", open_name, lib);
diff --git a/src/rawmidi/rawmidi.c b/src/rawmidi/rawmidi.c
index 7180becd..88d43017 100644
--- a/src/rawmidi/rawmidi.c
+++ b/src/rawmidi/rawmidi.c
@@ -162,7 +162,7 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
 				 snd_config_t *rawmidi_conf, int mode)
 {
 	const char *str;
-	char buf[256];
+	char buf[256], errbuf[256];
 	int err;
 	snd_config_t *conf, *type_conf = NULL;
 	snd_config_iterator_t i, next;
@@ -239,12 +239,12 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
 #ifndef PIC
 	snd_rawmidi_open_symbols();
 #endif
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	if (h)
 		open_func = snd_dlsym(h, open_name, SND_DLSYM_VERSION(SND_RAWMIDI_DLSYM_VERSION));
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s", lib);
+		SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 		err = -ENOENT;
 	} else if (!open_func) {
 		SNDERR("symbol %s is not defined inside %s", open_name, lib);
diff --git a/src/seq/seq.c b/src/seq/seq.c
index 630f52c3..983c4fab 100644
--- a/src/seq/seq.c
+++ b/src/seq/seq.c
@@ -823,7 +823,7 @@ static int snd_seq_open_conf(snd_seq_t **seqp, const char *name,
 			     int streams, int mode)
 {
 	const char *str;
-	char buf[256];
+	char buf[256], errbuf[256];
 	int err;
 	snd_config_t *conf, *type_conf = NULL;
 	snd_config_iterator_t i, next;
@@ -899,12 +899,12 @@ static int snd_seq_open_conf(snd_seq_t **seqp, const char *name,
 #ifndef PIC
 	snd_seq_open_symbols();
 #endif
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	if (h)
 		open_func = snd_dlsym(h, open_name, SND_DLSYM_VERSION(SND_SEQ_DLSYM_VERSION));
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s", lib);
+		SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 		err = -ENOENT;
 	} else if (!open_func) {
 		SNDERR("symbol %s is not defined inside %s", open_name, lib);
diff --git a/src/timer/timer.c b/src/timer/timer.c
index e027c903..8c49737e 100644
--- a/src/timer/timer.c
+++ b/src/timer/timer.c
@@ -76,7 +76,7 @@ static int snd_timer_open_conf(snd_timer_t **timer,
 			       snd_config_t *timer_conf, int mode)
 {
 	const char *str;
-	char buf[256];
+	char buf[256], errbuf[256];
 	int err;
 	snd_config_t *conf, *type_conf = NULL;
 	snd_config_iterator_t i, next;
@@ -150,12 +150,12 @@ static int snd_timer_open_conf(snd_timer_t **timer,
 #ifndef PIC
 	snd_timer_open_symbols();
 #endif
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	if (h)
 		open_func = snd_dlsym(h, open_name, SND_DLSYM_VERSION(SND_TIMER_DLSYM_VERSION));
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s", lib);
+		SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 		err = -ENOENT;
 	} else if (!open_func) {
 		SNDERR("symbol %s is not defined inside %s", open_name, lib);
diff --git a/src/timer/timer_query.c b/src/timer/timer_query.c
index d999d21b..6739f3c4 100644
--- a/src/timer/timer_query.c
+++ b/src/timer/timer_query.c
@@ -33,7 +33,7 @@ static int snd_timer_query_open_conf(snd_timer_query_t **timer,
 				     snd_config_t *timer_conf, int mode)
 {
 	const char *str;
-	char buf[256];
+	char buf[256], errbuf[256];
 	int err;
 	snd_config_t *conf, *type_conf = NULL;
 	snd_config_iterator_t i, next;
@@ -108,12 +108,12 @@ static int snd_timer_query_open_conf(snd_timer_query_t **timer,
 #ifndef PIC
 	snd_timer_query_open_symbols();
 #endif
-	h = snd_dlopen(lib, RTLD_NOW);
+	h = snd_dlopen(lib, RTLD_NOW, errbuf, sizeof(errbuf));
 	if (h)
 		open_func = snd_dlsym(h, open_name, SND_DLSYM_VERSION(SND_TIMER_QUERY_DLSYM_VERSION));
 	err = 0;
 	if (!h) {
-		SNDERR("Cannot open shared library %s", lib);
+		SNDERR("Cannot open shared library %s (%s)", lib, errbuf);
 		err = -ENOENT;
 	} else if (!open_func) {
 		SNDERR("symbol %s is not defined inside %s", open_name, lib);
-- 
2.13.6
