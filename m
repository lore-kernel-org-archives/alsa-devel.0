From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Mon, 30 Aug 2010 17:30:19 +0800
Message-ID: <AANLkTikqKjvLG0WxUA-7wWzdEHmWBZg84_71CwiZbSa4@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 812541037EE
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 11:30:20 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2959123ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 02:30:20 -0700 (PDT)
In-Reply-To: <s5h4oec8r6f.wl%tiwai@suse.de>
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

2010/8/30 Takashi Iwai <tiwai@suse.de>

> At Sat, 28 Aug 2010 06:58:20 +0800,
> Raymond Yau wrote:
> >
> > 2010/8/28 David Henningsson <david.henningsson@canonical.com>
> >
> > > 2010-08-27 17:43, Clemens Ladisch skrev:
> > > > David Henningsson wrote:
> > > >> So I've discovered that my sound card has a "PCM Playback Volume"
> > > >> control, but changing that control does not alter the volume.
> > > >>
> > > >> Interestingly enough, this control does not come from the HDA
> parser, it
> > > >> is added by alsactl at boot time...!
> > > >
> > > > This control was created by the software volume plugin.  When not
> using
> > > > this plugin, the control does not have any effect.
> > > >
> > > > To get rid of it, delete its entry from /etc/asound.state.
> > >
> > > Hmm, I wonder if this is an Ubuntu-specific bug then? Because when I
> run
> > > Maverick (the upcoming Ubuntu release) from a Live-CD, the "PCM
> Playback
> > > Volume" control is still there (and there is no asound.state, neither
> in
> > > /etc or in /var/lib/alsa).
> > > When I use the plughw interface, the "PCM Playback Volume" does not
> > > affect volume output. Should I use another device string to test the
> > > softvol plugin, to see if it's there or not?
> > >
> >
> > The softvol plugin it is defined in "front" device in
> > /usr/share/alsa/cards/HDA-Intel.conf
> >
> > reason is some HDA codec does not has any hardware volume control
> (analog)
> >
> > this user-defined control only effective when the application use "front"
> > device
>
> Hm, but if PA opens the device with SND_PCM_NO_SOFTVOL flag, the
> softvol should be skipped.
>
>
AFAIK, PA did not use SND_PCM_NO_SOFTVOL and in "analog stereo duplex"
profile , PA open "front" device for playback and capture which access the
same "PCM Playback volume" control concurrently

You can see the output of snd_pcm_dump() in the pulseraudio log still
contain soffvol which is an indiication that PA did not use
SND_PCM_NO_SOFTVOL

the softvol control can only be distinguished using
snd_ctl_elem_info_is_user()  and there is no snd_mixer_* function to find
out the softvol control since PA server use simple mixer api
