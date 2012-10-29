From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: ak5702: add support for ak5702
 -- 4ch ADC
Date: Mon, 29 Oct 2012 18:17:34 +0000
Message-ID: <20121029181734.GI4511@opensource.wolfsonmicro.com>
References: <CAFsPKCXpZ43SBXyPTJnXR9mUgXyLK0T=JBiQrkBWGzSJOuLptA@mail.gmail.com>
 <20121029160450.GB4511@opensource.wolfsonmicro.com>
 <CAFsPKCUXU6OYWQNGy8VOuG-Z=tB81CVbfQtbhq35N2gf4PkX2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3362530795137025080=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DB5B3265D37
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 19:27:07 +0100 (CET)
In-Reply-To: <CAFsPKCUXU6OYWQNGy8VOuG-Z=tB81CVbfQtbhq35N2gf4PkX2w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paolo Doz <paolo.doz@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3362530795137025080==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2012 at 06:49:18PM +0100, Paolo Doz wrote:

Please don't top post.

> @Lars-Peter: thanks for the code review
> @Mark: You're right. The original source code (that I found on the web)
> was for kernel 2.6.35, and then I adapted it to work with kernel 3.2 series.
> Can you suggest me a "state of the art" codec driver where can
> I have a look at best practice?

Anything that's been getting work recently...  wm8731 is probably
similar to what you have there.

> In the end the codec should work with alsa infrastructure available in
> kernel 3.2 so I can test it's correctness directly on my hw.

That's a *very* old kernel now, any mainline submissions should be
against a current development kernel.

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjsg2AAoJELSic+t+oim9Ho4P/jxjAU6JHFwkfFozPotKBsiY
F6e2Blfaood0lT0O4zWWSb5Koi1je/azNOYpTtr8OP1vPGY8NZZ4O3SYpd8+gTkG
ayU5wj/HDmJGPkXUW3O8t6J3eKMASI4F38x3M2T4LrbihzILIbmG7JnD7Jg8e2Fe
cuJsEj4AJyH/yNXzDV7QGKV+bji0EsAkvt6adzOBbYigj8783JkmNSQPPtzUtTO3
9gZmVDXn8uL3FJ3zhKsWnxWnbqKatPDhKF4a1eHTrIt/iqsE39g2k2riTUMU000x
qjJEU7j+LA4GxFeems/UgcdZn3CBd9EIHKH+R1GFyQAMzUvUiPMQdXWq3Jc8CNnI
jfAX3VZDPisMRFu2Qq3nuOUoqpW2HovjS3lFgF6eTDwYF0wFOiFXie8vdd6JQmaC
VEwHc75fJ/iH45WJo9b2erhfjDcVBR+2UUWQgNE082T1+gkClkaxgHuYTxswYCpF
zY6gY002Nwep0uN5O4Ds2OJp8xbN7I80rjO64AWv7AN3opma916WWf9OEkbxir0/
yRVCMWpSwPIfibyoi0rg3CSBikWzo/0jQLFrdiC9y7ZdyoIRUA7icsWO9RWSdUnJ
aSXmyiqhI+7oo2EoIUzk8VHsquX/WjyKj4cqT6MHpoB5TdwOQL0LUyl/dsyMUO1j
rYKV9hyCzWO+bHUoREW1
=ccCh
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--

--===============3362530795137025080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3362530795137025080==--
