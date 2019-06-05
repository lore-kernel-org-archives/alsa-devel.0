From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] ASoC: sun4i-i2s: Change SR and WSS computation
Date: Wed, 5 Jun 2019 12:08:44 +0200
Message-ID: <20190605100844.kzaw7r3zasfqhnuu@flea>
References: <20190604085449.13195-1-maxime.ripard@bootlin.com>
 <20190604144517.GF2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6027104896691045339=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190604144517.GF2456@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6027104896691045339==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qhomvzhpyiavwpcf"
Content-Disposition: inline


--qhomvzhpyiavwpcf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 04, 2019 at 03:45:17PM +0100, Mark Brown wrote:
> On Tue, Jun 04, 2019 at 10:54:49AM +0200, Maxime Ripard wrote:
> > The current computation for the SR (sample resolution) and the WSS (word
> > slot size) register parameters is based on a switch returning the match=
ing
> > parameters for a given params width.
>
> This doesn't build for me with current code:
>
>   CC      sound/soc/sunxi/sun4i-i2s.o
> sound/soc/sunxi/sun4i-i2s.c:169:28: warning: =E2=80=98struct sun4i_i2s=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
>   s8 (*get_sr)(const struct sun4i_i2s *, int);
>                             ^~~~~~~~~
> sound/soc/sunxi/sun4i-i2s.c:170:29: warning: =E2=80=98struct sun4i_i2s=E2=
=80=99 declared inside parameter list will not be visible outside of this d=
efinition or declaration
>   s8 (*get_wss)(const struct sun4i_i2s *, int);
>                              ^~~~~~~~~
>
> and lots of similar stuff.

Sigh, so much for sending a patch part of a branch...

Sorry for wasting your time on this, I've sent a v2 with this fixed.

Maxime


--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qhomvzhpyiavwpcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPeUrAAKCRDj7w1vZxhR
xScXAPwN8ypur7UlU8bNKMKWbFc0f1dSEHVT5ZDOnsRZQKzswwEAi27OmMmw2FeN
7aj+QHjqrk9psWgk+O/LHTS3NFkUcAM=
=vzYH
-----END PGP SIGNATURE-----

--qhomvzhpyiavwpcf--


--===============6027104896691045339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6027104896691045339==--
