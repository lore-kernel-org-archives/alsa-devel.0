From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] Revert "ASoC: Intel: Skylake:
 Acquire irq after RIRB allocation"
Date: Wed, 12 Sep 2018 11:20:20 +0100
Message-ID: <20180912102020.GB6062@sirena.org.uk>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180911211246.31914-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3813226705956580299=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C81B326779A
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 12:20:25 +0200 (CEST)
In-Reply-To: <20180911211246.31914-1-yuzhao@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yu Zhao <yuzhao@google.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Naveen Manohar <naveen.m@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3813226705956580299==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2018 at 03:12:46PM -0600, Yu Zhao wrote:
> This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.
>=20
> The patch doesn't fix accessing memory with null pointer in
> skl_interrupt().

Please use normal subject lines and so on even for revert patches -
they're patches just the same as any other.

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluY6GMACgkQJNaLcl1U
h9DGywf8DYNfd/WiS0dCivsUNwaEIUEC+QB9mCA4l5HmfQii3lFaSziKcBqJzbs0
cQXS+ezZAqOErrH/ZszCv3uwu/FIx8Q9UsTYwrsyBkPydK//hcnpNOtns2y3ZpXO
5k+8lovzua3TXBtFpyfoLM9eiQaludSHffvI551/I91+2qJhmKCMMhcdNWFuIN+A
+D5RbPPfGlEibsIJKMV7Vyspw8X9tDGWDapndp2VBjw4/RjO9kqLKvcQkxdwS2Ce
L78kK4mWKfEu6ZWm0RbbHKTLDIV89VLUeyEQO9iEDCudqW2rU3hAVZcHwIpCNiLc
FTTl0DSLcnhPCMSRJwQ9xq11nJ8tQg==
=uAdh
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

--===============3813226705956580299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3813226705956580299==--
