From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: POSIX clocks and ALSA
Date: Tue, 4 Dec 2007 17:26:19 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712041718060.7670@tm8103.perex-int.cz>
References: <474A763E.7090001@cs.helsinki.fi>
	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
	<474A9A49.1030208@cs.helsinki.fi>
	<Pine.LNX.4.61.0711261548040.23163@tm8103.perex-int.cz>
	<474AEEA8.6090602@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6651610391A
	for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2007 17:26:20 +0100 (CET)
In-Reply-To: <474AEEA8.6090602@cs.helsinki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Heikki Lindholm <holindho@cs.helsinki.fi>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Nov 2007, Heikki Lindholm wrote:

> Jaroslav Kysela kirjoitti:
> > On Mon, 26 Nov 2007, Heikki Lindholm wrote:
> > 
> > > I had a look at the proposal and the thread at
> > > http://thread.gmane.org/gmane.linux.alsa.devel/45237/focus=45573
> > 
> > My initial implementation following proposal is bellow for review and
> > comments. I also changed timestamps for ALSA timers to use monotonic
> > clocks (can be switched back using a module parameter).
> > 
> > Jaroslav
> > 
> > diff -r 5e8cab953031 core/pcm_lib.c
> > --- a/core/pcm_lib.c	Mon Nov 26 09:00:56 2007 +0100
> <...>
> > diff -r 5e8cab953031 include/asound.h
> > --- a/include/asound.h	Mon Nov 26 09:00:56 2007 +0100
> > +++ b/include/asound.h	Mon Nov 26 15:02:57 2007 +0100
> > @@ -435,6 +435,13 @@ struct snd_xfern {
> > };
> > 
> > enum {
> > +	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
> > +	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY1,	/* for compatibility, equal to
> > zero */
> > +	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic
> > equivalent */
> > +	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,
> > +};
> 
> Looks good otherwise, but I'd still like to argue about this 
> compatibility point: compatibility with what exactly? When was 
> PCM_TSTAMP ioctl deprecated? Before 1.0.0? Has anyone *ever* used it? 

Looking at sources, we talking about a 0.9.0rc8 change.

> And so, is there any point in adding something not-so-pretty to a new 
> feature right from the start. Just declare legacy TSTAMP ioctl users 
> scr*wed! :)

This ioctl is used only by alsa-lib and the post 0.9.0rc8 code checks for 
PCM API version, so we should not have any problem except with the binary 
compatibility with 0.9.0rc libraries.

Ok, I'll remove GETTIMEOFDAY1 and commit code to HG tree.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
