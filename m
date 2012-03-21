From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for spi regmap
Date: Wed, 21 Mar 2012 16:38:12 +0000
Message-ID: <20120321163811.GH3226@opensource.wolfsonmicro.com>
References: <1332345170.21744.10.camel@matrix>
	<20120321155635.GE3226@opensource.wolfsonmicro.com>
	<1332348080.21744.26.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3159103590292904364=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82FE31044A2
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 17:38:14 +0100 (CET)
In-Reply-To: <1332348080.21744.26.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============3159103590292904364==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Content-Disposition: inline


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 10:11:20PM +0530, Ashish Chavan wrote:
> On Wed, 2012-03-21 at 15:56 +0000, Mark Brown wrote:

> This is writing to page register. SPI register space is divided in to
> two pages. Registers from 0x01 to 0x80 fall in to first page. If we want
> to write to any register above 0x80, first we need to set page register
> with PAGE1. May be I should put comments to make it obvious.

You also need to make sure that the register cache doesn't get confused.

> > >  	/* unlock */
> > >  	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x8B);
> > > @@ -1035,6 +1056,10 @@ static int da7210_probe(struct snd_soc_codec *codec)
> > >  	regmap_write(da7210->regmap, DA7210_A_HID_UNLOCK,	0x00);
> > >  	regmap_write(da7210->regmap, DA7210_A_TEST_UNLOCK,	0x00);

> > I also note that you've not yet updated this to use a regmap patch as
> > was previously requested.

> Actually I don't have enough details about the problem that you
> mentioned with this. I am waiting for inputs from some body else. Can

...and didn't bother asking any questions so it's unlikely anyone will
say anything...

> you please elaborate the problem if you have details? so that I can
> correct it.

What is unclear in the previous feedback?  You should be converting this
to use a regmap patch...

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPagL+AAoJEBus8iNuMP3d+3kQAJwsFnlgLpxxM91gMA0WCTbN
iKL1QqapB5KdDLEHv/3JGkdMsZ+h0nWVBxe1o61JKiLmiFRI9Zur1zFj7IdnTo/O
bbIkHDlo/2GjhCdsaLHxkWoMhxJxicaE+k/txuNwXjHv+oSPjg4sBNNc9x+lm0aV
ycv3qZfCNK/2HQ4FfjX+nSPW/rMcICxehhHFSGmFu12g+Q/wTI/T1hzFjJvWowmH
RtdSv0kYwoJOCdPD97rbgYcYEVrymlPl5srK8JuQ+f4OHwHuqj1FxHSxV4sgJyJp
MgrW8jMHCRwwA2JACg3xh/EieNFVLlQ+4j97B8/wsertwg2YD4ZRGgmbO+5gDEhS
ZqwVdpTLE5SURtyrm6wI1k5Jwa3IkAf/g1oQ6BULzUQtsGLsa+xH1ChyIKnCKw5G
8mGJxkW9DEMSs1pXkOxlo2KHYjzMJLe7EYj9wepSjbTCHzFnxMg+NNZ4e3Pnuzv9
IjKLmwEPYvht/8OSiLZyicZ/4x2WJAvs9JtGxHvjKlwvcUm9mzGsbp6ea9r4PY0S
d03Z/t/ocyo724hwHP1dxOm8ZDe5Y+Gy6dnp4GeDsKmRPJtkxVdo9/n/qdEaQ9qM
S8wRmWgpe+4lPjGa87rPD42qFsK/DYLVS25ukQzJ7ik2Y8wLZKuQWGBWw6TQ8ZLp
3v1Wq1Ls47vZVoPqsoUM
=bCAI
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--

--===============3159103590292904364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3159103590292904364==--
