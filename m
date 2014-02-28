From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: core: Set the default I/O up try regmap.
Date: Fri, 28 Feb 2014 12:52:45 +0900
Message-ID: <20140228035244.GJ9383@sirena.org.uk>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
 <1393494593-26310-3-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qX4XtzAfKSOolMWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393494593-26310-3-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--qX4XtzAfKSOolMWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 05:49:52PM +0800, Xiubo Li wrote:
> For most CODEC drivers which the REGMAP is used, the soc_probe_codec()
> will do the stuff work of snd_soc_codec_set_cache_io(), which the CODEC
> drivers' ASoC probe will do too, and almost at the same time.

Applied, thanks.  I did a check of the drivers and it looks like they'll
all be fine with this.

--qX4XtzAfKSOolMWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEAgJAAoJELSic+t+oim9GW8P/iM1Bj5AYtYOMVNvj60H5dih
by5bZwjJt0gWLdZdmFp/WmVvtQoxD0AweSTDTPLcgq3GkTsofZiNEXLjAmmw9aas
BVtNvzwe6RjvdSoHsy+IFpU/U/JPfvZlmifnye+UVnxBvtsmHWrl4kcb+G/emKXD
RDqB8cGYyYPjd1+CoPheDpWCGuZxHMMCzBvWxtXNe+9RBJ2BTctiKuIANo4GhK3/
51LTmu71cmB9ppdWspxVzMxZjfRnuIJU+8NII9DHhtUsKHM7wLGQJnzpOJZWRJ4K
RPTxY4x2ZTMBswitiMCMxAKSgnhWZeu6bgzMiHCY+9+HVuhMExsoCXCwdc6xSXo9
D4Ti13oRn3gVWoS1ta+km3pXcQe1LDCxklSCPaqXdXjjL5k16VxEZdR8L9626Q2u
InIcPfRhWMH7bealuOR1MtNayswHsQx7+3F76t7W0fBmBSNsaiv5VViqxRTp0igs
K7w1wmL8DsTroD2LQMJvafsm0cz8TcCSCFciSLH0VHzupkzkHdvFbMdekjvTxyuR
Ux++3JIEBKsnyg3iVsQUa64fe/5Dq5wEiT8hZpF/J3UbLR0M86nivOwACH5OzYnM
0qK9FX4WK9MMHhOIVXmH9qhCG572sVH+8zoKkN7p1nhHD076jGBcVWVQ7Qp/Wi6Q
YzxZYV6RXCK7SPQUnILc
=A21A
-----END PGP SIGNATURE-----

--qX4XtzAfKSOolMWY--
