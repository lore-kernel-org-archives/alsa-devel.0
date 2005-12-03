From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: alsa-lib cross build against uclibc
Date: Sat, 03 Dec 2005 00:53:42 +0000
Message-ID: <1133571222.11438.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+IUpaflyBl42dowCXDt1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, uclibc@uclibc.org
List-Id: alsa-devel@alsa-project.org


--=-+IUpaflyBl42dowCXDt1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I couldn't build the CVS sources against uclibc - the compile would not
work at all.

But I have now been successfully able to patch and build the files. The
patch is attached.

Apologies if the format is a bit messed up.

--=-+IUpaflyBl42dowCXDt1
Content-Disposition: attachment; filename=alsa-lib.uclibc.patch.final
Content-Type: text/plain; name=alsa-lib.uclibc.patch.final; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- old/include/alsa-symbols.h	2005-05-06 15:06:09.000000000 +0100
+++ alsa-lib-1.0.10/include/alsa-symbols.h	2005-12-02 23:21:50.000000000 +0000
@@ -26,8 +26,12 @@
 #define USE_VERSIONED_SYMBOLS
 #endif
 
+#ifdef USE_VERSIONED_SYMBOLS
 #define INTERNAL_CONCAT2_2(Pre, Post) Pre##Post
 #define INTERNAL(Name) INTERNAL_CONCAT2_2(__, Name)
+#else
+#define INTERNAL(Name) Name
+#endif
 
 #ifdef __powerpc64__
 # define symbol_version(real, name, version) 			\
--- old/src/userfile.c	2005-05-24 15:14:29.000000000 +0100
+++ alsa-lib-1.0.10/src/userfile.c	2005-12-02 23:30:49.000000000 +0000
@@ -20,7 +20,11 @@
   
 #include <string.h>
 #include <errno.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
 #include <assert.h>
 
 /**
@@ -34,9 +38,9 @@
  */
 int snd_user_file(const char *file, char **result)
 {
-	wordexp_t we;
 	int err;
-	
+#ifdef HAS_WORDEXP
+	wordexp_t we;
 	assert(file && result);
 	err = wordexp(file, &we, WRDE_NOCMD);
 	switch (err) {
@@ -54,5 +58,24 @@
 	if (*result == NULL)
 		return -ENOMEM;
 	wordfree(&we);
+#else
+	glob_t globbuf;
+	err = glob(file, 0, NULL, &globbuf);
+	switch (err) {
+	case GLOB_NOSPACE:
+		return -ENOMEM;
+	case 0:
+		if (globbuf.gl_pathc == 1)
+			break;
+		/* Fall through */
+	default:
+		globfree(&globbuf);
+		return -EINVAL;
+	}
+	*result = strdup(globbuf.gl_pathv[0]);
+	if (*result == NULL)
+		return -ENOMEM;
+	globfree(&globbuf);
+#endif
 	return 0;
 }
--- old/include/alsa-symbols.h	2005-05-06 15:06:09.000000000 +0100
+++ alsa-lib-1.0.10/include/alsa-symbols.h	2005-12-02 23:21:50.000000000 +0000
@@ -26,8 +26,12 @@
 #define USE_VERSIONED_SYMBOLS
 #endif
 
+#ifdef USE_VERSIONED_SYMBOLS
 #define INTERNAL_CONCAT2_2(Pre, Post) Pre##Post
 #define INTERNAL(Name) INTERNAL_CONCAT2_2(__, Name)
+#else
+#define INTERNAL(Name) Name
+#endif
 
 #ifdef __powerpc64__
 # define symbol_version(real, name, version) 			\
--- src/userfile.c	2005-05-24 15:14:29.000000000 +0100
+++ /home/adrian/alsa-lib-1.0.10/src/userfile.c	2005-12-02 23:30:49.000000000 +0000
@@ -20,7 +20,11 @@
   
 #include <string.h>
 #include <errno.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
 #include <assert.h>
 
 /**
@@ -34,9 +38,9 @@
  */
 int snd_user_file(const char *file, char **result)
 {
-	wordexp_t we;
 	int err;
-	
+#ifdef HAS_WORDEXP
+	wordexp_t we;
 	assert(file && result);
 	err = wordexp(file, &we, WRDE_NOCMD);
 	switch (err) {
@@ -54,5 +58,24 @@
 	if (*result == NULL)
 		return -ENOMEM;
 	wordfree(&we);
+#else
+	glob_t globbuf;
+	err = glob(file, 0, NULL, &globbuf);
+	switch (err) {
+	case GLOB_NOSPACE:
+		return -ENOMEM;
+	case 0:
+		if (globbuf.gl_pathc == 1)
+			break;
+		/* Fall through */
+	default:
+		globfree(&globbuf);
+		return -EINVAL;
+	}
+	*result = strdup(globbuf.gl_pathv[0]);
+	if (*result == NULL)
+		return -ENOMEM;
+	globfree(&globbuf);
+#endif
 	return 0;
 }
--- old/src/conf.c	2005-10-12 17:08:53.000000000 +0100
+++ alsa-lib-1.0.10/src/conf.c	2005-12-02 23:21:50.000000000 +0000
@@ -415,7 +415,11 @@
 
 
 #include <stdarg.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
 #include <dlfcn.h>
 #include <limits.h>
 #include <sys/stat.h>
--- old/src/alisp/alisp.c	2005-01-19 13:56:31.000000000 +0000
+++ alsa-lib-1.0.10/src/alisp/alisp.c	2005-12-02 23:21:50.000000000 +0000
@@ -30,7 +30,11 @@
 #include <ctype.h>
 #include <math.h>
 #include <err.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
 
 #define alisp_seq_iterator alisp_object
 
--- old/src/pcm/pcm_ladspa.c	2005-11-14 09:50:29.000000000 +0000
+++ alsa-lib-1.0.10/src/pcm/pcm_ladspa.c	2005-12-02 23:24:17.000000000 +0000
@@ -28,7 +28,11 @@
   
 #include <dirent.h>
 #include <dlfcn.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
 #include <locale.h>
 #include "pcm_local.h"
 #include "pcm_plugin.h"
@@ -815,13 +819,18 @@
 {
 	const char *c;
 	size_t l;
-	wordexp_t we;
+#ifdef HAS_WORDEXP
+	wordexp_t           we;
+#else
+	glob_t              globbuf;
+#endif
 	int err;
 	
 	for (c = path; (l = strcspn(c, ": ")) > 0; ) {
 		char name[l + 1];
 		memcpy(name, c, l);
 		name[l] = 0;
+#ifdef HAS_WORDEXP
 		err = wordexp(name, &we, WRDE_NOCMD);
 		switch (err) {
 		case WRDE_NOSPACE:
@@ -835,6 +844,21 @@
 		}
 		err = snd_pcm_ladspa_check_dir(plugin, we.we_wordv[0], label, ladspa_id);
 		wordfree(&we);
+#else
+		err = glob(name, 0, NULL, &globbuf);
+		switch (err) {
+		case GLOB_NOSPACE:
+			return -ENOMEM;
+		case 0:
+			if (globbuf.gl_pathc == 1)
+				break;
+			/* Fall through */
+		default:
+			return -EINVAL;
+		}
+		err = snd_pcm_ladspa_check_dir(plugin, globbuf.gl_pathv[0], label, ladspa_id);
+		globfree(&globbuf);
+#endif
 		if (err < 0)
 			return err;
 		if (err > 0)
--- old/src/names.c	2005-06-06 15:01:13.000000000 +0100
+++ alsa-lib-1.0.10/src/names.c	2005-12-02 23:32:26.000000000 +0000
@@ -31,7 +31,11 @@
  */
 
 #include <stdarg.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
 #include <dlfcn.h>
 #include <limits.h>
 #include <sys/stat.h>

--=-+IUpaflyBl42dowCXDt1--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
