From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add missing registers
 and bits
Date: Tue, 26 Jun 2012 17:33:44 +0100
Message-ID: <20120626163344.GW30406@opensource.wolfsonmicro.com>
References: <4FE9AD5F.7080302@aksignal.cz>
	<20120626132117.GV30406@opensource.wolfsonmicro.com>
	<CAONxwYPutt+Tqtt6dKgS1x-c17_czu0_r+hBwQR262sYgzxgdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2708303720800207216=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D799024398
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 18:41:15 +0200 (CEST)
In-Reply-To: <CAONxwYPutt+Tqtt6dKgS1x-c17_czu0_r+hBwQR262sYgzxgdg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roberto Nibali <rnibali@gmail.com>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2708303720800207216==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="msgLTjjeumHWYklJ"
Content-Disposition: inline


--msgLTjjeumHWYklJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 04:56:27PM +0200, Roberto Nibali wrote:
> On Tue, Jun 26, 2012 at 3:21 PM, Mark Brown

> > This is essentially impossible to review as you've not said what's being
> > fixed and have completely reformatted the table so the diff doesn't
> > highlight the changes at all. =A0What's wrong and what is the change
> > fixing?

> This is merely a match to the data sheet of various TLV320AIC310x
> codecs. I've planned on submitting almost the same patch a couple of
> months ago. The reformatting to my avail adds to readability, no
> values are changed. Only a couple of 0x00 are added for the missing

This is irrelevant, you shouldn't be putting several unrelated changes
into a single patch.  It's bad for review and it's bad for reading the
history  Mixing minor style changes with bug fixes is especially bad,
whatever actual changes you've made are essentially invisible in all the
reformating.

To be perfectly honest I personally find your new version less readable,
having more numbers per line means more counting is needed to figure out
which register is which.

You've still also not clearly described what the actual changes are...

--msgLTjjeumHWYklJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6eRfAAoJEBus8iNuMP3ddmIP/0FT10xAz0Wj/9mFB4hyd79t
bwni2elaXsmnRPFmNaagvndxO5REcPwNO6kiaLfHQt3nD09XSe6mmEnYnjQ9K0+w
HVD5yhq1dy3EUVEzpJzqFkGBEdJobMAlmbDvdu2O5XK29+eaEzitTsb6e7n+6HYW
PC5nd1tgU+qOV0npFS0Sw+vzWVEYQ1oV4pdLMqLNN8sqLR56+4sBMfnqU1bMK2Tf
culxfrFqq7iuAgCZTmj+tQbNP76n2fZiD21GpuZC59AJvbsMo392UkfPiOgXuMSS
3U653rJ+6L/aXGHmxx8J95/g89H3frJkZPDGthtVD1yBOuWjLJI72IB1vbP4Wi4J
ldCUI8v5lbYMnQozWYaoaGjwngJlr9yMTMoNNyUiyjeiXPdtDs24uW8bX4Fzu7cH
J+q3sxunWqMBMsLYQjMSkklfJr9y943GrTVlFsOO3+g5u3YmBTt550A48fa9IHl3
BoLNLUQ4txCEVzzhVzdAaYlUjS5u2sZHKthj0DcNzlPPeIScysU18jdeXYgkVlnt
q3TiSwMcjL30KuMiM/ttgarfBAvFoI2OEbavgswJxdTvXXmNqJDTtvsjRktIhBsl
kIquktDA6TbMjbiyDJfmCL+V/CzNu6N8TiN3PuIwsX9ZjoCNOTlgi2k7VhyuKt6Z
LdwsgZDhu+7Rvy/YNvFm
=LcvE
-----END PGP SIGNATURE-----

--msgLTjjeumHWYklJ--

--===============2708303720800207216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2708303720800207216==--
