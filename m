From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: jack: Basic GPIO descriptor
	conversion
Date: Mon, 26 May 2014 15:23:28 +0100
Message-ID: <20140526142328.GG22111@sirena.org.uk>
References: <1401104077-25366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6865851928110334373=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D259B264F74
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 16:24:14 +0200 (CEST)
In-Reply-To: <1401104077-25366-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6865851928110334373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TJxtaq2eJHn2gz8s"
Content-Disposition: inline


--TJxtaq2eJHn2gz8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 02:34:36PM +0300, Jarkko Nikula wrote:
> This patch does basic GPIO descriptor conversion to soc-jack. Even the GPIOs
> are still passed and requested using legacy GPIO numbers the driver
> internals are converted to use GPIO descriptor API.

Applied, thanks.

--TJxtaq2eJHn2gz8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg05dAAoJELSic+t+oim9L1YP/09ppFwtnCsBm1QC88Mon8pA
6M+wr/2X1t4S1ZyzmUxgPYAvVoapRsU4mRuc0cGfL5m+NKq4IlgViMoAKKtz50NW
HGSNvHRE+ep5ZG24aeL9eV6QibrJxPJDoy9wM/v0F4Ip8AQItJBVFZTtmFyskHqA
Hn59w1sglJ81RXFsWr6aMCXVklL93zR6Pu3NPjztXDqLbDH3ywZhBykM5sQFJYw0
h3qtzaNLSNKRwdCBpYmzVnLSXbxUtb8HPFsoo1CFqNTKKzVBnHcEFUMcl/NiL2/g
sxh1h5rHapJKmumveqlMc0pwpGuSsDkTA0/jg2GLoQCp6Qo3G816lPDvqPtj1r9a
qv7JsQfskDf5vOu9OA+rGHvqy0hghyM2hJRdUymVAhQ1fw2fpfazj3aB7k8L2uZM
/7qfyefHluQ/zqHiuwlZnEWULe9S8an4k027Yq/4lHlDjJvGrprju5nddtvGnqUB
FByJ/dG/9t4FaXMkSTkaWzl6RnRSzAcdFMjvh/8BBktcOqObz9f/dIupugLd+vz9
GWEKZI2Ui4cZveWUmOa2mLxZpgem+LbKJKzx+8YNFKHfKGMDMtVbw1Hj8AWl6qz6
mxcPQL7P2JzxwVDymMCYiGOO1euVPq/6I9YA/uWFz9Npn6ZZr686o35Pm8pTkF8M
tCRAGP6aNjDRBa5RTlO6
=k308
-----END PGP SIGNATURE-----

--TJxtaq2eJHn2gz8s--

--===============6865851928110334373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6865851928110334373==--
