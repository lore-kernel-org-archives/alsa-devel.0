From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
Date: Tue, 21 Apr 2015 11:14:16 +0100
Message-ID: <20150421101416.GC22845@sirena.org.uk>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
 <20150420204849.GJ14892@sirena.org.uk>
 <20150421094926.GU6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150421094926.GU6325@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Koro Chen <koro.chen@mediatek.com>, robh+dt@kernel.org, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, galak@codeaurora.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 11:49:26AM +0200, Sascha Hauer wrote:

> I think this could be done. I checked the possible connections in the
> crossbar switch and it seems all memory interfaces can be connected with
> all relevant external interfaces. So indeed the memory interfaces could
> be dynamically allocated instead of statically associated to an
> external interface. There are two problems I see: Some memory interfaces
> are limited in the rates they support, they can only do 8k/16k/32k (for
> speech). How can we know such memory interface should be used? Also
> there are two programmable hardware gain blocks which can be inserted to
> the digital audio path using the crossbar switch. There must be some
> mechanism to configure them into different places.

This (particularly the gain controls) sounds like you want to expose the
routing to userspace and use DPCM, the code also seemed to look like it
was a good fit for DPCM.

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNiL3AAoJECTWi3JdVIfQAtsH/Rim5sv0xPg2Fe343+thwgfT
2LSdvsP3T5kR6tevD/dl4+uoEvAaFdjf32pDkr4aWXR4V9D3A9PIcqJ8cef88h24
rdSnT8qMQhu5pvb+ouPgdlBPCuOYzqNUVD4wNCTNW22RKm5rAgyqmbXSVFG3tvHE
ltBLOiPs8VrZLHAdQB5JX2DqJm70Rs4XvwfxxtRijpAu4ap1sKVYlUFsAf0uxarW
C/gM1a8zz4t44Q1MgIwrA+0yKDdTopMomvwZ9T06cnWjzAa5dk8wVgKznz6aDF9+
YYQcEk8OjutyWBYjiJeFdhn9aEwebuJ5LbQe5WvfCbbu8mkik2lYex2koPJYZcQ=
=G/nl
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
