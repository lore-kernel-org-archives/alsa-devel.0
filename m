From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Adapt for debugfs API change
Date: Fri, 21 Jun 2019 15:30:53 +0100
Message-ID: <20190621143053.GH5316@sirena.org.uk>
References: <20190621113357.8264-1-broonie@kernel.org>
 <20190621113357.8264-2-broonie@kernel.org>
 <20190621132222.GB10459@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GyBFFrpYHGV4SYp0"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621132222.GB10459@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--GyBFFrpYHGV4SYp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2019 at 03:22:22PM +0200, Greg KH wrote:
> On Fri, Jun 21, 2019 at 12:33:57PM +0100, Mark Brown wrote:

> >  	struct dentry *d;
> > =20
> > -	if (!parent)
> > +	if (!parent || IS_ERR(parent))
> >  		return;

> How can parent be NULL?

It was more effort than it was worth to check to see if it could
actually be NULL through default initialization or something and fix it
than just not delete the check so I just left it there.  I'll probably
go back and clean it up more thorougly at some point.

> I am trying to make it so that debugfs doesn't return anything for when
> a file is created.  Now if that will ever be possible or not, I don't
> know, but I am pretty close in one of the branches in my driver-core
> tree...

You mentioned this in a mail last week, I then replied pointing out that
this is not helpful as it reduces the robustness and quality of our
debugging tools and you then did not respond.  This is a view I still
hold and in any case debugfs as it stands (and was in the kernel
versions since this was broken) is still capable of reporting errors so
we should fix that.

--GyBFFrpYHGV4SYp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0M6hwACgkQJNaLcl1U
h9CVfgf/Zvf50vTJSnV4Ifjlc60r5s/W7eTpQGayjvn9PD0gkjA4+G5hVAEjeV5u
qRvkDMZwgld9zIa08UvfBb7J7Cr+HV5RgQGnYBjcwXJwQ2bDecBUUhXjlNgcMRos
NwA99IiRefpwluCcD4Tc7jom/y/XyuIh07rvZyvGcrObNVytaRWToAjumnIT/tM0
DINLjqjXAHQNeNs3cpNea2HvjTxk524bEMm075hc87KWaqYZqfjL+PNyJthE9Psc
tVee93MX3iLcNfxeJe0XXhKZ4fNJh1KgREynpzNfKm3j+EPGS75BR66uimNtoS6J
4LLlg1ZRASBNPaIeHXVCk1u9MCpVGQ==
=27li
-----END PGP SIGNATURE-----

--GyBFFrpYHGV4SYp0--
