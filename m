From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 1/7] ASoC: core: Generic ac97 link reset functions
Date: Sat, 27 Jul 2013 13:05:22 +0100
Message-ID: <20130727120522.GG9858@sirena.org.uk>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7001182633894755317=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374924716-23475-2-git-send-email-mpa@pengutronix.de>
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


--===============7001182633894755317==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8INrDZLky+thZCA"
Content-Disposition: inline


--a8INrDZLky+thZCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 27, 2013 at 01:31:50PM +0200, Markus Pargmann wrote:

This is a really nice approach to the problem, just one thing I'd like
to see changed in the bindings:

> +ssi {
> +	...
> +
> +	pinctrl-names = "default", "ac97-running", "ac97-reset", "ac97-warm-reset";

I'd like to see some documentation of this "default" state - I'd expect
this corresponds to the bus being idle and waiting for a wakeup from the
CODEC which is definitely a useful state to have for power optimisation
so it'd be good to bake it into the bindings.

Alternatively it could be the bus being totally idle with no possibility
of wakeup in which case it'd be good to say that too then someone can
add the waiting for wakeup state later.

Please also note the new list devicetree@vger.kernel.org.

--a8INrDZLky+thZCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR87d/AAoJELSic+t+oim9CuIP/AjvwaCXdZ72ahko7jbxpPu1
Q9eGX925N0THH6Sv2TgAKcqduFSVi50pzfHXVdjyUdLUFvO6P4kukXxGvhkLjngg
zY9gu7gHQ4PtYr9P8KE8vJS/GH/L5Glq86fQ4GWHU6BJiHoeVXyGccn4jiNeK80S
/WJDDLCazencxUpN+XPG0zRHc+2p9wBoSsD9oC7RJc6B4fgkf6nbMXv0RPLkw7Sy
PcRPKC+sCmp5YS6K3FTpVAzO0bEexJMOPW3zzbSVD1PHGRkxV/t6ZgnZNYcN4fKN
U3HWbx8ah5SDvc2h5EFpSoPTsK+orveoP6Ntu3ckSQUt2OYSbB9HgFA1riiKSPAY
kJXYefgtOTQcjiKHMhJddCXR+Z3SideQMHb/oKvRmy8sHzidVqbTiCP2XIfg6pQv
F/k83KXtSPTfM+96inFFLHFuhcndKsXWDjx1pc9hc3r/GWOTiRET4FiOaI1xH2Zs
ppD8vjvl4vFt1agRhN0NKbznv58aD49rbsLdIlqOoCerALGox32bArkMYx2YSw7u
hJjGNMMRULNdGl0Vd2SLbxl4+syoJUtM/59BY81MPhJBXvebyx43BdzyI+/Q/HAb
HRavhEjp5Fcw2dPPV0uVrqtnTh83hIHSO4C0tyziopxw6y04+e0CxOyioQULKlrH
aH71WKawbSlAx1DP+R7i
=dXMY
-----END PGP SIGNATURE-----

--a8INrDZLky+thZCA--


--===============7001182633894755317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7001182633894755317==--
