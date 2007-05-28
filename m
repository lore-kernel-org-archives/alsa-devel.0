From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ALSA] ALSA Power Management,
	Drivers behaving unexpectedly after suspend/resume cycle
Date: Mon, 28 May 2007 15:45:11 +0530
Message-ID: <8d6898730705280315s2afcce2fk22bbeb0031f410d3@mail.gmail.com>
References: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
	<s5h3b1lp75g.wl%tiwai@suse.de>
	<8d6898730705250504p442190e6u5bf71fbcd947df38@mail.gmail.com>
	<1180096780.13652.57.camel@localhost.localdomain>
	<s5hmyztnijd.wl%tiwai@suse.de>
	<8d6898730705280216v54aeb08y9d1dbb8be7acc7a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 101EB24713
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 12:15:12 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so348490nzf
	for <alsa-devel@alsa-project.org>; Mon, 28 May 2007 03:15:12 -0700 (PDT)
In-Reply-To: <8d6898730705280216v54aeb08y9d1dbb8be7acc7a2@mail.gmail.com>
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

I think i found the issue. Issue is in controller. Soon i will get
back with more details



On 5/28/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> I did some more investigation into this issue.
>
> There are two cases, in the first case it is working after resume()
> and in the second case it is not working after resume
>
> 1st Case:
>
> 1) boot the system
> 2)Load sound modules
> 2)mixer setting (alsactl restore 0)
> 3)Do power managemnt (sleep) suspend()
> 4)Come out of suspend, resume()
> 5)
> sound is coming out in this case
>
> 2nd Case:
> 1)boot the system
> 2)load sound modules
> 3)mixer settings (alsactl restore 0)
> 4)Do playback aplay -M /usr/share/sounds/alsa/Side_Right.wav
> 5) Let aplay to completion and kill all alsa apps if any running.
> 6)Do power managemnt (sleep) suspend()
> 7)Come out of suspend, resume()
> 8)Do playback aplay -M /usr/share/sounds/alsa/Side_Right.wav
>
> in this case no sound is coming out and i am getting underrun error.
>
>
> I am attaching some logs, these are the ac97 codec register values at
> various stages.
>
> Mainly look at the register 3c.
>
>
>
>
>
>
>
>
>
>
>
>
> On 5/25/07, Takashi Iwai <tiwai@suse.de> wrote:
> > At Fri, 25 May 2007 13:39:40 +0100,
> > Liam Girdwood wrote:
> > >
> > > On Fri, 2007-05-25 at 17:34 +0530, Nobin Mathew wrote:
> > > > Every ALSA driver is calling these for suspend
> > > >
> > > > snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> > > > snd_pcm_suspend_all(pcm[i]);
> > > >
> > > > And for resume
> > > > snd_power_change_state(card, SNDRV_CTL_POWER_D0)
> > > >
> > > >
> > > > In ALSA ASoC no driver is calling any of this, even not in soc-core.c
> > > >
> > > > My driver is an ASoC driver and I am also not calling these functions
> > > >
> > > > Will this cause any Issue?
> > > >
> > >
> > > These should probably be called to inform the upper layers of the PM
> > > state. Can you log a bug for this in ALSA bugzilla.
> > >
> > > Fwiw, this _shouldn't_ effect your resume. You should still see calls to
> > > trigger for your DMA / AC97 to re-start transmission of PCM data.
> >
> > I think this does matter.  Without calling snd_pcm_suspend*(), the
> > stream is assumed to be still active, thus eventually neither prepare
> > nor trigger is called at resume.  If the hardware is perfectly
> > resumed as it was before suspend, it may still work somehow.
> >
> > However, usually it's impossible to resume the hardware perfectly.
> > Thus, we need one stop the stream via snd_pcm_suspend*(), and let apps
> > (or OSS layer) parepare (if needed) and restart the stream again.
> >
> >
> > Takashi
> >
>
>
