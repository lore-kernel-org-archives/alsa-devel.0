From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ALSA] ALSA Power Management,
	Drivers behaving unexpectedly after suspend/resume cycle
Date: Fri, 25 May 2007 17:34:08 +0530
Message-ID: <8d6898730705250504p442190e6u5bf71fbcd947df38@mail.gmail.com>
References: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
	<s5h3b1lp75g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C1C624453
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 14:04:09 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id i11so880760nzi
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2007 05:04:08 -0700 (PDT)
In-Reply-To: <s5h3b1lp75g.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Every ALSA driver is calling these for suspend

snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
snd_pcm_suspend_all(pcm[i]);

And for resume
snd_power_change_state(card, SNDRV_CTL_POWER_D0)


In ALSA ASoC no driver is calling any of this, even not in soc-core.c

My driver is an ASoC driver and I am also not calling these functions

Will this cause any Issue?

Thanks

On 5/25/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 25 May 2007 11:27:10 +0530,
> Nobin Mathew wrote:
> >
> > I am implementing power management in my ALSA sound drivers. ALSA
> > drivers are not working properly after resume. All registers values
> > are proper and I am able to read back the codec register contents.
> >
> > If I do a playback after resume then I am getting lots of "underrun".
>
> As Liam already pointed, the underrun is usually irrelevant from the
> codec registers, as codec chips don't control the DMA transfer.
> So, it's likely a controller side problem.
>
> > After a reboot playback is working fine.
> >
> > Is there any known issues with ALSA power  management?
>
> No.  Some drivers may have, but no problem in general.
>
> > Why Ubuntu and Redhat does ALSA modules removal before suspend and
> > insertion after resume?
>
> They are either too lazy or too conservative :)
>
>
> Takashi
>
