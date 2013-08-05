From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: Add PCM1792A spi mode codec
	support
Date: Mon, 5 Aug 2013 18:02:44 +0100
Message-ID: <20130805170244.GU9858@sirena.org.uk>
References: <20130803142043.GA13830@panicking>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5632900813752978999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 324B126508F
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:02:47 +0200 (CEST)
In-Reply-To: <20130803142043.GA13830@panicking>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5632900813752978999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y+HvVzgSYPr8J+Me"
Content-Disposition: inline


--y+HvVzgSYPr8J+Me
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 03, 2013 at 04:20:43PM +0200, Michael Trimarchi wrote:
> Add PCM1792A spi mode codec support. This version implements only
> a subset of functionalities. Tested connect to a pandaboard ES
> device and based on recently pcm1681 codec.

Applied, thanks (having sorted the Kconfig and Makefile entries).

--y+HvVzgSYPr8J+Me
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/9qxAAoJELSic+t+oim9Mk8P/0YsJvdz16aqErZr+p83QGXE
G9L4pEaP4giSS7uY+X6Sy+a+QhoMpAcYCbNQ37nEx1G97irNbk9VYjL+5xedMBXF
8DWCWo2jlu0UpYT9E89f66rjWSadkMwQEYs1T6kkcCPJL2A82adcgG+j4Z6d5OkL
nOlXIddJvjf5mPmoUWzMHExWN1EXCpWT2GKGCwYkBH1tvu4fg49XZyMyhaGsXRTw
aDnAkG0GxSeOG9Su7s1rblNb9cor7zmEm8/ssqcbS/HeWqqadSMlnL/D5LrdH6qs
HkHTnYZXLY8VqXvahpbqrlI7oTNPlxPRKQuE5TAEwytEFpZT9ukZPZzKml9kOtfX
Q5zrPxY/AakqBqvvU9GVK/WJ6QDPCJ/cKjDhqQy28A0pNSc2u8ZG4K6AV+S/D7o7
gYDUNlDhnAmIKiDqUGsEnXJ8KN0qtwOSrWWTfH7lxSXHAgX54f/OOtebE6yV/vLR
Ln5rOFg9cwvMcv80yRjuuwzwS0QJacVZKf0AStBRvJzBhXP7HB3hxT/PuRmjchgX
XR2ISgM+EN3qD4mPKEtVOL3iE/kByy5I/34ETrufx7VcCTb7cdaXDn1PwEMPNoEG
dNEChLXOcGkUMSPm9xNNRVEeEaPo8Mee5sMqQV8EFTPdrnxPiHvCqnnTCZPeUqC2
8l8yh1EF+GAIrkHVEvvp
=wfGH
-----END PGP SIGNATURE-----

--y+HvVzgSYPr8J+Me--

--===============5632900813752978999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5632900813752978999==--
