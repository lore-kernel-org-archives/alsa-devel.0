From: Chris Brookes <chris@txrx.org>
Subject: alsa cvs (06-26-2003) compiling against uclibc ...
Date: 26 Jun 2003 17:12:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1056665557.24737.34.camel@packet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-uxJI3FK1mZ0PzOKNGUOH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-uxJI3FK1mZ0PzOKNGUOH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm trying to get a current CVS pull of alsa-lib compiled against
UCLIBC. It's not going so well. The first problem is that uclibc doesn't
have the wordexp function used in conf.c and pcm_ladspa.c ... I managed
to get a patch from the uclibc maintainer that replaced the wordexp
function with a glob function. This does make alsa-lib compile, and if
you make sure alsa.conf doesn't have a tilde in it, it seems to run ok.

I have a test MP3 file and a test movie file. The mp3 file (played back
with 0.90 version of mplayer) plays back fine:

Checking audio filter chain for 44100Hz/2ch/16bit ->
44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int 
AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
(Little-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa9: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa9] 44100Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 44100Hz/2ch/16bit ->
44100Hz/2ch/16bit...
Video: no video
Starting playback...

The movie file, with -vo null plays audio back ok:

chChecking audio filter chain for 44100Hz/2ch/16bit
->44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int 
AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
audio_setup: Can't open audio device /dev/dsp: No such device
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
(Little-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa9: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa9] 44100Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 44100Hz/2ch/16bit ->
44100Hz/2ch/16bit...
Starting playback...

The same movie file played back with video fails (see comments after, I
know this seems like a faq) like this: 

Checking audio filter chain for 44100Hz/2ch/16bit ->
44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int 
AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
(Little-Endian)
alsa-init: 1 soundcard found, using: hw:0,0
ALSA lib conf.c:2658:(snd_config_hooks_call) Cannot open shared library
(null)
ALSA lib conf.c:3120:(snd_config_update_r) hooks failed, removing
configuration
alsa-init: playback open error: No such file or directory
Could not open/initialize audio device -> no sound.
Audio: no sound
Starting playback...

I can't help but thinking the replaced wordexp function is causing some
subtle error which is causing this to fail... ?

I've tried to walk through conf.c and even popped in a few printfs to
see what's going on, but to be honest my C knowledge isn't up to getting
through a codebase like this.. 

The patch I use is below. I started with it on the release 0.9.4
version, and then moved on to trying it with the current CVS, up to
todays.

My system comprises kernel 2.4.21-ac2, and the soundcard uses the
snd-via82xx module.

If anyone has any suggestions I'd really appreciate them, even if
they're just RTFM. I've spent  hours and hours to get this far and I'm
afraid I'm at the point where if the answer to the last hurdle was
staring me in the face, I probably wouldnt see it. 


regards,
Chris













--=-uxJI3FK1mZ0PzOKNGUOH
Content-Disposition: attachment; filename=alsa-lib-uclibc.patch
Content-Type: text/x-patch; name=alsa-lib-uclibc.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -urN alsa-lib-0.9.4/src/conf.c alsa-lib-0.9.4.patched/src/conf.c
--- alsa-lib-0.9.4/src/conf.c	2003-04-23 03:01:07.000000000 -0500
+++ alsa-lib-0.9.4.patched/src/conf.c	2003-06-25 15:09:38.000000000 -0500
@@ -415,7 +415,12 @@
 
 
 #include <stdarg.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
+ 
 #include <dlfcn.h>
 #include <limits.h>
 #include <sys/stat.h>
@@ -2780,7 +2785,9 @@
 				goto _err;
 			}
 			if (i == idx) {
+#ifdef HAS_WORDEXP
 				wordexp_t we;
+
 				char *name;
 				if ((err = snd_config_get_ascii(n, &name)) < 0)
 					goto _err;
@@ -2799,6 +2806,28 @@
 				}
 				fi[idx].name = strdup(we.we_wordv[0]);
 				wordfree(&we);
+#else
+                               glob_t globbuf;
+                               char *name;
+                               if ((err = snd_config_get_ascii(n, &name)) < 0)
+                                       goto _err;
+                               err = glob(name, 0, NULL, &globbuf);
+                               switch (err) {
+                               case GLOB_NOSPACE:
+                                       err = -ENOMEM;
+                                       goto _err;
+                               case 0:
+                                       if (globbuf.gl_pathc == 1)
+                                               break;
+                                       /* Fall through */
+                               default:
+                                       err = -EINVAL;
+					goto _err;
+                               }
+                               fi[idx].name = strdup(globbuf.gl_pathv[0]);
+                               globfree(&globbuf);
+#endif
+
 				free(name);
 				if (fi[idx].name == NULL) {
 					err = -ENOMEM;
@@ -2924,7 +2953,12 @@
 	int err;
 	const char *configs, *c;
 	unsigned int k;
-	wordexp_t we;
+#ifdef HAS_WORDEXP
+        wordexp_t we;
+#else
+       glob_t globbuf;
+#endif
+	        
 	size_t l;
 	snd_config_update_t *local;
 	snd_config_update_t *update;
@@ -2963,6 +2997,7 @@
 		char name[l + 1];
 		memcpy(name, c, l);
 		name[l] = 0;
+#ifdef HAS_WORDEXP
 		err = wordexp(name, &we, WRDE_NOCMD);
 		switch (err) {
 		case WRDE_NOSPACE:
@@ -2978,6 +3013,24 @@
 		}
 		local->finfo[k].name = strdup(we.we_wordv[0]);
 		wordfree(&we);
+#else
+               err = glob(name, 0, NULL, &globbuf);
+               switch (err) {
+               case GLOB_NOSPACE:
+                       err = -ENOMEM;
+                       goto _end;
+               case 0:
+                       if (globbuf.gl_pathc == 1)
+                               break;
+                       /* Fall through */
+               default:
+                       err = -EINVAL;
+                       goto _end;
+               }
+               local->finfo[k].name = strdup(globbuf.gl_pathv[0]);
+               globfree(&globbuf);
+#endif
+
 		if (!local->finfo[k].name) {
 			err = -ENOMEM;
 			goto _end;
diff -urN alsa-lib-0.9.4/src/pcm/pcm_ladspa.c alsa-lib-0.9.4.patched/src/pcm/pcm_ladspa.c
--- alsa-lib-0.9.4/src/pcm/pcm_ladspa.c	2003-02-11 12:14:47.000000000 -0600
+++ alsa-lib-0.9.4.patched/src/pcm/pcm_ladspa.c	2003-06-25 15:10:09.000000000 -0500
@@ -28,7 +28,12 @@
   
 #include <dirent.h>
 #include <dlfcn.h>
+#ifdef HAS_WORDEXP
 #include <wordexp.h>
+#else
+#include <glob.h>
+#endif
+ 
 #include "pcm_local.h"
 #include "pcm_plugin.h"
 
@@ -792,14 +797,21 @@
 {
 	const char *c;
 	size_t l;
-	wordexp_t we;
+#ifdef HAS_WORDEXP
+	      wordexp_t we;
+#else
+	      glob_t globbuf;
+#endif
+	        
 	int err;
 	
 	for (c = path; (l = strcspn(c, ": ")) > 0; ) {
 		char name[l + 1];
 		memcpy(name, c, l);
 		name[l] = 0;
+#ifdef HAS_WORDEXP
 		err = wordexp(name, &we, WRDE_NOCMD);
+		
 		switch (err) {
 		case WRDE_NOSPACE:
 			return -ENOMEM;
@@ -812,6 +824,21 @@
 		}
 		err = snd_pcm_ladspa_check_dir(plugin, we.we_wordv[0], label, ladspa_id);
 		wordfree(&we);
+#else
+               err = glob(name, 0, NULL, &globbuf);
+               switch (err) {
+               case GLOB_NOSPACE:
+                       return -ENOMEM;
+               case 0:
+                       if (globbuf.gl_pathc == 1)
+                               break;
+                       /* Fall through */
+               default:
+                       return -EINVAL;
+               }
+               err = snd_pcm_ladspa_check_dir(plugin, globbuf.gl_pathv[0], label, ladspa_id);
+               globfree(&globbuf);
+#endif
 		if (err < 0)
 			return err;
 		if (err > 0)

--=-uxJI3FK1mZ0PzOKNGUOH--



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
