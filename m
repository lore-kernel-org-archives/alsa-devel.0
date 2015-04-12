From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: n810: Consistently pass the card
 DAPM context to n810_ext_control()
Date: Sun, 12 Apr 2015 12:45:41 +0100
Message-ID: <20150412114541.GC6023@sirena.org.uk>
References: <1428742078-9704-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0549347704223390675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14EA32605C8
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 13:45:51 +0200 (CEST)
In-Reply-To: <1428742078-9704-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============0549347704223390675==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q4jrepk2VNZYINwh"
Content-Disposition: inline


--q4jrepk2VNZYINwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2015 at 10:47:57AM +0200, Lars-Peter Clausen wrote:
> Some callers of n810_ext_control() pass the card DAPM context and some pass
> the CODEC DAPM context. Given that some of the widgets that are accessed in
> the function are in the card's context, always passing it is the obvious
> choice.

Applied both, thanks.

--q4jrepk2VNZYINwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKlrkAAoJECTWi3JdVIfQi5YH/RHB4JLdKz6n/T2Fn6SBAyqb
sdLZAVL5LETrKaAwATo5sWN4RDmdTUniiKWBVrfW6MdtImpyY2VOgdsTyrmIgIaY
WkyLB/RcgKMXuqzzpX1GwTaTtLUB0EAytekGTGjKYCPtNOIm6GSLrinxnB5mETgf
LEf8JLr+bh6aRM6j6PTRpY1J/wN/Uui5yndKyNd5hwv4pbsJysNp0h7EyZ5T7VF9
H7X2Zn9u6JoCVl9giis7H83B9xjk8NOsFKz085VGWf5M7k1rAI+/Hdf3mwzgp+0c
b2B0vbhVHAEhxOBNp2L2eCJcth+YpOlia8+bq5zE5XlBPucHe27dN64Zu/s4RYE=
=OpnC
-----END PGP SIGNATURE-----

--q4jrepk2VNZYINwh--

--===============0549347704223390675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0549347704223390675==--
