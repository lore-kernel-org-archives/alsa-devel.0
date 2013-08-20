From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 2/8] ASoC: core: Generic ac97 link reset functions
Date: Tue, 20 Aug 2013 11:22:11 +0100
Message-ID: <20130820102211.GH30073@sirena.org.uk>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5323288408772350176=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5323288408772350176==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bda7maMjJbTZ4Ov1"
Content-Disposition: inline


--bda7maMjJbTZ4Ov1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2013 at 05:05:55PM +0200, Markus Pargmann wrote:
> This patch adds generic ac97 reset functions using pincontrol and gpio
> parsed from devicetree.

Applied, thanks.

> +Required properties:
> + - pinctrl-names: Has to contain following states to setup the correct
> +   pinmuxing for the used gpios:
> +	"ac97-running": AC97-link is active
> +	"ac97-reset": AC97-link reset state
> +	"ac97-warm-reset": AC97-link warm reset state
> + - ac97-gpios: List of gpio phandles with args in the order ac97-sync,
> +   ac97-sdata, ac97-reset

This should really be reviewed on the DT list but never mind.

> +	gpio_direction_output(snd_ac97_rst_cfg.gpio_sync, 0);

These ought to be _cansleep() since there's no need for them to run in
atomic context but that can be fixed up later.

--bda7maMjJbTZ4Ov1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSE0NQAAoJELSic+t+oim9PzwP/jC7DZQoB1Ed4PjV3B6mEVW/
Dq5BHA89SYqE3kyGqzrd6G3Qkd8HssLezwsKVYWS83njVQKD50LGyNRye8SFYzC4
uY4oJYGr6+C++ZnN0E3PsM/xCo0yjrIb15ZzmmabsmB9lh453LDVxufH1Daa6SrP
Jg5L4jPQ4LKPIn4GjQZnO6KqV0TJPmw94bU99tMYJ5ocwfZzEPym113iGqVSEf2J
FoG+LzzQoKMjBm70c4VpBGYl9z/1H0NVbfOJNByjZ+ZDwvvg12DDerZstoResw0G
ETRq/p8libXtNfe56u8LEADmlZuH79gW2Q/LlOVPYJn/To+sL7+lP6mGtIOM67/v
bQ++LIuVSW4q0HI+hphOCnthfDHniRioWU1leBwVRrNoLxNW0VqsKEJm8eOLmPF4
5nED4H6mScS+/kA6xhnOdPu4Q4O49F6fp6c1lRHsF8mCTMX7zOZ8mzbGsExhTLMV
tM2X+Yxcnwjyuu0GpMcL/lmPxPOnauXZH6HJubq2jO9dXIqKdGXw0K+sMmLgyQ/I
KI8BovUI/IOKekkuvsAQHSCLxMIo3VUX8TeY0gZncs+zoPdrZtIx8Ojfk5daLkds
ERqF6ivC48cnP9zgI/s0MENJCMRkCox18TFsjRsO2qkC0gg8TT85O/y2MCXw1reI
HrE+dL8Z9crbqCuHilXc
=BPB1
-----END PGP SIGNATURE-----

--bda7maMjJbTZ4Ov1--


--===============5323288408772350176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5323288408772350176==--
