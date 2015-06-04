From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/23] ASoC: tas2552: Fix kernel crash
 when the codec is loaded but not part of a card
Date: Thu, 4 Jun 2015 17:50:29 +0100
Message-ID: <20150604165028.GK14071@sirena.org.uk>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
 <1433423075-14142-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4515062475952416136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE0826061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 18:50:39 +0200 (CEST)
In-Reply-To: <1433423075-14142-3-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4515062475952416136==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q3YFxXYBXviVjKLs"
Content-Disposition: inline


--q3YFxXYBXviVjKLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 04:04:14PM +0300, Peter Ujfalusi wrote:
> If the card is not part of any card the tas_data->codec is NULL since it is
> set only during snd_soc_codec_driver.probe, which is not yet called.

Please put bugfixes like this at the start of the series.

--q3YFxXYBXviVjKLs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcIHUAAoJECTWi3JdVIfQ9QkH/2/6nefc++XgBvEr74RNA6QU
UsSVrkZj0y379UGg8Thje+BD8+rIMLvURUtWUVfXZia/96uwGfq8qFXacehxbhJP
zXPPFNGCE238R5mZm+0C0L032ZYT+2OJ7v2yQYFy3bOLeukkob6U4NWVSOXTIbQR
wO9Qs4fI2vGqzKQ3rnm3Wv6Az1Dgd4qHiWLF3y7p9SwjwXkzACo7V8SYlkEh7Rjo
rH5FJZVVoU2VdVW9xEDpFr+rGVf1Le9tBAmhNAdrTZkDBauoLTse/RhFwb0l3Rc6
sNqrkitwunfQtKg1ZO0MbdKppRXHdrGihqgahw68G0c5YTytuR7+/5yFYtLUoJs=
=VAlW
-----END PGP SIGNATURE-----

--q3YFxXYBXviVjKLs--

--===============4515062475952416136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4515062475952416136==--
