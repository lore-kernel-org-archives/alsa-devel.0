From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ARM: kirkwood: enable S/PDIF
Date: Tue, 23 Jul 2013 14:26:28 +0100
Message-ID: <20130723132628.GD9858@sirena.org.uk>
References: <20130723102320.56bc4555@armhf>
 <20130723084347.GP24642@n2100.arm.linux.org.uk>
 <20130723130622.GB9858@sirena.org.uk>
 <51EE8158.4050300@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NknGfcVoKMD30k4E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51EE8158.4050300@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org


--NknGfcVoKMD30k4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 03:12:56PM +0200, Sebastian Hesselbarth wrote:

> the mask that is changed in the patch is what will be written
> into i2s controller's registers. So, if there is no S/PDIF in that
> specific controller that bit can possibly have a different meaning.
> Also, enabling both I2S playback and SPDIF playback can cause the
> controller to behave differently.

Oh, so it will - I glanced through it and misread, sorry.  If it just
makes the enabling of S/PDIF mode conditional on DAI format that'd cover
it.

> I share Russell's concern about it and would rather like to use
> multiple codecs per DAI (DPCM) for that. I see Daniel Mack picked
> that up again, maybe he submits something soon.

Well, that'd be ideal and is going to be needed for any hardware which
has both wired up in parallel but a simpler either/or thing doesn't seem
like a problem.

--NknGfcVoKMD30k4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7oSAAAoJELSic+t+oim9tckP/1Y/7eU4k2C9WrSBiS6KNzwK
L64Zr0SEx0ADTq5huA16s/t5jXD0z1XxDf9c7iShdCBo8VA9qFZDEeYdpIj6196V
nQaSUIHWeXnhm4yq8yv4PLlAclrIGTY95z2dizUpVKm70v/qDcjG+2yPzU2+HOye
tvLoJPEEJigfoWrJFk7mscooEgeB0BUzY3UYPRe0pwqJygJDzeI/3H5IW57W8dr4
bb1TdAZkWNf3xqJ4+r5WvKOmXdRQKGx0YaFDaUOEMzTHKjhQ5z+tfCnzbdnHMlq/
zsclnqNDekVQMEwYX9HvYbzThZFqHFpiEB1QVJ6YnsW1c2KlQtUwaSb1lq9mZfsE
jwM/UXkAwvqeDW9UT82a9ASX9Ly83TzrfL8Yfg3vT2KWmfqRo8cjMuJbx6pzict8
nOT94l8KMGDOUkqBQfIkTSEtVJd4TVen+zxv4RcOrnipHOkgrvO63tN0QpyzFAy0
uMDJI396tALu9XnzFUwqEqiiowRS7cwRL+9sXrQp+UZLmnQjJ/SzdRj47At4mVvI
pWEjaClHDwVYbA/+CV268TU4oV8lmYMM0o62cmRsWyp3x8bwG8mwt/JXtpqsm00d
HWWdUtGF1q2AvlpTopfswmxVjrjMFv/C1JiV/72xq3F4UkPF6rmNo+54C197OK/o
jXNsrXtLuTPY6RoKt3wY
=B2KQ
-----END PGP SIGNATURE-----

--NknGfcVoKMD30k4E--
