From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: da7219: Add bindings
 documentation for DA7219 audio codec
Date: Mon, 21 Sep 2015 09:40:05 -0700
Message-ID: <20150921164005.GW30445@sirena.org.uk>
References: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <381b367e0a4c6c9e00db74f1b0e91d383156ba86.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
 <20150919171017.GI30445@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460170E@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7690976924592698577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E8198261519
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 18:40:59 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460170E@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Jason Coughlan <jason.coughlan@diasemi.com>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============7690976924592698577==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4nn+A2p41ba1mxGd"
Content-Disposition: inline


--4nn+A2p41ba1mxGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 10:36:04AM +0000, Opensource [Adam Thomson] wrote:
> On September 19, 2015 18:10, Mark Brown wrote:

> > > +- dlg,cp-mchange : Charge pump voltage tracking mode
> > > +	["largest_vol", "dac_vol", "sig_mag"]
> > > +- dlg,cp-vol-thresh : Charge pump volume threshold value (6-bit valu=
e)
> > > +	[ 0 - 0x3F ]

> > Why are these in the device tree rather than runtime parameters?

> From previous internal discussions, these seemed to be fire and forget
> parameters, hence their inclusion in the DT binding, rather than as contr=
ols.
> Personally didn't see either needing runtime updates.

Make them runtime configurable.  People can do an at boot runtime
configuration if they like.

>=20
> > > +Required properties:
> > > +- interrupt-parent : Specifies the phandle of the interrupt controll=
er to which
> > > +  the IRQs from DA7219 AAD block are delivered to.
> > > +- interrupts : IRQ line info for DA7219 AAD block.
> > > +  (See Documentation/devicetree/bindings/interrupt-controller/interr=
upts.txt for
> > > +   further information relating to interrupt properties)

> > Why is this not specified at the device level (the device does not
> > appear to support other interrupts)?

> Given the way that the driver code was structured, and that the IRQ is on=
ly used
> for accessory detection, I added it to the child node. The other option w=
ould
> be to flatten out bindings, and remove the child node. Felt like keeping =
the
> accessory detect items separate though was a sensible approach. What is y=
our
> feeling on this?

The child node is fine for collecting the parameters but the chip
interrupt line should be at the chip level.

--4nn+A2p41ba1mxGd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWADLkAAoJECTWi3JdVIfQakwIAIX+ElL/aZogyl8doXykVw6s
dBBUIeBR489gE6VyrPYpjMRGE36eRFiKCeGncc5miJCYZ3JgcHJ3EiT/j8CO0hZj
Md1I6n344jYorNwwVKZMPqLIMVGx9fACsiI5SrTDKN/YjbEtW9s62C2Q00QNCi0o
xCFoCXhcmCsxvGKOs1GOD62KhJL9EC5ygNZPj59uTfIzQck1u42YH0/7YYhP0Wz8
XRXJrVgpza7+He0vwS/uroBEBxmd3M+saiT0+37+UxMQ+Q4ig3wuFH9oQHO5buzq
5m8ifRbaRzSZVOVAMlZiVhSCTOww2kP9mMr63zm9ruae6uRilqobI9+/pFgzLz8=
=wuX8
-----END PGP SIGNATURE-----

--4nn+A2p41ba1mxGd--

--===============7690976924592698577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7690976924592698577==--
