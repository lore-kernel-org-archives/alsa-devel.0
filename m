From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.5
Date: Mon, 11 Jan 2016 16:02:02 +0000
Message-ID: <20160111160202.GI6588@sirena.org.uk>
References: <20160111152020.GG6588@sirena.org.uk>
 <s5hd1t8yw0w.wl-tiwai@suse.de> <s5ha8ocyvm8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2352344195128188647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62B672604BE
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 17:02:09 +0100 (CET)
In-Reply-To: <s5ha8ocyvm8.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2352344195128188647==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3fquP/57BBR2yLsK"
Content-Disposition: inline


--3fquP/57BBR2yLsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2016 at 04:38:23PM +0100, Takashi Iwai wrote:

> Looking more closely now at the commits, I don't find new drivers
> except for AMD ACP.  All others have been already merged in the
> previous pull request, and now we have only fixes, as it seems.

Interesting...  git is being very strange, if I generate a pull request
against your for-next or upstream branches it shows all ASoC changes
including those in asoc-v4.5 which are already in those branches.  If I
explicitly generate one against asoc-v4.5 it's just the AMD drivers.

--3fquP/57BBR2yLsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWk9H5AAoJECTWi3JdVIfQr8AH/1U6G8x7+dKF24JoYBOrBtTI
JsMJ6tiG+OQHLF2svXzuOJWiwnOmwg4Z+GNyhtSxzD5fZzSdi5Qb71EC8GbRrk4p
KDlewh9YoXkSsCKI2y3Mn1t0Bqz730Q7bZYSa9T7wSWAGkHwylMNTitHCFMmR1Sr
un1fULvmzD/QBPkoyPlFytnARWT5JHL6QVWzXDd5dQtgt/Xj46NiEPCjetFVMIEJ
+lpiOzcF4iwWSqu8MyBbeeRxaG0odUZ/hK4MPCE28id9zs60qokVElsY2jnNVpxI
WPTg3Cc3dW3EY3jzTAUkwk93mi4xn75jdQGwpvarVnEOJIUTNY5iDOx4Vz62Ai8=
=Xp5k
-----END PGP SIGNATURE-----

--3fquP/57BBR2yLsK--

--===============2352344195128188647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2352344195128188647==--
