From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Pass kcontrol pointer to bytes tlv callbacks
Date: Fri, 12 Jun 2015 12:22:07 +0100
Message-ID: <20150612112207.GK1921@sirena.org.uk>
References: <1433283843-33856-1-git-send-email-benzh@chromium.org>
 <20150603115951.GG14071@sirena.org.uk>
 <CAOV7ByLAwtv1n4wdww=5r7wvCDOtwh7+g_3AqZAaPF=R8zmsTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4wkndigzIeYF6Hbg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOV7ByLAwtv1n4wdww=5r7wvCDOtwh7+g_3AqZAaPF=R8zmsTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Zhang <benzh@chromium.org>
Cc: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, Dylan Reid <dgreid@chromium.org>, alsa-devel <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--4wkndigzIeYF6Hbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 02:10:28PM -0700, Ben Zhang wrote:
> On Wed, Jun 3, 2015 at 4:59 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Jun 02, 2015 at 03:24:03PM -0700, Ben Zhang wrote:

> >> -     int (*get)(unsigned int __user *bytes, unsigned int size);
> >> -     int (*put)(const unsigned int __user *bytes, unsigned int size);
> >> +     int (*get)(struct snd_kcontrol *kcontrol,
> >> +                unsigned int __user *bytes, unsigned int size);
> >> +     int (*put)(struct snd_kcontrol *kcontrol,
> >> +                const unsigned int __user *bytes, unsigned int size);

> > This doesn't update any users and we do have some like the Haswell PCM
> > driver.

> I couldn't find any existing users of the callbacks. It looks like the
> modified callbacks are used by SND_SOC_BYTES_TLV only, and there is no
> reference to SND_SOC_BYTES_TLV in the kernel.

> The Haswell PCM driver uses SND_SOC_BYTES_EXT which doesn't use the
> callbacks in struct soc_bytes_ext. The xhandler_get/put are assigned
> to snd_kcontrol_new.get/put instead.

This then begs the question why the fix isn't for the TLV version to use
the same callbacks we're currently using?  It's not obvious looking at
the definitions of the controls why we would want them to be using
separate ones and TLV would normally not affect the I/O.

--4wkndigzIeYF6Hbg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVesDaAAoJECTWi3JdVIfQHWUIAIb2q3HUK+B4NRHw4GL/yQRU
KfNFIbuSH5cCHACqoqYL2XP3UJFY6pSTA+/MeEAyfJkAA5b/w1Ha1lYxK7HB0IBT
2ydd13/DoQUDohZzSCHfSseloL6HwnCMf2/lg4dWa+Te5XVsQ1v6Ej6K4ymXNyfF
ZGbKqeuFu6iEb/tKmchFULJx58MYnv8hbVDLssqkeeuPORYCedcMtS0kFiJsnsxc
eCWuWpW7NJVE938zligfmL5SaDETrFZYGfCwSw25JcccqouIBj9U5FEYpRPXQFXR
jIhNcUGTi50jtfJn70amRxAN+TtVNP5BLC+LzsF5S9fMgAMGOA3om9BSyroXa/s=
=G/tV
-----END PGP SIGNATURE-----

--4wkndigzIeYF6Hbg--
