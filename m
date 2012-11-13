From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs/wm8978: Only reconfigure
 GPIO1 when used for PLL output
Date: Tue, 13 Nov 2012 15:44:15 +0900
Message-ID: <20121113064410.GE18224@opensource.wolfsonmicro.com>
References: <1352482418-64950-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4420491357545308970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09FBC2650BD
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 07:44:23 +0100 (CET)
In-Reply-To: <1352482418-64950-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4420491357545308970==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2012 at 12:33:38PM -0500, Eric Millbrandt wrote:

> When GPIO1 is used for other purposes than PLL output (GPIO, Amute, etc) the
> driver incorrectly reconfigures the pin to input when the PLL is recalculated.
> Only reconfigure the pin for input when reconfiguring the PLL and GPIO1 is
> used for PLL output.

I'm really having a hard time understanding what this change improves.

> -		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 0x30,
> +		/*
> +		 * GPIO1 is used for OPCLK, reconfigure into default
> +		 * mode as input - before configuring OPCLKDIV and PLL
> +		 */
> +		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 0x37,
>  				    (opclk_div - 1) << 4);

Previously we weren't changing the pin mode at all, we were only
updating the bitfield that contains OPCLK.  With your change we will
also change the pin mode to input, but if the pin is doing any form of
output (or anything other than input mode) I'd expect this to at least
glitch things which seems actively harmful.  Why is it being set up as
an input?  Though I have to say that all this handling of the pin in the
existing driver looks at best odd.

Your changelog describes what you're doing but not what is being
fixed...

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQoew0AAoJELSic+t+oim9ip0P/jobWt3r6rOiL/l99B9OaOVH
uoj8JM3oLz4yFZO1wcBtpJwlBL86jk0uVN9HcFHHIYFe4Ex2WSCNl4F06ywNjvQz
/TQns+eJ+LyowA9j3cUg5UpQfHErffIuA9Y5FuIUdEWQ+Iryi7NmSvFpg8cCIQkh
kRnWh3O7Vh/ERvP76w+jcgunO7k+ZoDbDxtz69ii5RM2WR7kmsKkgLmi4m94nVgg
LHAvP14MBIhN5OD7Nl3y8t4wa9pxmwk0CiBtQl6fMf55r19GwVD7rihUT0Thupp8
mkTHXaLv2wbAbKBONHHj393l9L46/luWNu5xP7Grsmg0yfaETXkbKZrWgcD0DJLT
DDrj+hPQgrK0aZBzRkphkkZYtwZAFOKpXuqXwY3MNAMvKp37HSg0Rp1LMZIVvUib
/IxlYYgQBwAnqJLtndoLNck37BjIlyfUxdLTKpC0H5A6I/vQ49kTmwJQGER3AHN8
dxJKY/R9hXvCmYi22URGN9RVztwfck2t0FwcSr8h0uxd3YtvJIk3DmYVASdRqQNd
1a0NoL15+QkjByWzjeNZiVpvIZVObqXO5AH2qtB0ImGMKbelJiuzzfxTLvvtAY2W
7SoEEI95iiglDDiDl2/46P+iHwskr68dAwLHg6OW425J3Z5XVip0O4wvSHvop1Rs
nqsIKOdTLecgB8OmrbaJ
=1urX
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

--===============4420491357545308970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4420491357545308970==--
