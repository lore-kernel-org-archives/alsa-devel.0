From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: Re: [patch] snd_pcm_drain and lock-ups
Date: Mon, 8 Oct 2007 12:34:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710081224260.27243@mgorse.dhs.org>
References: <Pine.LNX.4.64.0709121739280.26129@mgorse.dhs.org>
	<Pine.LNX.4.64.0709192041310.7949@mgorse.dhs.org>
	<Pine.LNX.4.61.0709211009490.8148@tm8103.perex-int.cz>
	<Pine.LNX.4.64.0709210637020.24213@mgorse.dhs.org>
	<Pine.LNX.4.64.0710071325420.1727@mgorse.dhs.org>
	<Pine.LNX.4.61.0710072020360.13710@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alnrmhc13.comcast.net (alnrmhc13.comcast.net [206.18.177.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B778244C6
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Oct 2007 18:32:53 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0710072020360.13710@tm8103.perex-int.cz>
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

On Sun, 7 Oct 2007, Jaroslav Kysela wrote:

>>>> I am getting lockups when portaudio
>>>> calls
>>>> snd_pcm_drain, and snd_pcm_rate_drain calls snd_pcm_wait on its
>>>> slave.
>>>>
>>>> Now that I've looked at this more, I'm seeing that it involves
>>>> dmix, since
>>>> a dmix plugin is behind the rate plugin.
>>>>
>>>> The dmix code in alsa-lib is setting a xrun state because
>>>> snd_pcm_mmap_playback_avail returns a large value.
>>>>
>>>> snd_pcm_wait is then called on the slave of the rate pcm, which is
>>>> a pcm
>>>> with a type of SND_PCM_TYPE_ROUTE whose slave is the dmix, but the
>>>> route
>>>> pcm is returning a different value for snd_pcm_mmap_avail than the
>>>> dmix
>>>> pcm, so it is not triggering snd_pcm_wait to check for a xrun.
>>>>

...

> I think we're looking bug on wrong place. If dmix is in XRUN state,
> snd_pcm_poll_descriptors_revents() should return POLLERR, thus the check
> for XRUN should be done in snd_pcm_wait_nocheck() after revents checking.
>
> Could you trace what occurs in your scenario in snd_pcm_wait_nocheck() ?

Looking at the code suggests that snd_pcm_poll_descriptors_revents would 
return POLLERR if it ever got called, but it isn't called because poll() 
would have to return first, and it doesn't.

Thanks,
-Mike
