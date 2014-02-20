From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 16/17 v2] ASoC: pxa: spitz: Update locking around use of
 DAPM pin API
Date: Thu, 20 Feb 2014 19:54:11 +0900
Message-ID: <20140220105411.GR2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-17-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A87vX0WQ/g4QfIpk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392736948-26623-17-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--A87vX0WQ/g4QfIpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:27PM +0000, Charles Keepax wrote:
> The pin updates in this driver look like they are intended to be done
> atomically, update to do so.

Applied, thanks.

--A87vX0WQ/g4QfIpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBd7QAAoJELSic+t+oim9w1MP+wT9I9PDraqF2JpTqhnyK1hW
MvUE+gWw48BpmrqDA1uDmo77ptE7NxYg1nUGWhrTxYYE44yKvwmDoPKF2NFS/iKc
kBGm7tvendbrRU/8z4MhFZOUOsmIOmE610FNfNZpaheVgvsiL3jPW9wAZzot3/tC
5kIdNzk0HAFaQjg+IXvu4Df1ucjnU3StsGy/oW3IyM1RdZZUfUvuFm+SGNy6v70M
zMnfk7AUYYWH3c5/f05Ax8WMUbldAIH503ByHfKsWFBJy0ZxCzhGi2IP0ov0rmJy
W70/ti1FXC1DvssXcCe6dlIU5S6Kz6atC844/OPLAVTeZ5gfwxMrapsn2YHvp8C8
QvMhgtOpHV8JgFWoD0FWn/Scr7tTnT8xlB1/Md2s/bdW/rZaIoTyCjEQp6Myxdyk
j3xaYNHJ0BAwdzH+5FXMwjNnSR0PscFL+39VlKIonSyzOR0/UMSYz/WSC3/GydRA
iI4ZQGUPrdTi6os94TQ7M89l9KIBB1gxu1wtqBHny6Q5lK+Dyicswf4cy9NLC76L
FV6y/U3z7Oqbqr9AvC9JHIFQxqZwfNaniFwcqd8S8Gzj7cVOZvJ7OYTd8kiC0U3I
EGSMLx0gy3hucCvQHCzlN5yg7vcyFlGDM5CwcmHWHBcDDvSBb8BH4PNwcYzFNt9t
axBhWz92/9R18MrUbcig
=8AnN
-----END PGP SIGNATURE-----

--A87vX0WQ/g4QfIpk--
