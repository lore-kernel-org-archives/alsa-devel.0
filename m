From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: Digital sound card conventions
Date: Sun, 5 Jan 2003 15:44:42 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301051535280.500-100000@pnote.perex-int.cz>
References: <20030103213948.169F659D307@kerberos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA12228
	for <alsa-devel@alsa-project.org>; Sun, 5 Jan 2003 15:45:24 +0100
In-Reply-To: <20030103213948.169F659D307@kerberos.suse.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Anders Torger <torger@ludd.luth.se>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Jan 2003, Paul Davis wrote:

> >This part of PCM API has not been discussed. I think that we should follow
> >the most easy way: It is - allow only sample rate given by application, if
> >the master clock is using another sample rate - in trigger() callback -
> >driver will fail. 
> 
> this seems wrong to me. what should fail is an attempt to set the
> sample rate unless the hardware is its own clock Master. if no attempt
> is made to set it, then the application gets whatever the hardware is
> running at, whether that is externally controlled or some h/w specific
> default. 

I think that it's wrong when application receives stream with another
parameters than requested. Imagine that you're doing a software sample
rate conversion and we really need to know the exact rate for this job.

So my suggestion is:

1) offer all available sample rates in open() or reduce them as suggested
   by Anders
2) in trigger(START)
   - check if current sample rate match with hw_params - if not - fail
3) in interrupt callback
   - same job as trigger does

Note that we have to implement this algorithm also for playback, because 
it can use external timing as well.

> >		   Also it will fail, when sample rate is changed during
> >operation. 
> 
> the hammerfall driver used to contain stubs for doing this. every
> read/write operation would check that the (possibly externally
> controlled) SR was the same as "last time". i never did any more on this.
> 
> >	    We probably need to add a new PCM state -
> >SNDRV_PCM_STATE_STREAM_CHANGED (equal to DRAINING, but informative for
> >applications). The notification of master clock / sample rate (or other
> >parameter) changes should be implemented using the control API.
> 
> and already is for some cards (and some parameters).

Yes, I know.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
