From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 05/12] snd-aoa: add i2sbus
Date: Fri, 09 Jun 2006 14:13:49 +0200
Message-ID: <1149855230.3864.19.camel__22128.8720066243$1149855417$gmane$org@johannes.berg>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130913.414650000@sipsolutions.net>
	<s5hfyig4xhm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1150504171=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33A85175
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 14:14:01 +0200 (MEST)
In-Reply-To: <s5hfyig4xhm.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org


--===============1150504171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MXlkpVwJ6LUTgZrbbEZR"


--=-MXlkpVwJ6LUTgZrbbEZR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 20:44 +0200, Takashi Iwai wrote:
> > +	if (I2S_CLOCK_SPEED_18MHz % (rate * mclk) =3D=3D 0) {
> > +		if (!i2s_sf_mclkdiv(I2S_CLOCK_SPEED_18MHz / rate / mclk, out)) {
>=20
> I'd use "I2S_CLOCK_SPEED_18MHZ / (rate * mclk)"

Yeah, I guess that's clearer then if the multiplication is there twice.

> release_resource() doesn't kfree the record returned from
> request_mem_region(). =20

Hah, ouch. I'll go through and fix them all.

> ALSA has a helper function
> release_and_free_resource() that also does NULL check and kfree:

Why's that helper in alsa of all things? :)

johannes

--=-MXlkpVwJ6LUTgZrbbEZR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIll+6Vg1VMiehFYAQL9AA//YJxAj0dxE5vzEc1TvNa24sZvB73BSs9p
ctSB+CFZh0AJOAhXNvhWTvfPlmlU0pVtOHUaqTP3kLYnLIaTXNiml+NNflVqtnX/
u8u/e6mV/j80GrXLw19Mbzfo20HhETfj2Q0C35ZGc+5GkXGXmlTruGarTHX4kmZS
E5yrYWMs5xCcxFPwczVdhyunst84TIi9Nu26vdswnvOgjEd+kOuVWdIh747aHYii
QAP16983sg5K4OM9Go7hqGQzugaIFJWYhHzzkrqD1ra6qz71qPWyQv9F+wrMTCBk
OdXo2vBlshoh1grfvPDyU3DNTNDJ3oQ9iFI3rznpltolc1l8419in76CDW2Uglwl
cScPbVHqGci5vj2c5GVl5lDDN7x353eTUcNNsjdeXyeu9EQT791UbLqoPQqH5SJu
0mGAvYOnTf9eiXtY35RXWZCHGEO1A2OYn8YP6cqNgDdZOUITVJIjskGGO20k+SNs
XxNAfoSTZwjv+dI+okPYLI+SeXDpSnxMQ/BpA0rrbYD8/51g2coIpbt5jRG6Yr47
M6a/bxktLUvKvZRsQY5cZVKN/Bev+/HmVLDz+Z/RFrBlq5ii1+rz9xfX6rt69vrC
wdK+09YtC6k3ZEOREmIWuTbW6TipW1qbVwc7/6RzUNRIF64pmWgpnRB2lPho2Zbl
uUxLqDLc8U4=
=+ct0
-----END PGP SIGNATURE-----

--=-MXlkpVwJ6LUTgZrbbEZR--



--===============1150504171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1150504171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1150504171==--
