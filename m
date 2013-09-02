From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Remove support for
	reg_access_defaults
Date: Mon, 2 Sep 2013 12:04:15 +0100
Message-ID: <20130902110415.GP3084@sirena.org.uk>
References: <1377973875-2209-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2714739104963119521=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 18BC7265138
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 13:04:19 +0200 (CEST)
In-Reply-To: <1377973875-2209-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2714739104963119521==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jigfid2yHjNFZUTO"
Content-Disposition: inline


--jigfid2yHjNFZUTO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 31, 2013 at 08:31:11PM +0200, Lars-Peter Clausen wrote:
> No users of reg_access_defaults are left and new drivers are going to use regmap
> for this, so support for it can be removed.

Applied all, thanks.

--jigfid2yHjNFZUTO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJHCsAAoJELSic+t+oim9GBEP/jQQZNgEFGWVj0mDkrE1SDBc
/HFkyty2BJny+zrB4CfABkVj3mjY2dGQyTT/b8xmOBCN/mV0w0uPzwwMWQxcXbMH
gx6lxzp0F2R3V6CknnuXrPA0f7sSryT3IaAqErzXLPqixnUtxJTZMDIsewoc6M5/
2VPO6flK4fZvtBPmsHDT+e/XfgF/ITH5nzYewzlEzmiZWb9RTPciK8ZnClzlLhHq
+z8HMj8Aw9pFyOhfLI/67McGIkxXG8vjMgPny5ghGQHOmh5KR0A9yLBmW0IB+LPE
K+Jgj/QeYsxiO631W5b3slPH/Wku5eksSUPp3ln1uH0hubsC4ZOmQ6pmbjHi+CQW
Qvoavc37BC5cIIA0sszjCfUuIOmJF8C2rRHuJJe2BjQ3NFXvv8Sesq9VeMBC8tnG
2ieCUIZEI+kRzM3CfCYtksq6zFTy1sdUV8qo5DnVltaafK40fgU5AF5Q5/eI/4XJ
p4l70t3ThsL+ZT18Vazlmx7bZAHrUG0SU6+KI7c2e0KuyOMuL0PSDJtatZhi/Qm3
HhGG6i+4do+CW9tsRDb8dNE/nFTaYCftwK/nKZFn4PwsBWPU4bQK+dmyeppnFRR1
V60QFRvIngVNnI5k2nWMEdDke7s2QdJCMw9hel8eP4ZED8/xmOOhBFkzEvdy7dzU
O9pe4ktFknDnFlZW7OGx
=C/sU
-----END PGP SIGNATURE-----

--jigfid2yHjNFZUTO--

--===============2714739104963119521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2714739104963119521==--
