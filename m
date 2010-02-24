From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 24 Feb 2010 20:07:39 +0800
Message-ID: <4f3252891002240407u33ff25b9va343c9ee7bbd66d5@mail.gmail.com>
References: <4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002202001gb6df8cg6c023c52e7d8394a@mail.gmail.com>
	<20100221192951.GD30380@tango.0pointer.de>
	<4B83A912.1050501@ladisch.de>
	<20100223223234.GB5313@tango.0pointer.de>
	<4B84EAC1.8040701@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F108A103912
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 13:07:40 +0100 (CET)
Received: by pwi9 with SMTP id 9so4231406pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 04:07:39 -0800 (PST)
In-Reply-To: <4B84EAC1.8040701@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

2010/2/24 Clemens Ladisch <clemens@ladisch.de>

> Lennart Poettering wrote:
> > On Tue, 23.02.10 11:08, Clemens Ladisch (clemens@ladisch.de) wrote:
> > > Lennart Poettering wrote:
> > > > Unfortunately there is no way from the simple mixer to the lower
> level
> > > > mixer.
> > >
> > > From the check_unplugged function in
> alsa-utils/alsamixer/mixer_widget.c:
> > >
> > >     err = snd_mixer_get_hctl(mixer, mixer_device_name, &hctl);
> > >     if (err >= 0)
> > >             ctl = snd_hctl_ctl(hctl);
> >
> > But that still doesn't give me a hint which snd_ctl_eleme_t belongs to
> > which snd_mixer_eleme_t, does it?
>
> Not really; the point of the simple mixer interface is to abstract away
> some of the ctl naming conventions.
>
> > > > It would be great if the smixer would include some API that gives me
> a
> > > > hint to which device/subdevice a specific snd_mixer_elem_t belongs
> to.
> > >
> > > Often, there is no 1:1 correspondence between mixer elements and PCM
> > > devices.  Only mixer controls with interface PCM (not MIXER) have
> (sub-)
> > > device numbers, and at the moment this is used only for controls that
> > > are associated with the streams of hardware-mixing-capable cards.
> >
> > Which are not that many, right? Not HDA at least?
>
> No, most recent hardware was designed for software mixing.  Only the
> snd-emu10k1, snd-via82xx and snd-ymfpci drivers implement such controls.
>
>
> Regards,
> Clemens
>
>
However the playback subdevices of some HDA codec did not support the same
range of channels

(e.g. vt1708s has two playback subdevices ,

 if independent HP mode is ON , one subdevice can only suppport 2 channels
and the other subdevices support 2 ,4 ,6

if independent HP mode is OFF , the subdevice may support 2, 4, 6 and 8
channels
