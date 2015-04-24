From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Fri, 24 Apr 2015 17:50:38 +0100
Message-ID: <20150424165038.GS22845@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
 <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
 <CAJzqFtYZ8=k7ETGyXYoDTpjNdPQ7oRrMxO+kG++3diFif6Ox1g@mail.gmail.com>
 <20150424092839.GI22845@sirena.org.uk>
 <CAJzqFtZ3wMHHoAesUZws0b4csArsjeZTKeB7FbU7OSSbmCT1nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXOpbbhANqpLO4rK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtZ3wMHHoAesUZws0b4csArsjeZTKeB7FbU7OSSbmCT1nA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--xXOpbbhANqpLO4rK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2015 at 06:52:01AM -0700, Kevin Cernekee wrote:
> On Fri, Apr 24, 2015 at 2:28 AM, Mark Brown <broonie@kernel.org> wrote:

> > Do you need to work around it?  If the register map is being perserved
> > you don't need to sync so just don't do it - it's just that the normal
> > expectation would be that power down would cause the register map to be
> > reset.

> How do I tell regcache to write out any updates that happened while
> the hardware was inaccessible?  I see that regmap->cache_dirty is 1,
> but nothing flushes it automatically when exiting cache_only mode.

Oh, I see.  A sync will be required, yes.  Probably resetting the device
is easiest.

--xXOpbbhANqpLO4rK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOnReAAoJECTWi3JdVIfQyV4H/Rc+qlL/5Rmaa/GfMAUa2anO
YhbRfHYMz4mOdRIthVAieiwQ/2VPJ68ofs9SQBXuzO4qqNJjkbZbWmxgvkdAD7DF
X2QGIXWK+OfNLF4KfS3FvYOuGkoDp6Q5p7a9E0WSXr5OpakAcjNxYAtsgW7rEhby
ATJf9COr+oGgn1SwfZ5maRXlHU6XePhAnT0Y8WCPbjvrl6De3MEAAflPcKFH6GXm
4dYlq7v7+MA+RRlmOyTbW55pzRjcS58EbPnlhgiUpN7yWdv2ihB0QjebF8jNDWC1
c+jT8n0ZrnVXPr0HbsSSbc8JgixsGiu2YhBqGiq41rNTIjHIc8gfAwOM9m+FJvA=
=eRkH
-----END PGP SIGNATURE-----

--xXOpbbhANqpLO4rK--
