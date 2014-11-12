From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: davinci-mcasp: Add
 overrun/underrun event handling
Date: Wed, 12 Nov 2014 14:55:08 +0000
Message-ID: <20141112145508.GJ3815@sirena.org.uk>
References: <1415803085-24143-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3875684615576689980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C47C26577A
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 15:56:27 +0100 (CET)
In-Reply-To: <1415803085-24143-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3875684615576689980==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xh4RE6GGnlV9Y4tz"
Content-Disposition: inline


--xh4RE6GGnlV9Y4tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 04:38:05PM +0200, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> An underrun (playback) event occurs when the serializer transfer
> data from the XRBUF buffer to the XRSR shift register, but the

Applied, thanks.

--xh4RE6GGnlV9Y4tz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY3TMAAoJECTWi3JdVIfQ6kUH/Rnj1dMEkJvRZ6c14fqPrgBu
23ljZVLkIpZfW1muGFK4bCU2NvVzPdlizHgNUwWwgMrC7hJbebUr5gj7EJaYP6OM
w8aGI85KRYWFuXH6DLohZEsnqGqaP2AE+bZbL01VMky6ygthbShQgko+RZFxYkMh
sG9eQ0WgLuj1rXrWCp1B9eR8n49WOa4lVhFauveFnuD8SEwRy8vLzlI3aTUQtPnc
CJCK4EVX1tuUgmBalixZMw5ENOwjMmfAk/wALocmePXAFVG7KMyjukDJtbqsBczr
bQflz8z+LuMD5y58iErZU6t/Q37Wc0LGqlVl+MhBtYe9qtzY22jZuFWePMa0IQ0=
=+sju
-----END PGP SIGNATURE-----

--xh4RE6GGnlV9Y4tz--

--===============3875684615576689980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3875684615576689980==--
