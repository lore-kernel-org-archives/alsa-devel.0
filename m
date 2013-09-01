From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Sun, 1 Sep 2013 13:19:28 +0100
Message-ID: <20130901121928.GC3084@sirena.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de>
 <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk>
 <5222562B.8010001@metafoo.de>
 <20130831210518.GK6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2332114337457776818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F392264F28
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 14:19:33 +0200 (CEST)
In-Reply-To: <20130831210518.GK6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2332114337457776818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F8dlzb82+Fcn6AgP"
Content-Disposition: inline


--F8dlzb82+Fcn6AgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 10:05:18PM +0100, Russell King - ARM Linux wrote:

> I'm not the only one: I've heard other people complain about the _exact_
> same issue with ASoC: ASoC is difficult to work with, and many people
> just seem to give up with it - or keep their stuff in their own trees
> locally.  I can very well see why that happens.

We do appear to have a fairly good success rate with systems working
with mainline; I can only think of one driver that didn't make it in and
that was one where we had a bit of an issue getting the code to visually
resemble Linux code so I don't feel too bad about it.  I am aware of
some people who didn't work upstream, we've generally had some useful
discussions with them once we've found each other.

> As for "This is the either/or approach I've been suggesting."  No, that's
> another false statement from Mark.  What Mark has been suggesting all
> along is to use DPCM - and that's something which I tried for ages to
> get working, and it just doesn't work (as evidenced by the oopses and
> warnings that get spat out of the kernel.)

While it is correct that I have been saying the final result should use
DPCM (since this is what the hardware looks like) you will recall that I
did recently suggest either/or as a stepping stone towards a full
implementation, allowing systems with only S/PDIF to be supported while
the other issues are still being worked on.

> There are two choices in how the hardware is used: either one output
> only is used, or if both outputs are used, they must be used "as one" -
> both outputs must be simultaneously enabled and disabled.  As far as
> I know, that's not possible with two DAIs.

That is correct, this is why I call it an either/or approach - a system
would be able to use either I2S or S/PDIF but not both.  For systems
with both I2S and S/PDIF connected one or the other would have to be
chosen by the machine driver.

> And here's the patch I tried.

Ah, I'm not sure that I have seen this before (it's certainly not been
submitted).  Just looking at the diff this all seems fine for an
either/or approach though...

> index 2c459c1..62e5b62 100644
> --- a/sound/soc/kirkwood/kirkwood-spdif.c
> +++ b/sound/soc/kirkwood/kirkwood-spdif.c
> @@ -61,7 +61,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
>  		.name = "S/PDIF0",
>  		.stream_name = "S/PDIF0 PCM Playback",
>  		.platform_name = "kirkwood-pcm-audio.0",
> -		.cpu_dai_name = "kirkwood-i2s.0",
> +		.cpu_dai_name = "kirkwood-spdif.0",
>  		.codec_dai_name = "dit-hifi",
>  		.codec_name = "spdif-dit",
>  		.ops = &kirkwood_spdif_ops,
> @@ -73,7 +73,7 @@ static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
>  		.name = "S/PDIF1",
>  		.stream_name = "IEC958 Playback",
>  		.platform_name = "kirkwood-pcm-audio.1",
> -		.cpu_dai_name = "kirkwood-i2s.1",
> +		.cpu_dai_name = "kirkwood-spdif.1",
>  		.codec_dai_name = "dit-hifi",
>  		.codec_name = "spdif-dit",
>  		.ops = &kirkwood_spdif_ops,

...this file does not appear to be in mainline and some of the rest of
the context suggested this was based off something old.

--F8dlzb82+Fcn6AgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSIzDNAAoJELSic+t+oim9rncP/1pvT1wnPPXGmIq6AiqBvNk2
GGOZtMINs7Rwl4QhbmfehuHr8i3sc/STvXFRCgp8ewJQ5YapkrUjZxGz+mRcpmGJ
VSfeSuQqrpOCKJ4OLCd6/qnIXHG/43KQ+TQVgugzedIr7y3ggBW8bKfvjA0k9v5v
V4DqZSqykvg9Di2FQgjO0E5H0EC8dct/8EjTrdNruDQlrIyiMMHJYaFyKArvGPGY
+7jzOuxdU6fUGIQHP4wx0TBcXCf2hU9WzCqjK1bANtwr/Jva9vAJ3hZW7sNl1A2/
0i5FkPjCazMFccVhbxapr8wupzoiZf15bXNcNMfLRl6kKnlUai0BUlb8xgTC0oZY
tEYoP0Cw7ATU15I2e5sMMPBBm73zkKxg13d7EbypmU6FdjFBksV7XFoViW81iVKp
Taara/lbp6zjVfXY67M/m5MD8VU3BeOcB7kTHMOvRVzgv9D3bbFaaZfkXyGZ6tP2
znMX2/swiOTVZ0ih02W0SaQRptpESpcEyUJDDbqZj6q/RKcpn6Qk0YhWkzq+Gush
IAvA8pAaiBoLpxPhdchZbx9CHVegKBJbsy0Q2ezqOfRv1dDCf0wz7jP4rHWLsmHJ
abp2R0DszDEYIqo/LFF6fziDEmHES7kRe18Gae3NFoxomTque4UGyTEmMkhD9Vhx
9v5RdBzbHHlkpe78WU8q
=VpK6
-----END PGP SIGNATURE-----

--F8dlzb82+Fcn6AgP--

--===============2332114337457776818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2332114337457776818==--
