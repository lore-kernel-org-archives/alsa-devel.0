From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Linux 3.2-rc1
Date: Wed, 9 Nov 2011 20:03:21 +0800
Message-ID: <20111109120321.GA10264@localhost>
References: <CA+55aFzytqbGcOzWvYAo-EnJCeK5mFqdCF5OjMTeM5UBfeyCXw@mail.gmail.com>
 <20111108145510.GA5142@elliptictech.com>
 <CA+55aFwx5=T1piX5qPj2jCAbzdHAQX2gYJODZnQ40h9hiDjkbQ@mail.gmail.com>
 <s5hty6dlp5o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hty6dlp5o.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nick Bowler <nbowler@elliptictech.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Keith Packard <keithp@keithp.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 09, 2011 at 03:40:19PM +0800, Takashi Iwai wrote:
> At Tue, 8 Nov 2011 12:23:30 -0800,
> Linus Torvalds wrote:
> >=20
> > Hmm, I don't know what caused this to trigger, but I'm adding both =
the
> > i915 people and the HDA people to the cc, and they can fight to the
> > death about this in the HDMI Thunderdome.
>=20
> It must be the new addition of ELD-passing code.

Yes, it's my fault.

> Fengguang, can the drm or i915 driver check whether ELD is changed or
> not?  Writing ELD at each time even when unchanged confuses the audio
> side, as if the monitor is hotplugged.

It's sure possible to mask out the extra events.
I'll work out a patch tomorrow.

> > Guys: One.. Two.. Three.. FIGHT!
>=20
> Round two!

Three to fight!

Thanks,
=46engguang

> > On Tue, Nov 8, 2011 at 6:55 AM, Nick Bowler <nbowler@elliptictech.c=
om> wrote:
> > >
> > > Mode switches are very noisy on an Intel G45 in 3.2-rc1:
> > >
> > > =C2=A0HDMI hot plug event: Codec=3D3 Pin=3D3 Presence_Detect=3D1 =
ELD_Valid=3D1
> > > =C2=A0HDMI status: Codec=3D3 Pin=3D3 Presence_Detect=3D1 ELD_Vali=
d=3D1
> > > =C2=A0HDMI: detected monitor W2253 at connection type HDMI
> > > =C2=A0HDMI: available speakers: FL/FR
> > > =C2=A0HDMI: supports coding type LPCM: channels =3D 2, rates =3D =
32000 44100 48000, bits =3D 16 20 24
> > >
> > > These lines get printed every single switch; previously only a si=
ngle
> > > line was printed once at boot (the "HDMI status" line).
> > >
> > > Cheers,
> > > --
> > > Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
> > >
> >=20
