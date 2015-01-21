From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v10 9/9] ASoC: add generic dt-card support
Date: Wed, 21 Jan 2015 13:50:53 +0000
Message-ID: <20150121135053.GI21293@sirena.org.uk>
References: <cover.1421782532.git.moinejf@free.fr>
 <ddd1b299eca187ab2fa9b119da2ec8297ead1a66.1421782533.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ddd1b299eca187ab2fa9b119da2ec8297ead1a66.1421782533.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2015 at 08:16:25PM +0100, Jean-Francois Moine wrote:
> To create simple cards, the syntax of the simple-card does not follow
> the common binding of the device graphs
> (Documentation/devicetree/bindings/graph.txt).

Please be more specific, I really can't tell what this is supposed to be
doing from the above - in what way is the binding not common and why
would anyone care?  Please also address why this is done as a completely
separate implementation rather than a new revision of simple-card and CC
Morimoto-san so he can review (given that he did simple-card initially).

>  sound/soc/generic/Kconfig   |   2 +
>  sound/soc/generic/Makefile  |   2 +
>  sound/soc/generic/dt-card.c | 275 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 sound/soc/generic/dt-card.c

As you know all device tree bindings require binding documents; you must
supply a binding document.  I'm not going to look at any DT patches that
don't include binding documentation.

In general please pay attention to changelogs and documentation when
submitting patches, the harder it is to understand what a patch is
supposed to do or why the harder it is to review.  I keep saying this,
it's really important.

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUv668AAoJECTWi3JdVIfQTCQH/3LeWH0MvFi6Qqax4tZWuAvl
uPsAYOvWkxKu9b28WmnFC+xco356sr9wcslrN/zmlh7LwuGPQUvnEbCrXOQIosjj
zb2UuJUJdjlKZDRvoFti8OiEKqcz1L7uO2EDrc8LBMlE40U6rdu+ajrZ+hwtSqhS
U9i7/ELtVZBCsI6PHSSP7Ajv8XgpWUqqrC7oSrnsW5I3ol9APZIlX0c2MO5fQQrT
ZZzP99L7kopiJ5LtwkK1/0VxxOoPBAGLWd/JFtByDyESq6APEEuX2EcxqniKvA/W
Ynv6SoCdm8GjFt9lg0dWc6vmsa1Yf1thdQrGAJ/mYqvorlLN/TO827KNVY+VYTg=
=0ztJ
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
