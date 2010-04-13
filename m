From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: alsa-lib pcm_share.c snd_pcm_share_open() bug ?
Date: Tue, 13 Apr 2010 12:33:11 -0400
Message-ID: <20100413163311.GB14240@Krystal>
References: <20100409150303.GA1128@Krystal> <s5hmxx794dj.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1004131007490.16336@eeebox2.perex-int.cz>
	<s5hiq7v9367.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blackscsi.openrapids.net (mail.openrapids.net [64.15.138.104])
	by alsa0.perex.cz (Postfix) with ESMTP id 910F0248E3
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 18:33:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiq7v9367.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

* Takashi Iwai (tiwai@suse.de) wrote:
> At Tue, 13 Apr 2010 10:10:02 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Tue, 13 Apr 2010, Takashi Iwai wrote:
> > 
> > > At Fri, 9 Apr 2010 11:03:03 -0400,
> > > Mathieu Desnoyers wrote:
> > >>
> > >> Hi,
> > >>
> > >> I was looking at snd_pcm_share_open() in alsa-lib-1.0.22, and stumbled on the
> > >> following line:
> > >>
> > >>         pcm->monotonic = pcm->monotonic;
> > >>
> > >> what is that supposed to do ? There is clearly something wrong there.
> > >
> > > Yeah, very fishy here.
> > >
> > > I suppose this plugin can't handle monotonic time as is.
> > > Jaroslav, could you fix that?
> > 
> > The plugin can handle the monotonic clock as well. The correct line should 
> > be:
> > 
> >  	pcm->monotonic = slave->pcm->monotonic;
> 
> Ah indeed.  It's a so complex code that is barely used ;)
> 

Actually, I ran into this code because I was grepping for "monotonic" field
modifications. It's indeed not run on my setup. However, what I experience is
the following problem:

I instrumented the xrun() handler from aplay/aplay.c so I could study buffer
underruns with the kernel trace with LTTng. Was I noticed is that the underrun
error message returns a bogus underrun duration value because aplay is in
"monotonic" time mode, but alsa-lib returned to non-monotonic mode (but it
detects the monotonic clock upon initial setup).

Quick test code (that also forces the gettimestamp "monotonic" to 1 (locally)).

Finding out where the value is brought back to 0 might involve poking in the lib
code with printf (sorry, I don't currently have the time required to do it
myself).

Thanks,

Mathieu

Index: alsa-lib-1.0.22/src/pcm/pcm_hw.c
===================================================================
--- alsa-lib-1.0.22.orig/src/pcm/pcm_hw.c	2010-04-09 10:33:44.000000000 -0400
+++ alsa-lib-1.0.22/src/pcm/pcm_hw.c	2010-04-09 10:43:49.000000000 -0400
@@ -1208,6 +1208,7 @@
 	pcm->poll_fd = fd;
 	pcm->poll_events = info.stream == SND_PCM_STREAM_PLAYBACK ? POLLOUT : POLLIN;
 	pcm->monotonic = monotonic;
+	printf("test is mono %d\n", monotonic);
 
 	ret = snd_pcm_hw_mmap_status(pcm);
 	if (ret < 0) {
Index: alsa-lib-1.0.22/src/pcm/pcm_local.h
===================================================================
--- alsa-lib-1.0.22.orig/src/pcm/pcm_local.h	2010-04-09 10:31:12.000000000 -0400
+++ alsa-lib-1.0.22/src/pcm/pcm_local.h	2010-04-09 11:04:38.000000000 -0400
@@ -952,6 +952,8 @@
 static inline void gettimestamp(snd_htimestamp_t *tstamp, int monotonic)
 {
 #if defined(HAVE_CLOCK_GETTIME) && defined(CLOCK_MONOTONIC)
+	printf("ismonotonic %d\n", monotonic);
+	monotonic = 1;
 	if (monotonic) {
 		clock_gettime(CLOCK_MONOTONIC, tstamp);
 	} else {
Index: alsa-lib-1.0.22/src/pcm/pcm_file.c
===================================================================
--- alsa-lib-1.0.22.orig/src/pcm/pcm_file.c	2010-04-09 10:33:40.000000000 -0400
+++ alsa-lib-1.0.22/src/pcm/pcm_file.c	2010-04-09 10:45:27.000000000 -0400
@@ -785,6 +785,7 @@
 #else
 	pcm->monotonic = 0;
 #endif
+
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	*pcmp = pcm;


> 
> thanks,
> 
> Takashi

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
