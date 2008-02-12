From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by
	commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Tue, 12 Feb 2008 16:27:44 +0100
Message-ID: <200802121627.44422.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com>
	<s5hwspatgri.wl%tiwai@suse.de> <s5htzketg7v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A0B124480
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 16:27:49 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1318724nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 07:27:48 -0800 (PST)
In-Reply-To: <s5htzketg7v.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Takashi Iwai wrote:
> > Matej Laitl wrote:
> > > With your patch, the sound in headphone-out is working again, but
> > > surprisingly the integrated loudspeakers stopped working! ;)
> > >
> > > Also, new on/of control appeared in alsamixer - "Speaker", but unmuti=
ng
> > > it (and unmuting all playback controls, plugging-out headphones) didn=
't
> > > have an effect on non-working integrated loudspeakers.
> > >
> > > Some kernel mesgs with your patch:
> > > hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
> > > autoconfig: line_outs=3D1 (0x1b/0x0/0x0/0x0/0x0)
> > > =A0 =A0speaker_outs=3D1 (0x14/0x0/0x0/0x0/0x0)
> > > =A0 =A0hp_outs=3D1 (0x15/0x1b/0x0/0x0/0x0)
> > > =A0 =A0mono: mono_out=3D0x0
> > > =A0 =A0inputs: mic=3D0x18, fmic=3D0x19, line=3D0x0, fline=3D0x0, cd=
=3D0x0, aux=3D0x0
> > >
> > > alsa-info.sh output:
> > > http://pastebin.ca/901089
> >
> > Thanks. =A0There seems a couple of bugs in this auto-configuration
> > code. =A0Try the additional patch below. =A0This will unmute the
> > speaker-pin.
>
> This version might be slightly better...

Yes, this "slightly better" patch applied on top of your first patch agains=
t =

hda_codec.c did the trick, but with some side-effects:
* the "Speaker" switch now mutes/unmutes speakers
* muting/unmuting "Front" channel now has zero effect (in 2.6.24 it had the =

same effect as the "Speaker" switch now has)
* changing volume on "Front" channel now affects volume in headphones (was =
not =

so in 2.6.24)

So there are now 3 vol controls that affect both speakers and headphones:
* Master (which appeared somewhere between 2.6.24 and .25-rc1), when set to =

zero, the sound is still audible in speakers and headphones
* PCM, working as expected (0 volume =3D no sound)
* Front (0 volume =3D still audible sound)

So it is usable now (and those Speaker and Headphones on/off switches make =

sense), but kinda suboptimal. (is it my BIOS who is to blame?)

Thanks, Matej
