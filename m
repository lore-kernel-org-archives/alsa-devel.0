From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Thu, 29 Jul 2010 15:11:26 +0800
Message-ID: <AANLkTi=u2fbu-uu9vgEdp60bouAq=iHehMBzPWXAGjdE@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se> <s5h6319dj90.wl%tiwai@suse.de>
	<4C2487EA.3090605@epost.diwic.se> <s5hzky6bgy2.wl%tiwai@suse.de>
	<s5heifcsvom.wl%tiwai@suse.de>
	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>
	<s5hiq4or5cz.wl%tiwai@suse.de> <4C376182.5050807@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9876E103927
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 09:11:27 +0200 (CEST)
Received: by vws20 with SMTP id 20so29864vws.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2010 00:11:26 -0700 (PDT)
In-Reply-To: <4C376182.5050807@epost.diwic.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/10 David Henningsson <launchpad.web@epost.diwic.se>

> 2010-07-09 18:23, Takashi Iwai skrev:
> > At Fri, 9 Jul 2010 21:13:52 +0800,
> > Raymond Yau wrote:
> >>>>>>> The second one (Do not report underruns to the ALSA layer) is more
> a
> >>>>>>> change of behavior, which could be questioned. The arguments for
> >>>>>>> removing that code are these:
> >>>>>>>
> >>>>>>>  * If pulseaudio gets an underrun, the normal way to end that
> >>> underrun
> >>>>>>> is to feed it with more buffers. This is different from the ALSA
> way
> >>> of
> >>>>>>> dealing with underruns, which requires hardware buffer pointers to
> >>> be reset.
> >>>>>>>  * In addition, underrun signals are delivered asynchronously from
> >>>>>>> pulseaudio. This means that there might be more buffers on the way
> >>> to
> >>>>>>> pulseaudio when the underrun is reported, making the underrun
> >>> obsolete.
> >>>>>>> Unfortunately, there is currently no known way to determine whether
> >>> this
> >>>>>>> is the case or not.
> >>>>>>
> >>>>>> I think this helps for normal use-cases, so it'd be good to apply.
> >>>>>> But, I prefer having a runtime option for such a behavior change
> >>>>>> (although the default value can be the new behavior).
> >>>>>>
> >>>>>> Care to add it?
> >>>>>
> >>>>> Sure, I can do that - it sounds like a good idea to have it
> >>> configurable.
> >>>>> Just so I understand you right, exactly how do you expect the user /
> >>>>> application to configure it?
> >>>>
> >>>> I suppose it can be simply added as an alsa-lib plugin config, i.e.
> >>>> in SND_PCM_PLUGIN_DEFINE_FUNC(pulse) of
> alsa-plugins/pulse/pcm_pulse.c,
> >>>> add the code like below:
> >>>>
> >>>>       int handle_underrun = 0;
> >>>>       ...
> >>>>
> >>>>       snd_config_for_each(i, next, conf) {
> >>>>               ...
> >>>>               if (strcmp(id, "handle_underrun") == 0) {
> >>>>                       handle_underrun = snd_config_get_bool(n);
> >>>>                       if (handle_underrun < 0) {
> >>>>                               SNDERR("Invalid value for %s", id);
> >>>>                               return handle_underrun;
> >>>>                       }
> >>>>                       continue;
> >>>>               }
> >>>>       }
> >>>
> >>> FYI, I modified the patch and applied to git tree right now.
>
> Thanks! I've been on holiday this week but thought I would do it in the
> following week. Only nice to see it being done :-)
>
> >> This behaviour is a little bit strange , using the same buffer size 128
> >>
> >> aplay -Dhw:0,0 --buffer-size=128 test.wav
> >>
> >> report underrun
> >>
> >>
> >> aplay -D pulse --buffer-size=128 test.wav
> >>
> >> did not report underrun but the sound is distorted
> >
> > Other subsystem, other behavior.
> > The detection of underrun is even unreliable on ALSA native, so user
> > can't expect it'll get underrun.
> >
> > The biggest drawback by this change is that whether the sound goes
> > well or not isn't reported any more to the application layer.
> > It's an unfortunate design, but it's life with PA.
>
> The question is - is there an application that detects the underrun
> condition and actually acts on that condition? If so, this could be a
> regression for that app. For other apps it's an improvement, for the
> reasons originally stated.
>
>
This patch by Lennart Poettering should answer your question

http://git.alsa-project.org/?p=alsa-plugins.git;a=commit;h=660e0f16145167a966e9b8387e9a8e08274a8f7c
