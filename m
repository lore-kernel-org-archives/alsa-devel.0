From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoc: rockchip: Add rockchip SPDIF transceiver driver
Date: Fri, 7 Aug 2015 14:13:59 +0100
Message-ID: <20150807131359.GA8892@sirena.org.uk>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
 <1438159908.5106.32.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438159908.5106.32.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 10:51:48AM +0200, Paul Bolle wrote:

> > +		.name =3D DRV_NAME,
> > +		.of_match_table =3D of_match_ptr(rockchip_spdif_match),
> > +		.pm =3D &rockchip_spdif_pm_ops,
> > +	},
> > +};
> > +module_platform_driver(rockchip_spdif_driver);

> > +MODULE_ALIAS("platform:" DRV_NAME);

> (I seem to remember that Mark Brown is OK with this, at least for the
> time being, but for future reference I'll ask the question anyway.) Is
> there a corresponding struct platform_device with a "rockchip-spdif"
> .name? Because if there's no such platform_device I think this line
> doesn't really do anything for this driver.

Paul, you've been told this before but please stop providing these
review comments.  It has been explained to you repeatedly that we do not
require any form of machine definition to be merged to merge a driver,
please pay attention to those explanations and stop sending the same
bogus feedback to patch submitters.  This just creates confusion for the
submitters and wastes everyone's time. =20

If you have questions the way to raise them is to respond to the
original discussions, not to send new replies to other submitters
repeating the same feedback you were previously advised was incorrect.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVxK8WAAoJECTWi3JdVIfQK58H+Pv1xUNvskBTGbB7siRHRiPu
Zrt4mMYvLay4gqlHKtdoPnoJ91niglKFYy3v7cY8mFzkA8nUIpeIK3yELMfudJL/
mu+WcVbXPPG6TIpmB1qeAonxx9BW5qk7Y0Hn2+mk2/K4GYAXcNadunBZ6AhAig4N
S5AsFqShW68CYId4O4traK6RCcmr3T6DUz0eaHcc5Dn+gN4nRBZ/lwb9PbtzRRz0
sumMSmAYy6o86sc8CVMt99mNswvLiL14hNLXUO9x6kcfirWVwUtq41LGi58qes8m
rSY8UlwBmPrAs63npNGAi2tDynBAJ38Ej7cszYut7/f/nLzpJW07w06RqQws9g==
=mEKU
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
