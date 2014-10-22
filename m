From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/12] ASoC: dapm: Reduce number of checked
 paths in dapm_widget_in_card_paths()
Date: Wed, 22 Oct 2014 12:02:46 +0100
Message-ID: <20141022110246.GS2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8657448142883898760=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 70F9E2651CB
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:03:07 +0200 (CEST)
In-Reply-To: <1413826604-3212-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8657448142883898760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vy6UCbb9EK60RK4A"
Content-Disposition: inline


--Vy6UCbb9EK60RK4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 07:36:33PM +0200, Lars-Peter Clausen wrote:
> Each widget has a list of all the paths that it is connected to. There is no
> need to iterate over all paths when we are only interested in the paths of a
> specific widget.

Applied, thanks.

--Vy6UCbb9EK60RK4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR47VAAoJECTWi3JdVIfQ7mkH/0xLsjJs9sc6hbg14pVu9Xao
X/sm0FkBCTuyUrOD5/bANJ/om5i/XXdlYwaNhn+M654Z3mWoO6Co/qcTvKPNGDIf
HlXM42KObHWcZaV6y6HP8RkZi3tNH4yiLkJ8nAbOIOfbr+AuF0nXVWFJ1w9zppaC
PaFdcikJHfXlZSzue8A4cbLGL0mLqjlunFXIGOOTiYiCBk0yBT4l15DzIZoqku4v
f28bil9PvmP6pu8Feb37FpnbF4vqs7U0BNYX0b5Rwwi3tTq/2788ZqmBJbkoXjBX
kepzgpXKQl7b9wjxgo5703ybKu6UslnSJimAzw+AGhFDVR4/Fhx3lLTMGO8XP+o=
=Y5dp
-----END PGP SIGNATURE-----

--Vy6UCbb9EK60RK4A--

--===============8657448142883898760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8657448142883898760==--
