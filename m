From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: cs42l56: Fix new value argument
 in snd_soc_update_bits calls
Date: Sun, 1 Jun 2014 11:50:05 +0100
Message-ID: <20140601105005.GA5099@sirena.org.uk>
References: <1400821531.915.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2338804838754457189=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4CC526517A
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 12:50:23 +0200 (CEST)
In-Reply-To: <1400821531.915.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============2338804838754457189==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOr3uFpVABmJfvZe"
Content-Disposition: inline


--BOr3uFpVABmJfvZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 01:05:31PM +0800, Axel Lin wrote:
> The new value argument needs proper shift to match the mask bit fields.

Applied, thanks.

--BOr3uFpVABmJfvZe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiwVZAAoJELSic+t+oim941sP/RhsIC2BQnWitDwM8X1Q2xr0
4JuzrxaF9+fRoakv1SD0V6D4UK9TyBIF9e12NJy7c72G3R846H6iz0TB2YH6oHu/
ryizJijXC93Ar3Gta/2gp6wDI2MPBCkrket+Or3Oty9+SKW/oKjhWt9uJUaBG15U
C86+WuCMloF4837YvMwiX4OaWRLFILdS/12T7306ZNjG5Lb7quFiu1TE/dL4vSBg
F829vfDBe0TWTFI3R/U8/IQ2rueQJUto2rpGWR3cozdCwLzO1vu1VHNfnYKuFW0F
L58A56S6DXtVS9NiwitjiqGUGEVBi8wXnFAKMgKbwkFmj7n5ca7W5OuDJ/bwf35I
Rs6++RbAbzavrlfrwwVLh4Gm9U5xB9eQ0YojuxV9s74FbKRqzg7kl3TH5t6/f+IA
6jqTOs6LzDIljWjoigXZzGFJVATsE4fx39svo0sMuQpwwt35x5f8ANt/R1kGl9Dw
2UuazyvVcqZY571xFyPew/u64JfypcUjSouL8sKe1yHKCAJrA2bXlGdD+dUBuDy/
y9KBh5sMSPZfUZfkX3WEGSW+VTc+iOjU3ZFgItIs4JUQV1w/viq1dW7InZeK1OH+
EsU19tZq83X6n/fNm1+52T7PGRMaZYsdzEiz6ykJob1+9Ei1qp2OAZUY2dqr8fyh
7aUnnNimHHYe3F+6ze9S
=ORXQ
-----END PGP SIGNATURE-----

--BOr3uFpVABmJfvZe--

--===============2338804838754457189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2338804838754457189==--
