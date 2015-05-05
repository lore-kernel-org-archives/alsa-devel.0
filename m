From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8741: Add differential mono
 mode support
Date: Tue, 5 May 2015 14:57:31 +0100
Message-ID: <20150505135731.GF22845@sirena.org.uk>
References: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
 <20150504112537.GA15510@sirena.org.uk> <5547C29C.9020905@gmx.de>
 <20150505112239.GD22845@sirena.org.uk>
 <B33D8E95-F8F9-40B8-B9BC-6AA8734A4838@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3573162692290954840=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CDEE1261A50
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 15:57:44 +0200 (CEST)
In-Reply-To: <B33D8E95-F8F9-40B8-B9BC-6AA8734A4838@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============3573162692290954840==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wm9uNZQrF3vwH8GG"
Content-Disposition: inline


--wm9uNZQrF3vwH8GG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2015 at 02:19:38PM +0200, Sergej Sawazki wrote:

> The mono mode of the device should not be confused
> with the ALSA mono mode. If the device is in mono mode
> it either plays the left (mono left mode) or the right (mono
> right mode) channel.

> My board has two of this DACs (left and right channel).=20
> The control names should be different, hence my
> suggestion for the "Left" and "Right" prefixes.

That's fine and totally normal.

> Another approach would be to say that the machine
> driver is responsible for mixer controls if the devices
> are in mono mode. What do you think?

Yes, the machine driver should do this - you may have left and right on
your board but these configurations are for example often used with 5.1
systems.

--wm9uNZQrF3vwH8GG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSMxLAAoJECTWi3JdVIfQHL8H/RvAv5IX/ReqSVQ5SeRVOOle
EY7/RYEFjn0y45QCjM8lvxxnnP7wVGd7POenTtn+zCqZ7M3puKV0WeKpZJls1IyM
DqiZOvPGBDwDb8tXzdMRqQbTcDA5K8D3eDEYjT7ekWvnNurwBIdYA8gLNK+fwt2r
0OiuSpTGtHQR8+doldBQ5ouIdr+Q26U2clzasSo1PUn01VQM/tFPUwPHnsoh8JEk
Pc6vYut+woBpzgspK3O1M2hoLTF/7EZGZLhSXOIGDjZ4DJvgak+q5Uy+AdsH2GTv
0XsKRH8Gcw2RSpzT7LJSo6BoU3JRRlNeEdmmxgTVlnDCE9dejIQdtwMbYKya7xM=
=UXKj
-----END PGP SIGNATURE-----

--wm9uNZQrF3vwH8GG--

--===============3573162692290954840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3573162692290954840==--
