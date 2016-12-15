From: Mark Brown <broonie@kernel.org>
Subject: Re:
 =?utf-8?q?=5BPATCH_09/14=5D_ASoC=3A_max9867=3A_remov?=
 =?utf-8?b?ZSB1bnVzZWQg4oCYcmV04oCZ?=
Date: Thu, 15 Dec 2016 11:22:04 +0000
Message-ID: <20161215112204.nidck4vmcu5345a2@sirena.org.uk>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
 <1481218297-17568-10-git-send-email-vinod.koul@intel.com>
 <CAOMZO5C5WHW+a4F5gTV2T5xw3pMjrvkr4JsfS7rxU7d2=-tbKA@mail.gmail.com>
 <20161209065613.GI6408@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4936763906790932527=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97F7B266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 12:22:13 +0100 (CET)
In-Reply-To: <20161209065613.GI6408@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4936763906790932527==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bfv372o6v7e25jvw"
Content-Disposition: inline


--bfv372o6v7e25jvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 09, 2016 at 12:26:13PM +0530, Vinod Koul wrote:

> Btw should regmap_write() return be strictly checked or not?

Ideally but it's a lot of work and very rarely fails in practice so...

--bfv372o6v7e25jvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhSfNsACgkQJNaLcl1U
h9AL2wf/UhpSAub5sDskzvufxHCw0mYvKDBzr2utJCbalzEorIDHgnNIFU7Pj/1T
OLnDdIYn5/lM2yHY/lCrHjXzpJ73heEd7QZxYRJ286mX0KJKwKbFADga6sK2ZWgB
z2FuoSPZnFQ7MMSa4xncqj06hb1wXMgOtTFB6bH6PSr1ngDw4aHf3pVpVjbDH98y
3L/UhOHFXAD1U7Oy6EiprzqerXP5dzLogLf5DCS0L7H631MLXIctJyZuMg+mRH/x
LnS8Z5wkbCJz8WMahuIf02L0roW167TNBVkRuPVfzw2pFUd4rJ6tt5sNLVaI10Wo
bGEnltPzfy1zgUOz4GUFwvmfNZIGMw==
=Fapu
-----END PGP SIGNATURE-----

--bfv372o6v7e25jvw--

--===============4936763906790932527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4936763906790932527==--
