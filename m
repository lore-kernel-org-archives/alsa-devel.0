From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] ASoC: Intel: let machines configure
	SSP configuration
Date: Wed, 6 May 2015 19:50:30 +0100
Message-ID: <20150506185030.GH22845@sirena.org.uk>
References: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1136338738661640125=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 790C3260716
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 20:50:37 +0200 (CEST)
In-Reply-To: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, praveen.diwakar@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, sathyanarayana.nujella@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1136338738661640125==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EczD2QKxqbAVC1qk"
Content-Disposition: inline


--EczD2QKxqbAVC1qk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 10:06:39PM +0530, Vinod Koul wrote:
> This series first add frame and data polarity to ssp config and then starts
> to use local values for ssp config and then eventually lets that be loaded
> by hw_params and updates by pcm format and tdm calls to allow machine t
> specify these parameters

Applied all, thanks.

--EczD2QKxqbAVC1qk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSmJ1AAoJECTWi3JdVIfQNOwH/0c4SrJQVTV/6S++lPVIHd6O
xYgjRVwimp21dQN44p3od01G2aLGzSrkBiNrLSKn7YDRMDVGktEe9oke20twqLfy
NXS4VnnHMa884hr4Rf0mTIh2/063htFw/4n3412Kf3bemA5CN2huUIWj846yk84S
DXQhjjfjGhyZjc3DBSci+kHxtIjndmLaMNrM3B4ikM04IrBhhYKpCE9dr9Ynd4eu
/K5Rngy88z1jBZGcfOntrhIMHunhaAtDdizXhTK9EiYoe9qLv4t7ogJy7osEswhO
cfzkG7LW3yBvX31DV/9Hw3FfEQ0T4A1JC4rqwqlnTnocyYogUXysuoZVPZicyS4=
=KNDH
-----END PGP SIGNATURE-----

--EczD2QKxqbAVC1qk--

--===============1136338738661640125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1136338738661640125==--
