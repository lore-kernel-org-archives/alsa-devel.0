From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l52: Fixes for Beep Volume
	kcontrol (fwd)
Date: Mon, 5 Aug 2013 17:20:16 +0100
Message-ID: <20130805162016.GR9858@sirena.org.uk>
References: <alpine.DEB.2.10.1308051050270.5288@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6407925501272220772=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C56126510F
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 18:20:19 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1308051050270.5288@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6407925501272220772==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h/c57Cr0Q5sgaFFl"
Content-Disposition: inline


--h/c57Cr0Q5sgaFFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 10:53:31AM -0500, Brian Austin wrote:
> This patch reorders the min/max values for BEEP Volume.
> Also changes SOC_SINGLE_TLV to SOC_SINGLE_SX_TLV
> Add DB_SCALE beep_tlv for volume control

Can you split this into two paches please?  The reordering is a bug fix
which should go to the stable kernels but the new TLV isn't.

--h/c57Cr0Q5sgaFFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9C9AAoJELSic+t+oim9AjYP/2aZpWFLRDEoLsxTJ+on3IT1
Bl83AyCyLTE7Ew2quQCKeEHeOZS46mJYQlN2xHJwQ9Nm19wFyAKEO3OyUUwjS15X
sjtIVIkQ6TyRrqR6ae3jYZWnS4Eq4ytNTIWcaxnSFSbH9iJGFaGTFavqhfwe+dpx
s2W2y7T5zO50maUwIRz8niTrM1IKO0F7JDe5iUHIeCmE2Jm6ZzzqZ+zCEKcKGesS
g2OXqoA9qQyY2goU6P+k9uiqtViN8GoiSvFhnwrE82D05tiMfXLIdQfHwrwLiQ08
74TyfK5l70q421nrv4DADWB3kYazXOAhFaVAtleUTzBBJl1HOfa4Sj9ImnUsaVeN
nDaQL8eUHMkh4S0Nr6/SeZXqwfcuwo8P8IHtiuNsVCJ22RW8AjunVxtJYqzm01lS
0vdXPZYvJnI3txumjFwTyzhD24QYoExf1vKw8HsX/7BLdJVUYPGSA9DIllIm+c3y
6U1p0hMUxT5kbVt4sdX+kWPTAunS2Dme2aoRmcXeJoHyoFgDCTUV0pzzALHw/BfM
VejhdsvLFNxHSmJSSTkL6kgwC5OWhhYvht/2kmeP3J0P4+YoGHFb/wU+nEpS2REU
lVMgkBBWQuOqos2DKoTOx275ZR97CLg+NMQGuvbWz6SQ/qlJs6hVmJAO2KWje/48
Pn/Y3wOYZGbhyGff0Hdq
=TmU+
-----END PGP SIGNATURE-----

--h/c57Cr0Q5sgaFFl--

--===============6407925501272220772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6407925501272220772==--
