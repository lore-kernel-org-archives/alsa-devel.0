From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] System with multiple arizona (wm5102) codecs
Date: Sat, 19 Sep 2015 11:21:57 -0700
Message-ID: <20150919182157.GO30445@sirena.org.uk>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20150915061832.GA25442@amd>
 <20150915080648.GG11200@ck-lbox>
 <20150915083552.GA14780@amd>
 <CAG5mAdybV2U5Z9FRPy4zVF10Ws63rybSHCMCEpKQ1ArTBLnXpw@mail.gmail.com>
 <20150915140919.GE11268@sirena.org.uk>
 <CAG5mAdzKC1FuF-DXosj2RBwyo6jA_qvnjSjuCKfHgMWvQ59kag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zBPbvmIlJjvpbu6L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG5mAdzKC1FuF-DXosj2RBwyo6jA_qvnjSjuCKfHgMWvQ59kag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Crome <caleb@crome.org>
Cc: Pavel Machek <pavel@ucw.cz>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Fabien Parent <fparent@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--zBPbvmIlJjvpbu6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2015 at 08:26:36AM -0700, Caleb Crome wrote:

> > Like Charles said earlier the Bells machine in mainline has multiple
> > CODECs hooked up.  Speyside too.  To hook up multiple CODECs to a single
> > DAI link see 88bd870f02dff5c94 (ASoC: core: Add initial support for DAI
> > multicodec), sadly I don't think Benoit ever got round to submitting a
> > machine.

> Thanks Mark.

> I've been staring at that diff for a a day or two, and I still can't
> quite figure out how to use it.

> I think I'm getting close:  all codecs are registered, the DAPM stuff
> seems to be connected (all with prefixed names), but the card won't
> open more than a 2 channel interface.

> For example, when I do aplay -l, I get this:
> **** List of PLAYBACK Hardware Devices ****
> card 0: PUPPYAUDIO [PUPPY-AUDIO], device 0: AIC3X tlv320aic3x-hifi-0 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PUPPYAUDIO [PUPPY-AUDIO], device 1: AIC3X tlv320aic3x-hifi-1 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PUPPYAUDIO [PUPPY-AUDIO], device 2: AIC3X tlv320aic3x-hifi-2 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PUPPYAUDIO [PUPPY-AUDIO], device 3: AIC3X tlv320aic3x-hifi-3 []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0

That doesn't look entirely like what I'd expect...  I'd epect to see one
DAI presented to userspace.  Indeed looking through your diff I don't
see any usage of struct snd_soc_dai_link_component as described in the
changelog for the change I pointed you at.  I'd expect to see one DAI
link with a bunch of those hanging off it giving a single DAI to aplay.

OTOH I'm not sure it's going to work as I'm not immediately seeing how
we handle the ability to have more capabilities than an individual
device (based on the changelog I suspect the original use case may have
been two mono I2S devices which have stereo interfaces even if they only
pay attention to one channel on themm).  But let's at least get
everything appearing as one DAI first before we move on to worrying
about that, I didn't check thoroughly yet.

--zBPbvmIlJjvpbu6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/afFAAoJECTWi3JdVIfQ2gEH+gNyTe3TP34e7mNrVc67zbxg
jQYByhqPsuvABifbj2CZln+b6X3h5XTykTOKnngu7zURwvi6/iiAj1jBtXAwBHTn
KMJYNQURekD6GnbxOI5OFi74oym1Lypnsc/0H2o8ovzkv+LcUvBY4jJQ9Wy0JROM
xyztTwdfeGFzTh6AGHhKZi0ChOxbFtUupVMntWrGGJEp2lt0J41D8yKX0H6aTc2c
d0nrEDqt+Er7+F1Zd0O8H+IvX7YF+RNSEgE6Nmp7vSp5VWoE+Q5RyIuQIuX1yLLs
5tCW/20STIH4z5V8+2LlRWHkkcO+DksxbD7qPrepDw2Me7oHce2OTPFqqQgzjnY=
=EDgy
-----END PGP SIGNATURE-----

--zBPbvmIlJjvpbu6L--
