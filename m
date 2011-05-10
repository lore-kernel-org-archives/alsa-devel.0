From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
	Headphone with realtek codec
Date: Tue, 10 May 2011 14:42:45 +0800
Message-ID: <BANLkTinGHMxtszvUP=OG_K-if7dJLZ+ciw@mail.gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
	<s5hoc3hmq0b.wl%tiwai@suse.de>
	<BANLkTinz8=YMH0sE35abu_cneaJpra_eEg@mail.gmail.com>
	<s5hr58cieiv.wl%tiwai@suse.de>
	<BANLkTin0hV2gKHVk1xzKKszy_tPmvGNYFw@mail.gmail.com>
	<s5h8vugjcmj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 15E0A1038BD
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 08:42:46 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4665774fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 09 May 2011 23:42:45 -0700 (PDT)
In-Reply-To: <s5h8vugjcmj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/9 Takashi Iwai <tiwai@suse.de>

> At Sat, 7 May 2011 11:48:19 +0800,
> Raymond Yau wrote:
> >
> > 2011/5/6 Takashi Iwai <tiwai@suse.de>
> >
> > >
> > > >
> > > > Use "Independent HP" just because patch_via.c already used it so it
> is
> > > > better to use a standard name for all hda codecs
> > >
> > > Yeah, I know.  But this name is confusing, so better to change in
> > > patch_via.c as well.
> > >
> > >
> > > Takashi
> > >
> >
> > To force pulseaudio to get the correct subdevice for via codec, you may
> need
> > to add "subdevice 0" to HDA-intel.conf
> >
> > since subdevice 0 support multichannel but subdevice 1 only support
> stereo
> >
> >
> >     playback.pcm {
> >         type softvol
> >         slave.pcm {
> >             type hw
> >             card $CARD
> > +          subdevice 0
> >         }
> >         control {
> >             name "PCM Playback Volume"
> >             card $CARD
> >         }
> >     }
>
> OK, fixed now.  Thanks.
>
>
> Takashi
>

But dmix still fail and you cannot use dmix with subdevice 1

>> I'd name it differently, e.g. "Headphone Stream Mode" taking "Slave" and
"Independent", or such.  An enum with "ON" and "OFF" is no sensible choice.

The main point is how can the user find out which subdevice or device is
used for "Headphone Stream"

Neither "aplay -l " nor "aplay -L' provide any useful information to the
user

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 1/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
