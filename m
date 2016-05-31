From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: nau8825: non-clock jack detection
 for power saving at standby
Date: Tue, 31 May 2016 18:48:44 +0100
Message-ID: <20160531174844.GM29837@sirena.org.uk>
References: <1463970340-27548-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1368395357144715160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67A9B266267
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 19:48:49 +0200 (CEST)
In-Reply-To: <1463970340-27548-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1368395357144715160==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lPld9KzQhYxXHcUh"
Content-Disposition: inline


--lPld9KzQhYxXHcUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2016 at 10:25:40AM +0800, John Hsu wrote:
> To resolve the conflict of the first verion. The information is as the
> following.
> > > ASoC: nau8825: non-clock jack detection for power saving at standby
> > > has been applied to the asoc tree at
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20
> > This seems to conflict with some power management fixes in Linus' tree
> > so I've dropped it.  Please check and resend.
>=20
> The driver changes jack type detection interruption to non-clock archi-

Please follow the patch submission format covered in SubmittingPatches,
don't include administrative things like this in changelogs but instead
add them after the ---.

--lPld9KzQhYxXHcUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTc57AAoJECTWi3JdVIfQERAH/3/Pawl+M304Lyriv5RmUMSO
YZ/DsvBb22JcXPKKjSXe3T1KXpvq6nIKGN8kCAW29xFIACrPHQZt8u3alIB+AR+5
sps5JFYrlPEX2UxD4g4NoIoNDNOBdkRJBqmBBwcrtXyi7gBdmrKpz7kL3OsZERmr
BkVzWF5NWMlxmgCqLG6Z+upYyn0jBMwpJNSHYCMeWMZxlip6zFqrZ9JNo4Zizjry
6RSE06xzq/V6Pp5Oa0+wAJk5Wv12fn/Dc21SRFL3yOfkv/g7bsfmYJvGGS2I7OWh
HpEQHpuwFSWrtCCcA++u9q5MBIycCchyi3JLFhtx/SZv94HsDzxs4+060/cCTwA=
=6iTH
-----END PGP SIGNATURE-----

--lPld9KzQhYxXHcUh--

--===============1368395357144715160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1368395357144715160==--
