From: "Andreas Falkenhahn" <andreas@airsoftsoftwair.de>
Subject: Re: Playing multiple sounds at the same time
Date: Fri, 30 Apr 2010 14:36:39 +0200
Message-ID: <cdd08247637958f4a6f89c21585dc75b-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAF1RQ1xdLkQAWFhfQ1hcUQE=-webmailer2@server07.webmailer.hosteurope.de>
References: <4411e1854e5de844b0cf28262efd5992-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFJQQ1lcLkQAWFhfQltcWgE=-webmailer2@server02.webmailer.hosteurope.de>
	<20100430104308.GE21607@sirena.org.uk>
Reply-To: andreas@airsoftsoftwair.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perry.mc0.hosteurope.de (perry.mc0.hosteurope.de [80.237.138.8])
	by alsa0.perex.cz (Postfix) with ESMTP id D1B4124490
	for <Alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 14:36:39 +0200 (CEST)
Received: from server07.webmailer.hosteurope.de ([10.9.0.186]);
	by mailout.hosteurope.de (perry.mc0.hosteurope.de) running EXperimental
	Internet Mailer with esmtps (TLSv1:AES256-SHA:256)
	id 1O7pTm-0007ah-Rk
	for Alsa-devel@alsa-project.org; Fri, 30 Apr 2010 14:38:02 +0200
Received: from nobody by server07.webmailer.hosteurope.de with local (Exim
	4.69) (envelope-from <andreas@airsoftsoftwair.de>)
	id 1O7pSR-0006lp-4v
	for Alsa-devel@alsa-project.org; Fri, 30 Apr 2010 14:36:39 +0200
In-Reply-To: <20100430104308.GE21607@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> On Fri, Apr 30, 2010 at 12:38:49PM +0200, Andreas Falkenhahn wrote:
>
>> Now I want to play sounds 1 to 3 at the same time. My question is now:
>> Can
>> ALSA do automatic mixing for me here or do I have to do the mixing on my
>> own? In other words, can I simply feed all these three sound streams to
>> ALSA or do I have to mix them into a fourth audio stream first and
>> feeding
>> this new fourth stream to ALSA then?
>
> The easiest thing for your application is to just open and play multiple
> audio streams and allow a system mixing daemon such as PulseAudio to
> take care of the mixing.

Thanks, that sounds easy enough.

I have some more questions... I hope I don't annoy anyone but the API
documentation of ALSA is extremely brief and the tutorials I was able to
find via Google only deal with the most simple case, i.e. just playing a
stream and exiting.

So before I start implementing my sound backend in a totally wrong way,
I'd be thankful if one of the experts here could tell me if it could be
done like I'm planning it or not.

So here's my proposed implementation for playing multiple sounds at the
same time with ALSA:

1) Launch a new thread that will now act as my sound manager

2) For each new sound to be played, call snd_pcm_open() with mode set to
SND_PCM_NONBLOCK. Then set the parameters on this stream to match the
format of the sound to be played.

3) Now loop over all sounds currently playing and consecutively feed data
to their respective PCM streams using calls to snd_pcm_writei(). Check the
return value of snd_pcm_writei() to see how many frames could be written
to the stream, then feed the rest until there is no more data left or feed
again from the beginning in case the sound should be looped.

Well, this would be the outline of my planned implementation. Could it be
done this way or is there a better way?

Thanks,

Andreas
