From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: tlv320aic31xx: Add
	headphone/headset detection
Date: Mon, 3 Sep 2018 14:05:53 +0100
Message-ID: <20180903130553.GI10302@sirena.org.uk>
References: <20180831182434.14499-1-afd@ti.com>
 <20180831182434.14499-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8927207007125983716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CD512673F4
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:05:54 +0200 (CEST)
In-Reply-To: <20180831182434.14499-3-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8927207007125983716==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:24:33PM -0500, Andrew F. Davis wrote:
> This device can detect the insertion/removal of headphones and headsets.
> Enable reporting this status by enabling this interrupt and forwarding
> this to upper-layers if a jack has been defined.

This and patch 4 look good but depend on patch 2.

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNMbEACgkQJNaLcl1U
h9Bn4Af9GCP34IPojd6vGbAnJwmLh+ZQPaV2FLWfktnKpgRjnaOt9htE4EPORNTT
C4DZgExwbnPkK7lF5J432p9mEgzRavyCVxMYjH/9adblUT52rJ53Nze7MzX3Qbyy
aCOriYQQ00Jf9LBHHtlo88GHR0BfIoZleadWAeD266UbSkE1nqvauk8Qc3uthM0G
h0tba70v0E/5Bpbo69GrGO+F90b0mWniYdjPUGn5otseO44GIHRwSDqVsHnPcuM3
jlcScmT8jFHVLwyi4UjmygZtnl3Jwow0TzkSaW/UWfTISSf5+Lur8pH3PlaoQ0Cg
O4/YwYAV3oXqscczA6cd8BTDbPHsog==
=+x1n
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--

--===============8927207007125983716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8927207007125983716==--
