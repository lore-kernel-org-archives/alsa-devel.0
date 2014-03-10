From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-evm: Register machine level
 DAPM elements with the card
Date: Mon, 10 Mar 2014 17:41:44 +0000
Message-ID: <20140310174144.GW28112@sirena.org.uk>
References: <1393831255-18033-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6290755300533197837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B22312657BF
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 18:41:53 +0100 (CET)
In-Reply-To: <1393831255-18033-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6290755300533197837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M7XzGsxGUydJ6R3H"
Content-Disposition: inline


--M7XzGsxGUydJ6R3H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 08:20:55AM +0100, Lars-Peter Clausen wrote:
> Machine level DAPM widgets and routes should be registered in the card's DAPM
> context, rather than in the CODEC's context.

>  static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
>  {
> +	struct snd_soc_card *card = rtd->card;
>  	struct snd_soc_codec *codec = rtd->codec;
>  	struct snd_soc_dapm_context *dapm = &codec->dapm;

My first thought is why are we looking at the CODEC DAPM context at all
here and shouldn't we just change to using that here?  Yes, it does mean
that we look for the CODEC pins in the card DAPM but they kind of are
card widgets provided by the CODEC - or we could make those be the
"non-default" context.

While we're at it the not connected pins should be changed to _nc_pin()
on the off chance that we ever get round to doing the core changes to
mask inaccessible routes/options.

> -	snd_soc_dapm_enable_pin(dapm, "Line In");
> +	snd_soc_dapm_enable_pin(&card->dapm, "Headphone Jack");
> +	snd_soc_dapm_enable_pin(&card->dapm, "Line Out");
> +	snd_soc_dapm_enable_pin(&card->dapm, "Mic Jack");
> +	snd_soc_dapm_enable_pin(&card->dapm, "Line In");

The enables could just be dropped, it's the default.

--M7XzGsxGUydJ6R3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHflVAAoJELSic+t+oim9M60P/2C7JXWC/aAoZH1tQKhcIcCf
uZWO7iZmtk4smrwF4CosC332UlUhlPYMFbo2kO1xzoGtHlieh0+3Rse/RGZ3Et5N
s2rLyBa74xtPwJgF9c3i93Z64sMcq4Vi3G/snOv5piBin6GYu+zNOCN+k9tUFdOl
8neThJTP+0b7nEXac1ORYmSQWMC1FdRhkPfCjP2j9Bckg1aJKOkUBud9Sqp9L9Ed
EPPlvhgSnUAbRbnbZSK3tpbjzvy//PcWhAedB/iMOqrGf4Fdx0/5JfZAr7kxj2Ol
/pd5zCgxk0/GtOM2oR4CueI4trZwGG0xY/O+9b5Z8kCrZbwFbiUTwitCCbgEOh5G
jIczQ0s/CF8zw7qymKAKwSRy0CjbcIaqS9w0r8nddN3pu4rcd4/QRk088sD+aFMw
oWm0uV/ULTsjgknXzz80w5qhmt0JqSnvjTkdIos35rwfLxP1l/oTjH+ct5Tux1Xl
VaSB/2wd27Y+Q3LM8ouOq86yTifqNtTo1TRUqd4CQiqWZ6qPcpcmzQVrk4qaGmmH
0oI9jk/X/rxwVQDYX0ZZGrnh8E+CC0pbcLGyuOOTqfONM7qRozgdGrdZ4RO+YgSp
PBzWTEQMOW1N69F8BOuOxjDv8wRNctKjBJ9N/PsgSv+0y16YA9iAhMia1H2B4lIo
5CC0YcagEfKx+WxC2JG+
=DOhv
-----END PGP SIGNATURE-----

--M7XzGsxGUydJ6R3H--

--===============6290755300533197837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6290755300533197837==--
