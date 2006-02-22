From: Pierre Ossman <ossman@cendio.se>
Subject: Re: [RFC][PATCH] Transparent network support through
 polypaudio
Date: Wed, 22 Feb 2006 10:48:36 +0100
Message-ID: <43FC3374.2030701@cendio.se>
References: <43F09D76.9060004@cendio.se>	<43F61E6D.5020206@cendio.se>	<s5hirr8k7ra.wl%tiwai@suse.de>	<43FB420D.8010605@cendio.se> <s5hfymck6k3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000607030402000907070106"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5ECB61A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2006 10:48:40 +0100 (MET)
In-Reply-To: <s5hfymck6k3.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, mzcbylcnhqvb@0pointer.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000607030402000907070106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 21 Feb 2006 17:38:37 +0100,
> Pierre Ossman wrote:
>>
>> In case you missed it, I also opened a bug for the issue (I wasn't sure 
>> how your work flow is so I tried all venues ;)). The bug also contains 
>> an update not posted on the list:
>>
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1852
>>
>> I can generate a diff for you once the anon CVS is updated.
> 
> Yes, that'll be helpful.
> 
> I have currently very little time to look at ALSA MLs and BTS, so
> please add me to Cc at the next update.
> 
> 

It seems your BTS cannot add cc:s, so I'll send you the diff here.

There shouldn't be any more API changes until polypaudio 0.8 that affect 
this plugin. I am working on supporting capture volume and mute 
switches, but that should be a strict addition (i.e. it can wait until 
the next release if things get tight).

-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com

--------------000607030402000907070106
Content-Type: text/x-patch;
 name="polyp-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="polyp-update.patch"

? alsa-plugins-1.0.10.tar.bz2
? alsa-plugins-1.0.10.tar.gz
? polyp-update.patch
Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/configure.in,v
retrieving revision 1.13
diff -u -r1.13 configure.in
--- configure.in	21 Feb 2006 16:13:57 -0000	1.13
+++ configure.in	22 Feb 2006 09:44:47 -0000
@@ -15,7 +15,7 @@
 PKG_CHECK_MODULES(JACK, jack >= 0.98, [HAVE_JACK=yes], [HAVE_JACK=no])
 AM_CONDITIONAL(HAVE_JACK, test x$HAVE_JACK = xyes)
 
-PKG_CHECK_MODULES(polypaudio, [polyplib polyplib-mainloop], [HAVE_POLYP=yes], [HAVE_POLYP=no])
+PKG_CHECK_MODULES(polypaudio, [polyplib], [HAVE_POLYP=yes], [HAVE_POLYP=no])
 AM_CONDITIONAL(HAVE_POLYP, test x$HAVE_POLYP = xyes)
 
 SAVE_PLUGINS_VERSION
Index: polyp/pcm_polyp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/pcm_polyp.c,v
retrieving revision 1.1
diff -u -r1.1 pcm_polyp.c
--- polyp/pcm_polyp.c	21 Feb 2006 16:14:00 -0000	1.1
+++ polyp/pcm_polyp.c	22 Feb 2006 09:44:47 -0000
@@ -210,7 +210,7 @@
 
 	buf = (char *)areas->addr + (areas->first + areas->step * offset) / 8;
 
-    pa_stream_write(pcm->stream, buf, size * pcm->frame_size, NULL, 0);
+    pa_stream_write(pcm->stream, buf, size * pcm->frame_size, NULL, 0, 0);
 
     /* Make sure the buffer pointer is in sync */
     update_ptr(pcm);
@@ -245,7 +245,7 @@
 
 	dst_buf = (char *)areas->addr + (areas->first + areas->step * offset) / 8;
     while (remain_size > 0) {
-        pa_stream_peek(pcm->stream, (void**)&src_buf, &frag_length);
+        pa_stream_peek(pcm->stream, (const void**)&src_buf, &frag_length);
         if (frag_length == 0)
             break;
 
@@ -352,7 +352,7 @@
     assert(pcm->stream);
 
     if (io->stream == SND_PCM_STREAM_PLAYBACK)
-        pa_stream_connect_playback(pcm->stream, pcm->device, &pcm->buffer_attr, 0, NULL);
+        pa_stream_connect_playback(pcm->stream, pcm->device, &pcm->buffer_attr, 0, NULL, NULL);
     else
         pa_stream_connect_record(pcm->stream, pcm->device, &pcm->buffer_attr, 0);
 
Index: polyp/polyp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/polyp.c,v
retrieving revision 1.1
diff -u -r1.1 polyp.c
--- polyp/polyp.c	21 Feb 2006 16:14:00 -0000	1.1
+++ polyp/polyp.c	22 Feb 2006 09:44:47 -0000
@@ -234,7 +234,7 @@
 
     assert(p && p->context && p->mainloop && (p->state == POLYP_STATE_INIT));
 
-    err = pa_context_connect(p->context, server, 1, NULL);
+    err = pa_context_connect(p->context, server, 0, NULL);
     if (err < 0)
         goto error;
 

--------------000607030402000907070106--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
