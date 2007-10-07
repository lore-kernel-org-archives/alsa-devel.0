From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: Re: [patch] snd_pcm_drain and lock-ups
Date: Sun, 7 Oct 2007 13:40:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710071325420.1727@mgorse.dhs.org>
References: <Pine.LNX.4.64.0709121739280.26129@mgorse.dhs.org>
	<Pine.LNX.4.64.0709192041310.7949@mgorse.dhs.org>
	<Pine.LNX.4.61.0709211009490.8148@tm8103.perex-int.cz>
	<Pine.LNX.4.64.0709210637020.24213@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 5788E243FB
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Oct 2007 19:39:32 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0709210637020.24213@mgorse.dhs.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> >  I posted last week because I am getting lockups when portaudio calls
> >  snd_pcm_drain, and snd_pcm_rate_drain calls snd_pcm_wait on its slave.
> > 
> >  Now that I've looked at this more, I'm seeing that it involves dmix, 
> >  since
> >  a dmix plugin is behind the rate plugin.
> > 
> >  The dmix code in alsa-lib is setting a xrun state because
> >  snd_pcm_mmap_playback_avail returns a large value.
> > 
> >  snd_pcm_wait is then called on the slave of the rate pcm, which is a pcm
> >  with a type of SND_PCM_TYPE_ROUTE whose slave is the dmix, but the route
> >  pcm is returning a different value for snd_pcm_mmap_avail than the dmix
> >  pcm, so it is not triggering snd_pcm_wait to check for a xrun.
> >
>  I think that better fix is to change the code in snd_pcm_rate_drain(). You
>  can set avail_min to 1 there, so condition in snd_pcm_wait() will match.
>
>  Does this patch help?
>
>  diff -r 68d71239d651 src/pcm/pcm_rate.c
>  --- a/src/pcm/pcm_rate.c	Thu Sep 20 13:20:03 2007 +0200
>  +++ b/src/pcm/pcm_rate.c	Fri Sep 21 10:14:41 2007 +0200
> @@ -1076,10 +1076,10 @@ static int snd_pcm_rate_drain(snd_pcm_t
>    snd_pcm_uframes_t size, ofs, saved_avail_min;
>    snd_pcm_sw_params_t sw_params;
>
>  -		/* temporarily set avail_min to one period */
>  +		/* temporarily set avail_min to one */
>    sw_params = rate->sw_params;
>    saved_avail_min = sw_params.avail_min;
>  -		sw_params.avail_min = rate->gen.slave->period_size;
>  +		sw_params.avail_min = 1;
>    snd_pcm_sw_params(rate->gen.slave, &sw_params);
>
>    size = rate->appl_ptr - rate->last_commit_ptr;
>
>        Jaroslav

Unfortunately, I just discovered that this patch (now in alsa-lib 
1.0.15-rc3) does not always solve my problem.  It does most of the time, 
but snd_pcm_avail on the route occasionally returns 0, which is less than 
1, so once in a while I still get a lock-up.  I can't change the 1 to a 0 
in snd_pcm_drain since snd_pcm_sw_params aborts if sw_params->avail_min == 
0.

My original approach of checking for SND_PCM_TYPE_ROUTE in snd_pcm_wait() 
would still work.

It looks as though there is a buffer to fill which is included when 
snd_pcm_mmap_avail looks at the dmix pcm but not when it looks at the 
route in between the rate and the dmix.

-Mike G-
