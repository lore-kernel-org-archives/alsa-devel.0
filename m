From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Fri, 9 Mar 2012 11:59:59 +0000
Message-ID: <20120309115956.GF3273@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<4F5910EE.8090408@freescale.com>
	<20120309011914.GF2499@S2101-09.ap.freescale.net>
	<4F5966DC.6090201@freescale.com>
	<20120309071347.GM2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0837324951358409368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A193910B9DA
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:00:09 +0100 (CET)
In-Reply-To: <20120309071347.GM2499@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0837324951358409368==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2012 at 03:13:49PM +0800, Shawn Guo wrote:

> My bisect tells that the offending commit is:

>   96acc35 (ASoC: DAPM: Make sure DAPM widget IO ops hold the component mutex)

> But I do not understand why yet.

It'll be deadlocking somewhere I expect - turning on the soft lockup
detector will probably make it obvious.

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPWfCnAAoJEBus8iNuMP3dL7EP/3MyuHj250Eg+WReWcuCBQr5
TbnfMq5EPylcnyxUZVRptA7rfWS1LL1O1HL/gbdUUxaXofvZnuMSSwoY3mQBNacj
eR3s2uLJoYCZXNPDKp0GAbW0BezTD3vY2I1a+oWOlA4saBSvOFYPN4dPBKnt3fUF
i+3r5XZNqIEIMI6ujaNlBhv3Rq3ZJshpms5wZSlo+H3Ir1ULaEgs3yoFDPTTRfge
brB07gNWvMZUdtduuvoGGTWS9DngzdfNNcZHb0meeqMMlCSPjHaiucth/Y8cRixV
Nh93/SbOCMnWvIkvyRlZp1dtbPUuzBoO00jqRrz9E99speYCv2TzAezyeA0Hg/cR
byjdXrJ1/IpVtg8M8Z84D3gydlMISIJYpthuKkJQKzq+DFbZ/Awu5C14uYtR8QGA
M+t1OzPcaJ0T9jAfLoPBC67j+Bc1Alcw6SHngkSp+DGCJE9Q1CwHZCkt7Nmwi0dH
IJVG0ciIcWWm4OlbgsVRrlwNvkaXPPU6I/LTpmNNEsK1jpeFgcAB0U1Cd2YvM1FS
8yzbEuThVspSXbJlZ+aKE4RI1BhsHnpxdlZVWoRoNJhqW0VsQ1rbKKrlTzKkgZGN
UN7z+xzVo8ANbE7iFYVpuQXPNhPDytMa0qmUgrB4uDg5aLEw2WQYYuu2GXgl3zkQ
3WsD+jpGCrn8gvn4jxoH
=mx3B
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--

--===============0837324951358409368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0837324951358409368==--
