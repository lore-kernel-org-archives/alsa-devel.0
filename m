From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: Adds rate and channel
 constraints for capture in Stoney rt5645
Date: Tue, 19 Dec 2017 09:31:38 +0000
Message-ID: <20171219093138.GC8563@sirena.org.uk>
References: <1513572020-7689-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2858583926316949760=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C5D08266D71
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 10:31:40 +0100 (CET)
In-Reply-To: <1513572020-7689-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2858583926316949760==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 18, 2017 at 10:10:20AM +0530, Akshu Agrawal wrote:

> Constraints are added as we support 48Khz and dual channels.

Why is this platform more resticted than other platforms - what's the
limitation here?

> Change-Id: Ib705f1101f5e2ab5c04f9526b10795a45a32debc

Don't include noise like this in upstream submissions, it makes no sense
outside your internal environment.

> +#define DUAL_CHANNEL		2

Do we really need a macro for this?

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo43HkACgkQJNaLcl1U
h9BSCAf9GROXxAY3aBVgl5+syz3jar7om3ohhuJZDSe+Z6StV24VGazNlPrj1tG/
4zmcmt7Zf9DY+O217BQAgNVGxEkm6vMZ+FO3d8DLxhFP0p37YiuayCQzqdb5/WPe
ZUTySw3d09LSx+egzTelFBYNDib8WcSZsydzb0Cv77ktxg/sK0AEyFmZK13eq5YG
wvJ1GzeDdTYFRmZMjS9uEoFeFrsPWnSVTbShFexxhHfH9A5hockx0m1utCTnSYBX
HHfNz7HhnXl+0GS4OagPFOxDQrCBibWLB9Z5tdpvrFX+JtSSskMjVZURKN41kNlm
sFIGknD6eeVrufsYbu/sB98vv+JARw==
=CDWv
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--

--===============2858583926316949760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2858583926316949760==--
