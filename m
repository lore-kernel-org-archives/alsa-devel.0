From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: Re: snd-hda-intel,
	AD 1988b: SPDIF output not working correctly,
	volume low for analog output
Date: Tue, 24 Jul 2007 17:58:12 +0200
Message-ID: <200707241758.13530.ml_alsa@mortal-soul.de>
References: <200707170832.01976.ml_alsa@mortal-soul.de>
	<200707232302.58778.ml_alsa@mortal-soul.de>
	<s5h4pjuyt5s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 1652910384A
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 17:57:59 +0200 (CEST)
In-Reply-To: <s5h4pjuyt5s.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 24 July 2007 12:47:59 Takashi Iwai wrote:

> Maybe some apps change the IEC958 status bits and doesn't restore the
> original value at close.  (Or interrupting via ctrl-C may cause it.)
>
> You can see the meaning of these bits via iecset utility included in
> alsa-utils package.

Thanks. I'll keep that in mind and check things when it happens again.

> So, the culprit looks like the analog loopback.
> Could you try the patch below, and make sure that you set "PCM" as the
> "IEC958 Playback Source"?

I can confirm this definitely solves the volume problem for me. I can increase 
the pcm and spdif volume to 100% and no clipping or distortions whatsoever 
happen on the spdif output. Works like a charm.

So far the other distortions I wrote about are now only hearable when I turn 
up the volume of my headphone to nearly its maximum. If it stays that way, I 
can live with it... reminds me, before the problem was fixed, I had my 
headphone at almost 100% most of the time, so that could be the reason why 
those distortions where so visible in the first place. I'll have an eye on 
it...

I am curious, will that patch make it into the offical mercurial repository 
and what was the problem exactly with the analog loopback?

Thanks for taking the time!

Best regards,
Matthias Dahl
