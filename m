From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Fri, 25 Aug 2017 10:24:26 -0400
Message-ID: <20170825142426.GN2827@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <1503669407.25945.102.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1805623791241116321=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BE9D42673DA
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 16:24:15 +0200 (CEST)
Received: by mail-yw0-f179.google.com with SMTP id s143so13751103ywg.0
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 07:24:15 -0700 (PDT)
In-Reply-To: <1503669407.25945.102.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============1805623791241116321==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6vqABX3nJKXLk01"
Content-Disposition: inline


--i6vqABX3nJKXLk01
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 04:56:47PM +0300, Andy Shevchenko wrote:
> +John
>=20
> On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> > Not all devices with ACPI and this combination of sound devices will
> > have the required information provided via ACPI.=A0=A0Reintroduce the I=
2C
> > device ID to restore sound functionality on on the Chromebook 'Samus'
> > model.
>=20
> Tom, one more question.
>=20
> Apparently you are the one who tested the commit
> 	89128534f925 ("ASoC: rt5677: Add ACPI support")
> year ago.

Yes.

> The commit states that ACPI properties that are used in Chromebook Pixel
> 2015 is non-standard (not the same as for DT).
>=20
> However, DSDT shows the opposite!

Interesting.  I'm not an ACPI person, I just tested what John came up
with.

> I would like to ask yuo and John what is the status of that currently?
> Do we have any publicly available laptop with non-standard properties?

Is there any sort of "build date" or similar in the dump I provided
yesterday?  Every once in a while my laptop accidentally books into
ChromeOS and then it might grab and apply some updates and it's not
impossible that Google updated things in the interim.

I'm quite happy to test patches or provide further dumps / etc from my
system.  You might want to start by talking with the person behind
https://github.com/raphael/linux-samus to see if they know more about
different versions of the hardware or at least point you towards more
testers.  Thanks!

--=20
Tom

--i6vqABX3nJKXLk01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZoDMaAAoJEIf59jXTHXZSpE0QAMQ0fp58U6Uba2kTmh9CMZz1
gJVRSyg48xYSi5hmcM6IYUjJd8SR64qyflvFU4bWIknJYCnmnYlw99gpxomysMXy
4fLkk6xh9kyM0vmyz6Jy73eojTowj33+mttlKlF2xpvkgnGl3v8iUbLzzNQsmLpx
bn72bJO7tf2EAvMsQeIJfP+xfQliYzrXqLwhZj1bGHww5RT1t3qfYfiiRn2fzeJt
ewLkZ3CKzVdsLU+vE7ySDkLuHOzoAYdV6MnDzAUnviHPe9fYpxdZ94kMJD7UqFuN
EbcRuys2ZTKGxvWcDjjlXUdZ3k96ZJAP1qT+cZ0XAHZUw6BzVSOrs9b1J4Y10G9x
0WRGuqqRV7St00CYyOVO87BI6jix+UjhIsVd8G7Sho48NnvLPfnCp3t7KUbB/1Z+
lXXtANgmaQuv5w+r4TXOcjldXEVu9X4NIGvzmD1FqgwcScvsxGQwwUntOq/WkApa
zqPosGEcq+oG5on7Q2kVs1Z1ygUimg1j9IhcQ3Ej/Uor23GYJC3waq9G4QUL5HHH
JITjdzsGFfCWNWZ2eNKaTT+1DkDS0hI989eV4xbpiDNtpAfe8r3uSOvQmPDOzfAx
rq5ldC82MqdVANy75QimykitgAdoWJIYd3AUVkj2Y+h/SHUs8ViByLaQNWBN6LnZ
/vv8uSDONJzGZ/Uy2YtE
=Jt/Y
-----END PGP SIGNATURE-----

--i6vqABX3nJKXLk01--

--===============1805623791241116321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1805623791241116321==--
