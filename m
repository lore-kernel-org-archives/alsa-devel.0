From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: cs43130: Fix unused compiler
 warnings for PM runtime
Date: Mon, 4 Sep 2017 15:44:16 +0100
Message-ID: <20170904144416.gpykz26jbvjqhh66@sirena.org.uk>
References: <20170904135448.26314-1-tiwai@suse.de>
 <20170904135448.26314-2-tiwai@suse.de>
 <1504535463.2899.9.camel@nxp.com> <s5hmv6apm60.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1687181963455287828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64E6C26704E
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 16:44:18 +0200 (CEST)
In-Reply-To: <s5hmv6apm60.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============1687181963455287828==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h33vrtuzhn4ehdci"
Content-Disposition: inline


--h33vrtuzhn4ehdci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2017 at 04:34:47PM +0200, Takashi Iwai wrote:
> Daniel Baluta wrote:

> > Isn't it better to guard it with=A0CONFIG_PM?

> It's a matter of taste, and people seem prefer this option nowadays,
> so I follow that style.

The ifdefs are a complete pain every time someone decides they want to
do something amusing with the configuration for PM or if people want to
share things between the runtime and system suspend paths.

--h33vrtuzhn4ehdci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmtZr0ACgkQJNaLcl1U
h9BASQf+InzT1pHzLo9cZzzIzqefO+tGEtlPEcnACAXHsO4FHT0oHXA884igqCou
LEAajiTQlBB3Qg7gZHQdsdxgV0eh4tlkJmQpvdVSVSTWgrZZLq1Y98vknfsnYeVi
L8w0oEJNy4JBgVoXSSfs0hf7PGsSmHjG5HPOfXdrl8BbK13nS+7duhrimihWuF6a
SjUalqeVtOoyLrI0mbTRNsZTtT5TInIDsQyikR+dDfT+vxlZxT1NReBpAEMN4k37
+uOTL4PBm5Z81rgS83JYhdCnCChLIH7X13T4ulY1g+FmZB7iXrjpf3banDjnspYa
WFkU4g5LP/iIePc9dF7UDpwws11CWg==
=6dJh
-----END PGP SIGNATURE-----

--h33vrtuzhn4ehdci--

--===============1687181963455287828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1687181963455287828==--
