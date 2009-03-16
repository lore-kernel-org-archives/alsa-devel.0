From: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Subject: Re: [alsa-devel] Bugs on aspire one A150
Date: Mon, 16 Mar 2009 18:30:00 +0100
Message-ID: <20090316173000.GA25647@rhlx01.hs-esslingen.de>
References: <s5hfxhdr1oz.wl%tiwai@suse.de> <20090316143158.GA12725@rhlx01.hs-esslingen.de> <s5hab7lr0k1.wl%tiwai@suse.de> <20090316145036.GA26358@rhlx01.hs-esslingen.de> <s5h4oxtqy6q.wl%tiwai@suse.de> <20090316160208.GB4458@rhlx01.hs-esslingen.de> <s5hwsappi44.wl%tiwai@suse.de> <s5hprghphid.wl%tiwai@suse.de> <20090316170015.GA9776@rhlx01.hs-esslingen.de> <s5hljr5pex0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hljr5pex0.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Mar 16, 2009 at 06:15:39PM +0100, Takashi Iwai wrote:
> At Mon, 16 Mar 2009 18:00:15 +0100,
> Andreas Mohr wrote:
> >=20
> > Hi,
> >=20
> > On Mon, Mar 16, 2009 at 05:19:38PM +0100, Takashi Iwai wrote:
> > > At Mon, 16 Mar 2009 17:06:35 +0100,
> > > =E7=A7=81 wrote:
> > > >=20
> > > > > > What are "sliders"?
> > > > >=20
> > > > > Umm, volume level controls.
> > > >=20
> > > > Yes but there are many of such :)
> > > >=20
> > > > More exactly, from the driver perspective, there are no volume
> > > > controls but only there are control elements with integer value=
s.
> > > > Do you mean "Capture Volume" control or which one?
> >=20
> > Hmm, ok, this needs to be more precise:
> > In gamix (codec "HDA Intel : Realtek ALC268"), the Capture Volume c=
ontrol.
>=20
> Yeah, that's more understandable :)
>=20
> BTW, does "Capture Volume" influence on the recording level even for
> the built-in mic, right?  I'm asking this because the digital mic on
> STAC/IDT codecs isn't controlled via "Capture Volume" control that is
> bound to an ADC widget.  (That's why "Digital Capture Volume" control
> exists.  It's a value used by alsa-lib softvol plugin for "default"
> PCM.)

Yes, Capture Volume does influence i-Mic level.
The Digital Capture control, however, doesn't influence level.
As doesn't the Mic Boost Capture control (probably about e-Mic only?).

> > > > And, is the behavior consistent regardless of the value high, i=
=2Ee.
> > > > the key is only whether the values for both channels are identi=
cal?
> > >=20
> > > BTW, what if you record with the following definition?
> > > Put the below to ~/.asoundrc
> > >=20
> > > pcm.imix {
> > > 	type plug
> > > 	slave.pcm "hw"
> > > 	ttable.0.0 0.5
> > > 	ttable.0.1 -0.5
> > > }
> > >=20
> > > and record like
> > >=20
> > > 	% aplay -Dimix -c1 foo.wav
> >=20
> > Does NOT exhibit the "equal sliders =3D=3D no sound" bug (apart fro=
m this sliders
> > are acting normally, i.e. slider low =3D=3D no sound), despite bein=
g a
> > "plug" type definition (this is what you wanted to discern, right? =
;).
>=20
> Interesting.  This implies that one channel is inverted indeed.

Oh, you mean "inverted" as in "_hardware_ channel which provides opposi=
te
sample values as compared to the other channel"?

> As default the alsa-lib plugin downmixes a stereo stream to a mono
> stream simply  by left/2 + right/2.  The above changes the routing
> policy as left/2 - right/2.

That exactly matches my current stream of thought (while reading
"one channel is inverted" above).

> So we need to pass some information to change this kind of thing...

That's something specific to ALC268 codec setup, right?
("ALC268 digital mic =3D=3D left plus right channel, but inverted setup=
"?)

> But a question still remains; why conversion with sox worked.
> Maybe it didn't mix?  Or, the code alsa-lib could be buggy...
>=20
> A simple test would be to just sum all 16bit samples in a stereo
> stream file externally.  That is, first record a RAW file via
>=20
> 	% arecord -Dhw -traw -fdat foo.dat
>=20
> Then create a mono stream just do 16bit left/2 + right/2 calculation
> by any way (a good homework for kids :).  Is it also problematic?

OK, I know what you're up to, I'll do this external proof ASAP,
will take a couple more minutes.

Andreas
