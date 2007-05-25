From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ALSA] ALSA Power Management,
	Drivers behaving unexpectedly after suspend/resume cycle
Date: Fri, 25 May 2007 18:24:57 +0530
Message-ID: <8d6898730705250554w31d4a3abr80b8b531f8398642@mail.gmail.com>
References: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
	<s5h3b1lp75g.wl%tiwai@suse.de>
	<8d6898730705250504p442190e6u5bf71fbcd947df38@mail.gmail.com>
	<1180096780.13652.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CF2E24431
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 14:55:00 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so208677ana
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2007 05:54:57 -0700 (PDT)
In-Reply-To: <1180096780.13652.57.camel@localhost.localdomain>
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

after resume when i do playback i am getting same number of DMA
interrupt  as in the working case (after reboot).

I am using aplay (/usr/share/sounds/alsa/Side_Right.wav)

But i am not getting any sound (3 underruns), my codec register
contents and controller register contents are same.



On 5/25/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
> On Fri, 2007-05-25 at 17:34 +0530, Nobin Mathew wrote:
> > Every ALSA driver is calling these for suspend
> >
> > snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> > snd_pcm_suspend_all(pcm[i]);
> >
> > And for resume
> > snd_power_change_state(card, SNDRV_CTL_POWER_D0)
> >
> >
> > In ALSA ASoC no driver is calling any of this, even not in soc-core.c
> >
> > My driver is an ASoC driver and I am also not calling these functions
> >
> > Will this cause any Issue?
> >
>
> These should probably be called to inform the upper layers of the PM
> state. Can you log a bug for this in ALSA bugzilla.
>
> Fwiw, this _shouldn't_ effect your resume. You should still see calls to
> trigger for your DMA / AC97 to re-start transmission of PCM data.
>
> PM was well tested on pxa2xx, although we did find a few applications
> were not too happy resuming audio. e.g. mplayer in alsa mode, although
> this was about 1 year ago and afaik it's been fixed.
>
> It may be best to debug this using aplay and placing some debug in your
> trigger functions to make sure PCM transmission is restarted correctly.
>
> Liam
>
>
