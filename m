From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/4] ASoC: fsl_ssi: Add dual fifo mode support
Date: Thu, 31 Oct 2013 11:36:44 -0700
Message-ID: <20131031183644.GJ2493@sirena.org.uk>
References: <cover.1383226444.git.b42378@freescale.com>
 <dda0bc1221f053405da616192577228c51821040.1383226444.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6064262666249447908=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <dda0bc1221f053405da616192577228c51821040.1383226444.git.b42378@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, s.hauer@pengutronix.de, swarren@wwwdotorg.org, timur@tabi.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org, ijc+devicetree@hellion.org.uk, dmaengine@vger.kernel.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6064262666249447908==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3qYtBtpdm1/OJWPn"
Content-Disposition: inline


--3qYtBtpdm1/OJWPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 09:44:15PM +0800, Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.
>=20
> [ Passed compile-test with mpc85xx_defconfig ]

Acked-by: Mark Brown <broonie@linaro.org>

--3qYtBtpdm1/OJWPn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScqM0AAoJELSic+t+oim979EP/ieHTZ0VT5K4I6Ckrka4bOI6
aBBG8IVjrZVySOgn2G46HDEo9xG9Qr2X1+BDS79mlEG1oFliMgRgLdPsSENSiWUx
qg6goC+kS6pqTR+kHykwS9JRRiwpIK23gsXDsQOx0OVk5vdeqYVlgD9fTAgt/Dd7
3dmKpzpuQzxLDrNPiU2VYBZd7rcRwU1uJXfUZ6TqE+4YKWyW0faEaQ/BNzgOS0BC
pqeirRELxXT6ek5G3I5Xms1iVLneJqKh11leOkfCQvu3+M8TNLt1d10GWE9zbcx9
A1kDmOkDVFPNW+igunUhEuBgBBZbdSQzTV2ObiaNvd23zs0HN/tyBAD6gGgYi4yj
3f9ZOSvAc6kzW/by1Ey6L1BHbgTAYMNwB5G6s/JJPMF3qhnL92ntschYtWMAIJvZ
Xgn3OxXCRVm7LbAWEmh6VomqYTdQGEdWkZAESAoyqh0sZsM5Sg00fStbKS6kmItr
1W1SsaBPr8G/s/qV4MAGTrJzIU9hQcMLpfLBg8YkB1AZNn3dqKfOWfms+EFOwH95
3NDjKl8FqBVFUy18RFLmdM2wr2LxdrGTPfvZRK7j+nKjne4e/sa3KwUDce68+Ocj
AVgJgc5L03hIuWVlB2Brrax7IRV0G1xh/iGwTTJg/dv+On40ASAZCgeq5t7LJ5sp
UC3BOQJUTqs38rWNSZKO
=76y0
-----END PGP SIGNATURE-----

--3qYtBtpdm1/OJWPn--


--===============6064262666249447908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6064262666249447908==--
