From: Dave Maley <dmaley@nc.rr.com>
Subject: [patch] problem w/ arecord "split interleaved files" feature
Date: Tue, 25 Apr 2006 01:43:24 -0400
Message-ID: <1145943804.2670.43.camel@flanders>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-5oVHcnEVJ0S4W9Ij3TLC"
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


--=-5oVHcnEVJ0S4W9Ij3TLC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

My first post to the alsa-devel list, and I'm not subscribed so please
cc: me directly on any responses ...  This is in reference to a patch
which was incorporated into alsa-utils-1.0.11, originally posted here:

http://thread.gmane.org/gmane.linux.alsa.devel/29025/focus=29098

The max_filesize for wave files as currently implemented it's actually
splitting files a good bit before reaching 2GB.

A little background as to why this matters (to me at least).  I use
arecord to transfer DAT's to my computer, and many of these DAT's are 3
hours in length.  So for this I'd typically do something to the effect
of:


[dave@flanders ~]$ arecord -t wav -f dat -d 10800 foo.wav


Since max_filesize is set to 2000000000 arecord splits the resulting
file a bit over 170 minutes.  Not a huge problem, except I pipe the
above command to sox for down-sampling to 44.1KHz:


[dave@flanders ~]$ arecord -q -t wav -f dat -d 10800 | sox -t wav -r
48000 -c 2 - -t wav -r 44100 -c 2 foo.wav resample


It seems this new split feature doesn't work properly when writing to a
pipe (or at least when piping to sox).  A quick look at an strace shows
constant write errors, and foo.wav grows in size until the disk is full.

A quick fix for this is to set max_filesize to 2147483648.  Not sure if
this is a "proper" fix however I have tested it and it seems to work
just fine for me.  Please consider the attached patch.

Thanks,
Dave

--=-5oVHcnEVJ0S4W9Ij3TLC
Content-Disposition: attachment; filename=arecord_split.patch
Content-Type: text/x-patch; name=arecord_split.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- alsa-utils-1.0.11/aplay/aplay.c.orig	2006-04-25 01:37:13.000000000 -0400
+++ alsa-utils-1.0.11/aplay/aplay.c	2006-04-25 01:38:24.000000000 -0400
@@ -128,7 +128,7 @@
 } fmt_rec_table[] = {
 	{	NULL,		end_raw,	N_("raw data"),		LLONG_MAX },
 	{	begin_voc,	end_voc,	N_("VOC"),		16000000 },
-	{	begin_wave,	end_wave,	N_("WAVE"),		2000000000 },
+	{	begin_wave,	end_wave,	N_("WAVE"),		2147483648 },
 	{	begin_au,	end_au,		N_("Sparc Audio"),	LLONG_MAX }
 };
 

--=-5oVHcnEVJ0S4W9Ij3TLC--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
