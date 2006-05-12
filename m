From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Correction for fixing alsa-lib static build (patch attached)
Date: Fri, 12 May 2006 14:09:09 +0200
Message-ID: <44647AE5.9060202@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010300020102050707040105"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010300020102050707040105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi!

While trying to compile the alsa library static, without dynamic lib at
all, I encountered an error with two symbols being unresolved.

The attached patch corrects the compile errors when doing a standard
configure and build. I haven't disabled or enabled anything else than
what is compiled in by default.

Please comment if my patch breaks the library or similar.

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway

--------------010300020102050707040105
Content-Type: text/x-patch;
 name="alsa-lib-1.0.11-fix-static-linking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-1.0.11-fix-static-linking.patch"

--- alsa-lib-1.0.11.orig/src/pcm/pcm_ioplug.c	2005-06-28 12:24:45.000000000 +0200
+++ alsa-lib-1.0.11/src/pcm/pcm_ioplug.c	2006-05-12 10:53:00.000000000 +0200
@@ -30,6 +30,9 @@
 #include "pcm_ioplug.h"
 #include "pcm_ext_parm.h"
 
+/* entry for static linking */
+const char *_snd_module_pcm_ioplug = "";
+
 #ifndef DOC_HIDDEN
 
 /* hw_params */
--- alsa-lib-1.0.11.orig/src/pcm/pcm_extplug.c	2006-03-21 11:30:44.000000000 +0100
+++ alsa-lib-1.0.11/src/pcm/pcm_extplug.c	2006-05-12 10:53:23.000000000 +0200
@@ -31,6 +31,9 @@
 #include "pcm_extplug.h"
 #include "pcm_ext_parm.h"
 
+/* entry for static linking */
+const char *_snd_module_pcm_extplug = "";
+
 #ifndef DOC_HIDDEN
 
 typedef struct snd_pcm_extplug_priv {

--------------010300020102050707040105--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
