From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] fixes warning of missing initializers for *.poll_revents
Date: Mon, 19 Apr 2004 22:26:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040419202638.GA18386@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


This bunch of patches fixes compiler warnings like these one:
pcm_multi.c:646: warning: missing initializer
pcm_multi.c:646: warning: (near initialization for
snd_pcm_multi_ops.poll_revpcm_shm.c:589: warning: missing initializer  for
snd_pcm_multi_ops.poll_revents')

But perhaps more interesting values than NULL are prefered.... Please review 
before applying it.

martin



Index: alsa-lib/src/pcm/pcm_hooks.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_hooks.c,v
retrieving revision 1.32
diff -u -r1.32 pcm_hooks.c
--- alsa-lib/src/pcm/pcm_hooks.c	17 Mar 2004 11:48:15 -0000	1.32
+++ alsa-lib/src/pcm/pcm_hooks.c	19 Apr 2004 20:14:28 -0000
@@ -305,6 +305,7 @@
 	.dump = snd_pcm_hooks_dump,
 	.nonblock = snd_pcm_hooks_nonblock,
 	.async = snd_pcm_hooks_async,
+	.poll_revents = NULL,
 	.mmap = snd_pcm_hooks_mmap,
 	.munmap = snd_pcm_hooks_munmap,
 };
Index: alsa-lib/src/pcm/pcm_meter.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_meter.c,v
retrieving revision 1.44
diff -u -r1.44 pcm_meter.c
--- alsa-lib/src/pcm/pcm_meter.c	17 Mar 2004 11:48:15 -0000	1.44
+++ alsa-lib/src/pcm/pcm_meter.c	19 Apr 2004 20:14:48 -0000
@@ -609,6 +609,7 @@
 	.dump = snd_pcm_meter_dump,
 	.nonblock = snd_pcm_meter_nonblock,
 	.async = snd_pcm_meter_async,
+	.poll_revents = NULL,
 	.mmap = snd_pcm_meter_mmap,
 	.munmap = snd_pcm_meter_munmap,
 };
Index: alsa-lib/src/pcm/pcm_multi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_multi.c,v
retrieving revision 1.87
diff -u -r1.87 pcm_multi.c
--- alsa-lib/src/pcm/pcm_multi.c	17 Mar 2004 11:48:15 -0000	1.87
+++ alsa-lib/src/pcm/pcm_multi.c	19 Apr 2004 20:15:00 -0000
@@ -641,6 +641,7 @@
 	.dump = snd_pcm_multi_dump,
 	.nonblock = snd_pcm_multi_nonblock,
 	.async = snd_pcm_multi_async,
+	.poll_revents = NULL,
 	.mmap = snd_pcm_multi_mmap,
 	.munmap = snd_pcm_multi_munmap,
 };
Index: alsa-lib/src/pcm/pcm_null.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_null.c,v
retrieving revision 1.50
diff -u -r1.50 pcm_null.c
--- alsa-lib/src/pcm/pcm_null.c	17 Mar 2004 11:48:15 -0000	1.50
+++ alsa-lib/src/pcm/pcm_null.c	19 Apr 2004 20:15:12 -0000
@@ -324,6 +324,7 @@
 	.dump = snd_pcm_null_dump,
 	.nonblock = snd_pcm_null_nonblock,
 	.async = snd_pcm_null_async,
+	.poll_revents = NULL,
 	.mmap = snd_pcm_null_mmap,
 	.munmap = snd_pcm_null_munmap,
 };
Index: alsa-lib/src/pcm/pcm_share.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_share.c,v
retrieving revision 1.79
diff -u -r1.79 pcm_share.c
--- alsa-lib/src/pcm/pcm_share.c	17 Mar 2004 11:48:15 -0000	1.79
+++ alsa-lib/src/pcm/pcm_share.c	19 Apr 2004 20:15:30 -0000
@@ -1274,6 +1274,7 @@
 	.dump = snd_pcm_share_dump,
 	.nonblock = snd_pcm_share_nonblock,
 	.async = snd_pcm_share_async,
+	.poll_revents = NULL,
 	.mmap = snd_pcm_share_mmap,
 	.munmap = snd_pcm_share_munmap,
 };
Index: alsa-lib/src/pcm/pcm_shm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_shm.c,v
retrieving revision 1.60
diff -u -r1.60 pcm_shm.c
--- alsa-lib/src/pcm/pcm_shm.c	17 Mar 2004 11:48:15 -0000	1.60
+++ alsa-lib/src/pcm/pcm_shm.c	19 Apr 2004 20:15:48 -0000
@@ -584,6 +584,7 @@
 	.dump = snd_pcm_shm_dump,
 	.nonblock = snd_pcm_shm_nonblock,
 	.async = snd_pcm_shm_async,
+	.poll_revents = NULL,
 	.mmap = snd_pcm_shm_mmap,
 	.munmap = snd_pcm_shm_munmap,
 };


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
