From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Convert kirkwood-t5325 to use
 snd_soc_register_card()
Date: Tue, 7 Feb 2012 19:41:08 +0000
Message-ID: <20120207194108.GB31557@opensource.wolfsonmicro.com>
References: <1325075415.3601.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5985943392083447644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2FF2103917
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 20:41:10 +0100 (CET)
In-Reply-To: <1325075415.3601.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Nicolas Pitre <nico@fluxnic.net>
List-Id: alsa-devel@alsa-project.org


--===============5985943392083447644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 28, 2011 at 08:30:15PM +0800, Axel Lin wrote:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Applied both, thanks.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMX5NAAoJEBus8iNuMP3dPUUQAJjO1DR4XIDwNsOwD/VNUw/A
5n/be/FvznXF49BvPgXN6JYhZ7rE3mA1YFyZ/tOZMS17Rjc3aujR6Azvyo6JwV4N
Aa/qG1tXXzjhWSKu73yi2CZdyUjP0MDW7WjntK1vUODR7GM37notOz6pOXKtmBHc
YneKrJYW8Jq4UrOn8J4R3Dfbod018yf7WW2I8SUQI8W+8wk8+Jtbu3DuMMmfVVzG
q909FCRGxWydWiXMQxIaJkhHaM1nHQ5b8JPhJIQ+MNKzsL4vDGEJzSPkxwZ6XaSf
papX0u1azuCqjLzDemZ1R4gySwaOlWjCvCYOX02E9fglikEYs+KtsWGnfSQuSvKe
O7el3NpgdnoD9XlkWrZ0yNhREaDmKwBlhx5aWSiPJt2p8ys0f1OXNFchorpEmGDD
wqngMaZa/HXle116KzA0eMhBPAyqP0dccoaEDxfxpwV2g6zDmi6JZ3lKpzunTbo9
xGC0XeU2DTSR26JMGAJ1NTKAklZ2IMy6nqahQkrkehKuI868NsLQ1yQzPyRk6Yoq
Q/pB/tVzBrkp8I5OPISo+uLrPsZoEPTVuzVZvwcy+GoPN4xWBGP8IvDLCdSQh510
AfNiKlVW4EiRNGhzl3I7151WNeo/z9rQ/CgfHOXGxQZ+MCgbWxLkTjKtHSXiERvj
LlhGaoz/55/VQHFRFF9P
=eVBs
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

--===============5985943392083447644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5985943392083447644==--
