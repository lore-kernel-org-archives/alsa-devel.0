From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unnecessary
	device_remove_file()
Date: Sun, 8 Mar 2015 19:46:48 +0000
Message-ID: <20150308194648.GA28806@sirena.org.uk>
References: <1425753308-28695-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3181561146992819051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 869C02604FC
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 20:46:55 +0100 (CET)
In-Reply-To: <1425753308-28695-1-git-send-email-lars@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3181561146992819051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgVZo3zXaTQrZhjg"
Content-Disposition: inline


--bgVZo3zXaTQrZhjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 07, 2015 at 07:35:08PM +0100, Lars-Peter Clausen wrote:
> Since commit d29697dc3b92 ("ASoC: Add sysfs entries via static attribute
> groups") the sysfs attributes of the rtd are manged by the device core and
> there is no need to manually call device_remove_file() anymore.

Applied, thanks.

--bgVZo3zXaTQrZhjg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/KcnAAoJECTWi3JdVIfQ6hQH/2gcpWmwUY5P/hb6VAPrlKSB
3ESuDeB3619A71sC/DVL5YAcnvNBORyKmTh8/Qz7hqO1dsEVL+EVpPhdANyN7r7y
zlO1d6dmpSWAeAEX8G1Ch//QIkcodkmzY+pqceFnPt4p0cwBLr6xvMFKhm9pMa/h
WiVBrXTKxwsAtUutPA9VnKT5s8+BbgoDvu5Ysjc19413/9NMcuBQ+ynSvIUEIcy/
APIelmnk6VUIB2prdKrouyFTTp4mE4sgialvo1/7l4dw2vkuroP6IdbDQINTGaFW
8uJHnOkAzPCiUAcV++xODMWP3MtdEyif8CdQVZlMLDyyLFZJ1+mXZ8d2p9Uo0Og=
=jjdK
-----END PGP SIGNATURE-----

--bgVZo3zXaTQrZhjg--

--===============3181561146992819051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3181561146992819051==--
