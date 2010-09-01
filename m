From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Wed, 1 Sep 2010 22:06:15 +0800
Message-ID: <AANLkTikdR6Xi4Re1UFGqQ0hidT0AYCPswrz4XHKtCW2A@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de> <4C7BABA9.1010100@canonical.com>
	<s5hlj7ont8e.wl%tiwai@suse.de> <4C7E549E.4080505@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 43811245A4
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 16:06:17 +0200 (CEST)
Received: by eyd9 with SMTP id 9so4181318eyd.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2010 07:06:16 -0700 (PDT)
In-Reply-To: <4C7E549E.4080505@canonical.com>
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

2010/9/1 David Henningsson <david.henningsson@canonical.com>

> 2010-08-30 15:08, Takashi Iwai skrev:
> > At Mon, 30 Aug 2010 15:01:29 +0200,
> > David Henningsson wrote:
> >>
> >> 2010-08-30 10:01, Takashi Iwai skrev:
> >>> At Sat, 28 Aug 2010 06:58:20 +0800,
> >>> Raymond Yau wrote:
> >>>>
> >>>> 2010/8/28 David Henningsson <david.henningsson@canonical.com>
> >>>>
> >>>>> 2010-08-27 17:43, Clemens Ladisch skrev:
> >>>>>> David Henningsson wrote:
> >>>>>>> So I've discovered that my sound card has a "PCM Playback Volume"
> >>>>>>> control, but changing that control does not alter the volume.
> >>>>>>>
> >>>>>>> Interestingly enough, this control does not come from the HDA
> parser, it
> >>>>>>> is added by alsactl at boot time...!
> >>>>>>
> >>>>>> This control was created by the software volume plugin.  When not
> using
> >>>>>> this plugin, the control does not have any effect.
> >>>>>>
> >>>>>> To get rid of it, delete its entry from /etc/asound.state.
> >>>>>
> >>>>> Hmm, I wonder if this is an Ubuntu-specific bug then? Because when I
> run
> >>>>> Maverick (the upcoming Ubuntu release) from a Live-CD, the "PCM
> Playback
> >>>>> Volume" control is still there (and there is no asound.state, neither
> in
> >>>>> /etc or in /var/lib/alsa).
> >>>>> When I use the plughw interface, the "PCM Playback Volume" does not
> >>>>> affect volume output. Should I use another device string to test the
> >>>>> softvol plugin, to see if it's there or not?
> >>>>
> >>>> The softvol plugin it is defined in "front" device in
> >>>> /usr/share/alsa/cards/HDA-Intel.conf
> >>>>
> >>>> reason is some HDA codec does not has any hardware volume control
> (analog)
> >>>>
> >>>> this user-defined control only effective when the application use
> "front"
> >>>> device
> >>>
> >>> Hm, but if PA opens the device with SND_PCM_NO_SOFTVOL flag, the
> >>> softvol should be skipped.
> >>
> >> But that does not apply to the mixer controls as well, does it?
> >
> > It does.  The mixer element is created when this kind of PCM stream is
> > opened without SND_PCM_NO_SOFTVOL flag.  Then it leaves the control
> > for the later use, and alsactl saves/restores it.  So, it's a chicken-
> > and-egg problem.
>
> Sounds a little strange to me. Thinking in general, if something is
> created when a stream is opened, that something should be destroyed when
> the stream is closed.
>

Them , the mixer application will also abort when the stream is closed and
you cannot access the control before the stream is opened (i.e. just like
those hardware PCM volume control of ymfpci or via82xx


>
> > Of course, it's possible that it wasn't PA who opened the PCM stream.
> > But, something opened the stream and it created the mixer element.
> > This is the correct behavior.
>
> And once created, it stays there forever... So even if PA does not
> create it, we'll just transform a persistent problem to an suddenly
> appearing problem?
>
> Anyway, do we want softvol at all for HDA? Wouldn't that be such an
> unusual use case, that those people that can't adjust volume any other
> way, can add that softvol themselves in .asoundrc?
>
> >> I think
> >> we still have a problem with PA assuming that it can change the PCM
> >> volume control to change the output volume.
> >
> > PA can check whether it's a user-defined control or not.
>
> Would that be safe - I mean, can't there be user-defined controls PA
> *should* care about?
>

>From the viewpoint of PA server , it just want to know how to calculate the
total dB range of the hardware volume controls in the audio path from DAC
[Audio Output] to the speakers/ headphone [Pin complex]

it don't really need softvol plugin if PA server can really provide software
attenuation when the sound card does not has hardware volume control
