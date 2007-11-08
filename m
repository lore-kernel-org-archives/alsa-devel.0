From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: issues with pulse plugin
Date: Thu, 8 Nov 2007 17:21:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711081709350.19354@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA05.westchester.pa.mail.comcast.net
	(qmta05.westchester.pa.mail.comcast.net [76.96.62.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 23CBE243C8
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 23:22:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have run into what is basically another instance of bug 3470 
(pulse_hw_params asserting because the stream is already initialized). 
The application that I am working with is calling snd_pcm_hw_params each 
time it plays a sample.  The following patch makes things work for me 
(actually the app still doesn't work because it uses poll() in a way that 
is incompatible with the pulse plugin, but that is a separate issue, and I 
don't know if it should be considered a bug in the plugin.)

--- pulse/pcm_pulse.c.orig	2007-11-08 15:13:12.000000000 -0500
+++ pulse/pcm_pulse.c	2007-11-08 15:13:12.000000000 -0500
@@ -497,7 +497,7 @@
      assert(pcm->p);

      //Resolving bugtrack ID 0003470
-    if(!(base && snd_pcm_state(base) == SND_PCM_STATE_PREPARED))
+    if(!(base && (snd_pcm_state(base) == SND_PCM_STATE_PREPARED || snd_pcm_state(base) == SND_PCM_STATE_SETUP)))
      	assert(!pcm->stream);

      pa_threaded_mainloop_lock(pcm->p->mainloop);

--

I couldn't add this to the bug because it was marked as resolved.

Any comments?  Or is the app behaving in a way that is counter to the 
specification?

Also, I'm still encountering bug 2601 (a separate assert failure that 
happens if period_size == 0) even with the patch to pcm_ioplug.c.  I think 
that PERIOD_TIME and PERIODS need to be constrained; I added a couple of 
comments to the bug.

Thanks,

-- Mike Gorse / AIM:linvortex / http://mgorse.freeshell.org --
