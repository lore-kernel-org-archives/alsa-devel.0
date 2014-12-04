From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: do not hw_free BE if it's
	still used
Date: Thu, 4 Dec 2014 22:42:09 +0000
Message-ID: <20141204224209.GC11764@sirena.org.uk>
References: <1417572823-22420-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1572346556364970220=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36FA826042C
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 23:42:21 +0100 (CET)
In-Reply-To: <1417572823-22420-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, shangll@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============1572346556364970220==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 10:13:43AM +0800, Qiao Zhou wrote:
> Do not free BE hw if it's still used by other FE during dpcm runtime
> shutdown. Otherwise the BE runtime state will be STATE_HW_FREE and
> won't be updated to STATE_CLOSE when shutdown ends, because BE dai
> shutdown function won't close pcm when detecting BE is still under
> use. With STATE_HW_FREE, BE can't be triggered start again.

Applied, thanks.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgONAAAoJECTWi3JdVIfQOF4H/3gFymr8/wOaixqXuTMDwNJ+
p4Qv10NYiZRprcAPU//1FSiyv+hB55CE3YCqXpHZt5ou/Y56nHdOoRFQRIxeUg/L
OpoAF5ufvPQRS8LLT8pBqT7Li92/RiOsNcFKMBHkVEP5GAqVCaUWuuGpimDrt2Kn
pkcT3EEYgHPC6lNhv2fsrypAnXey9862IJWW50R2ib1QxKEktCUzUGF2b2FoeGfO
211BgBQxSO34dKfpGGRAUCw3j1u2kYWDq+DWsosaMkkIQXgIkctFK/Q/e28npRa4
mvvuOg96/sylc7U1n94gNE+ZwPsT/89WOhiv7hqWSq1fppQtHEemYvdd/0jgnEQ=
=Tshf
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

--===============1572346556364970220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1572346556364970220==--
