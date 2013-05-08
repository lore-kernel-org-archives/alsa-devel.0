From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Mark CHIP_ANA_POWER as
	volatile
Date: Wed, 8 May 2013 11:40:11 +0100
Message-ID: <20130508104011.GZ7478@sirena.org.uk>
References: <1367958018-4827-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0779256282451638889=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF60261658
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 12:40:29 +0200 (CEST)
In-Reply-To: <1367958018-4827-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============0779256282451638889==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JefYhWJ8RkX3aR0a"
Content-Disposition: inline


--JefYhWJ8RkX3aR0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 05:20:12PM -0300, Fabio Estevam wrote:
> Register CHIP_ANA_POWER (address: 0x0030) contains all of the power down=
=20
> controls for the analog blocks.

> Mark it as a volatile register, so that sgtl5000 can be functional after a
> reset.

Is this register actually volatile - in what situations does the chip
autonomously change its power state?

> Without this patch the following error happens after a audio playback fol=
lowed
> by a reset:

What is the mechanism by which this change fixes the error you quote?

--JefYhWJ8RkX3aR0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiiuIAAoJELSic+t+oim9ce4P/Ay0F6DvIXTkXFePNFqFfOfv
Ua9SBG+sjPc8IM/YxG438F/6iUbkg+ECOHMIEm78kzGAgQKI7NhL/SePOJBKdGz0
xeleecXhWgw2ZYT00ly9K2wcou38O+1gpipSovEVgwCgduI2YsrsGAM4FkYlaDCY
0xBgMvq0KABdOxp/07yc/FzAUKCnQ/A1dO2A2hlxL0VMF0AK5bUsk/Xgam2jZXMU
BkwPYdv+u1DRbJf5KhtZAnnoNeAxtI8IRqs7Eu8jIiccfQmAmtJfr1ZcAgmQtOEx
EnS6LGtfaWMv0GwUVXmOMTqpwnLWamrNRZdKoqhBGEmaSa2xa2xxLyZn3zH8l8f3
O+mR9SllmFB53lVuDreW+OdYt8FGzqGEGMe4vrcLQeJQ1ZH2upcPpipU/Hua0WQP
4Fh2cuzf029nKbIwzUQLaOTClAZ94g/lIzwlFuLUHME5GsRNlKzNDWFpRJR6cTLU
6u4RWWtEJJll36stsRnQAJb9niw2F/qFzjrUjzgmSmP7zCPRGvlwyAAnBkwuyi1W
EpwLkxELP24/NzlqD81yK3L2AIhl+D+SbBRosU61ng9awYW6N8yu3A44nj/XS7w6
sZ2KMmH/kd2jptBUOHN+C9C4H6PZrpi6rUNZq3V3mHzPdNv1nsfIBk/M29CbRUnW
foesBGkxb+MIq46h3skk
=vAnI
-----END PGP SIGNATURE-----

--JefYhWJ8RkX3aR0a--

--===============0779256282451638889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0779256282451638889==--
