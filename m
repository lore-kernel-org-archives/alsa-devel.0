From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-lib: SND_PCM_TSTAMP_MMAP ->
 SND_PCM_TSTAMP_ENABLE change
Date: Fri, 11 Jan 2008 09:35:08 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801110927130.30240@tm8103.perex-int.cz>
References: <ALOGGER1200038051.38@alsa-project.org>
	<1200039692.19596.1230661259@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A0CED243F8
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 09:35:09 +0100 (CET)
In-Reply-To: <1200039692.19596.1230661259@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Jan 2008, Clemens Ladisch wrote:

> Jaroslav Kysela wrote:
> > description:
> > SND_PCM_TSTAMP_MMAP -> SND_PCM_TSTAMP_ENABLE change
> > 
> > diff -r 3c87e22e70d8 -r 2519fcd54901 include/pcm.h
> > --- a/include/pcm.h	Thu Jan 10 10:01:14 2008 +0100
> > +++ b/include/pcm.h	Fri Jan 11 08:54:07 2008 +0100
> > @@ -281,9 +281,9 @@
> >  typedef enum _snd_pcm_tstamp {
> >  	/** No timestamp */
> >  	SND_PCM_TSTAMP_NONE = 0,
> > -	/** Update mmap'ed timestamp */
> > -	SND_PCM_TSTAMP_MMAP,
> > -	SND_PCM_TSTAMP_LAST = SND_PCM_TSTAMP_MMAP
> > +	/** Update timestamp at every hardware position update */
> > +	SND_PCM_TSTAMP_ENABLE,
> > +	SND_PCM_TSTAMP_LAST = SND_PCM_TSTAMP_ENABLE
> >  } snd_pcm_tstamp_t;
> 
> This change breaks backward compatibility.
> The v19-devel branch of PortAudio uses SND_PCM_TSTAMP_MMAP.

It's no problem to add SND_PCM_TSTAMP_MMAP as alias to 
SND_PCM_TSTAMP_ENABLE back. But I think that it would be better to let 
developers using SND_PCM_TSTAMP_MMAP realize that something was changed.

Binary compatibility is kept.

Note that SND_PCM_TSTAMP_MMAP is also quite unusable without 
new snd_pcm_htimestamp() function and support for monotonic timestamps in 
the latest driver/library code.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
