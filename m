From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [[alsa-devel][Patch] 0/2] ASoC sti: suppress inappropriate DT
 fields
Date: Wed, 14 Sep 2016 18:14:47 +0100
Message-ID: <20160914171447.GH27974@sirena.org.uk>
References: <1473753504-20179-1-git-send-email-arnaud.pouliquen@st.com>
 <20160914171344.GG27974@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160914171344.GG27974-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2016 at 06:13:44PM +0100, Mark Brown wrote:
> On Tue, Sep 13, 2016 at 09:58:22AM +0200, Arnaud Pouliquen wrote:
> > Aim of this patchset is to clean some "dirty" fields in devicetree.=20
> > As Values are linked to the chip version and the IP usage,=20
> > they can be handled by device data associated to the compatibility stri=
ng.
>=20
> Please format your subject lines using the conventions people usually
> use - it makes looking at e-mail inboxes a lot easier.

=2E..and also breaks tools like git am that parse subject lines :(

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2YWGAAoJECTWi3JdVIfQarMH/0F7fgAuU8HSrDDc/k6nq7dK
YYbeWWOX7A8Yzw1gX3egR0G7bQs0q6tN0ykYbJ1q0s2OBx1Jv1J9M9DjZQMsMXlk
HlqYGTk3/8zNplAFvXQB2ZtHe6HRFMbeCB3LgdPuagWExhUtUTBnWVhirqYYK6qo
Oq80kTa7N9uV+Fbw6lPcAOYuqwTJI1hCokNQ1BWFHgJGUT2ViqCJZ8yULpxFpDj8
S548LIEeWrPQHehgO+DXa0xz1bBxbrTp012GCJb2/wbtgLOuR2WJo80UP9U2jbW1
klh2jPrG63ms38p3glSl+Hvnp7gXtm6BlFPt4M/E/CXTjq+lqUOwmE1Na14fnoc=
=K/JO
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
