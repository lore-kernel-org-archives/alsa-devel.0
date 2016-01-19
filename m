From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Tue, 19 Jan 2016 12:25:24 +0000
Message-ID: <20160119122524.GM6588@sirena.org.uk>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
 <1453132657-18678-3-git-send-email-jacob@teenage.engineering>
 <CAOf5uwnEuUPdUn5hdpX2VytDb8qHP8c56ipEM+Qsu7q_zWGbEw@mail.gmail.com>
 <20160118165657.GE3169@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dUqA8l88BsAA6L8T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160118165657.GE3169@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--dUqA8l88BsAA6L8T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 18, 2016 at 05:56:57PM +0100, Johan Hovold wrote:
> On Mon, Jan 18, 2016 at 05:14:42PM +0100, Michael Trimarchi wrote:

> > > +       { .compatible = "ti,pcm1792a", },
> > > +       { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, pcm179x_of_match);

> > can match go in the common part?

> For matching purposes it could, but that would prevent the OF-aliases
> from being defined for the driver modules.

> There are a couple of codec drivers that have taken this route, and it
> works as long as they also define a legacy (e.g. i2c_device_id) table
> that modalias autoloading can fall back to.

> But having having the common module carry the OF-aliases does not seem
> like the right thing to do (e.g. as the common module cannot drive
> anything on its own) even if it avoids a copy of the OF id table.

This does seem like something that the modules code should be able to
cope with - we have a reference from the driver struct to the table
which you'd really expect it to be using.  We already have some issues
there with userspace not handling multiple modaliases terribly well IIRC.

--dUqA8l88BsAA6L8T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWniszAAoJECTWi3JdVIfQ+XUH/j5xUdnz4DLJ59MUlRDyh200
Rk3K1ZgDD5n6gl+vIkm9WEpgdaJSN7Fk2VBN/i6KUluLXbGtPDNDsxKecGvi62Vn
0gBxA8eGUvQ6kn/8ds1MJQ6yRw9790CvHLYySzXK8XwgarQa0wTRPA8MJP1oCegj
od1aXdnsfKKxHpyjD7UGfREfOfQ5VBB5y1JtRR4cvwTTDkuavcBgZYrmFXxtxaFQ
5SUZtygvnFejfXBTIHFVJjjL51/ljdfR8y70d3zK+SMj4itX0cq0hjYQr14Z2fSH
PyJtNv/OYhEBKSTcbmngTeJy/r02JQUzo/ICjOTiZ35Hqf2967RArJeqjTgJDyw=
=32l2
-----END PGP SIGNATURE-----

--dUqA8l88BsAA6L8T--
