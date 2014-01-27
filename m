From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Check clocking during
 hw_params rather than startup
Date: Mon, 27 Jan 2014 10:55:08 +0000
Message-ID: <20140127105508.GW11727@sirena.org.uk>
References: <1390582753-1026-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <52E2A1F2.6070707@metafoo.de>
 <20140124173754.GD11727@sirena.org.uk>
 <52E607FE.8010807@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9175586508293776601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 39363261685
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 11:55:18 +0100 (CET)
In-Reply-To: <52E607FE.8010807@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9175586508293776601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="my6/OtttYtn8dhky"
Content-Disposition: inline


--my6/OtttYtn8dhky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 08:17:18AM +0100, Lars-Peter Clausen wrote:
> On 01/24/2014 06:37 PM, Mark Brown wrote:

> > Thanks, that's about what I was going to write.  The current theory is
> > that setting the sysclk to zero is the equivalent of a dynamic SYSCLK
> > flag - with the extensive use of charge pumps and so on in modern
> > devices on the fly reclocking is normally difficult to do safely so the
> > idea is that if the machine driver is in a position to reclock it should
> > set the clock to zero.

> It's a bit ugly though to set the clock to 0 in the startup callback of the
> machine driver and then set it to the actual sysclk in the hw_params callback.

If something is doing this I'd expect it to set the clock to zero when
it is idled rather than during startup() - set_bias_level() is usually a
good place to do this, or possibly a DAPM widget supplying the clocks in
the device if the clocks are visible in DAPM.  That's a bit nicer and
doing it on startup runs into issues with things like bypass paths
anyway.

--my6/OtttYtn8dhky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5jsJAAoJELSic+t+oim9Th0P/iXko2UHvFH1SjEvlBx/++qM
MYOD5eD0ZSp0FuRQqOJXlRWRocfJEvWOZY4NeiAq/9OjMNB/MQb1/P+EovjMLUWj
FvCyDQ6PPH9wN6ufL+9k9g9LLPF91rWjJZ0mImz/f2vCH+A0WJnhkqBKZlfVeuZM
3N9YgGlTyorgysWBuLCORfsKdEW3e/GIMC3OML4jqktnxyYOoxC9I/g4zgP1cYPl
y8XTbfrx9lZ52Brz1Y3GFtQOYmEJHcP9yZiJoRa8CjyJTs/4JaqGcVgD/fjGpHoB
hQ+LGO+BH+61gfCAqMsrXt2n0dlYcWcGTJGLQzXkh9+003AiZO6dsvowT37Dxosc
aJKEkjHSAalXGRj8ogQwHqOyiYbvY/G7Fc2mUaXwy+BJBUm43CNOB+E62GwpL2di
ao1+HWJsswJdSpvT54r1ML4mDWreLXbtjBPi2ki8168PIxJ0GX/XycAFuCDiyaLU
UbNhcb6ZqdVQGUc2x54NSufSTlUTVKdCNqbi0756t+dcDmRf7gpwTWw+uODUKoGV
l+uKWwh3PGfGttb8V6wyQeLKy25qB2a6T8u/gP874Nr4mW76Zgbx66S6Xcvh07al
qaklar6nzdY/VG/msxXjRYsSxEJA1xUuwxWr5UCWRGHE7+WP5l6p+cNgIGWUk/ix
FblhfnDoXl5d0QEqCIVq
=aL1t
-----END PGP SIGNATURE-----

--my6/OtttYtn8dhky--

--===============9175586508293776601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9175586508293776601==--
