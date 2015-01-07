From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5670: redefine ASRC control
 registers 0x84 and 0x85
Date: Wed, 7 Jan 2015 17:42:44 +0000
Message-ID: <20150107174244.GD2634@sirena.org.uk>
References: <1481c597e90b5daacce80a021fa0c513a7a2ec6d.1420451186.git.mengdong.lin@intel.com>
 <1420597146-4101-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7555336030780867113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 341AE26053B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:42:51 +0100 (CET)
In-Reply-To: <1420597146-4101-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7555336030780867113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QrilSTA3tze2H7Dz"
Content-Disposition: inline


--QrilSTA3tze2H7Dz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 10:19:06AM +0800, mengdong.lin@intel.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> The previous definition of registers 0x84 and 0x85 doesn't match the data=
sheet.
> So this patch removes the wrong definition and writes a new one for the t=
wo
> registers.

Applied all, thanks.

--QrilSTA3tze2H7Dz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrXAUAAoJECTWi3JdVIfQ5rQH/iIohxwwNGFEIMDrNbMj+lQm
ssGyA93ubddlDdODDgt3bWYlMmInVJyqXAYqb+GGp8UhEpoizdz/Xi4/0M5zoKoE
4XurJtV86dKWoUM7B0kqkEK6gYg9RvF/YBDhwJ2Brloc7wrQ5ZmfGX/ZFOQ/jGnf
hWVZFd7TAgeDg3G0rSuW7nhPhUkCbMp852Fn9jmQl3E36+ZNkfkLc9+rF7k1pvI5
ewQsumINAKY53uObC8uJgyEbD2sm7FeSyPJsLMXIVjhz+eu+tNxxh48h3fOnbrLR
L2u1EpBcqQy5aFlBZsmWHwG0/OEmuP4v3OirTshPgBMPcV9vgBx2MIevDp13Bkc=
=nvAk
-----END PGP SIGNATURE-----

--QrilSTA3tze2H7Dz--

--===============7555336030780867113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7555336030780867113==--
