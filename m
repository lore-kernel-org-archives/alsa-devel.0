From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] Revert "ASoC: Intel: Skylake:
 Acquire irq after RIRB allocation"
Date: Thu, 13 Sep 2018 12:31:55 +0100
Message-ID: <20180913113155.GC8411@sirena.org.uk>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180911211246.31914-1-yuzhao@google.com>
 <20180912102020.GB6062@sirena.org.uk>
 <20180912193221.GA194302@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8180457438271152792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E47BF267806
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 13:31:58 +0200 (CEST)
In-Reply-To: <20180912193221.GA194302@google.com>
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


--===============8180457438271152792==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 01:32:21PM -0600, Yu Zhao wrote:
> On Wed, Sep 12, 2018 at 11:20:20AM +0100, Mark Brown wrote:

> > Please use normal subject lines and so on even for revert patches -
> > they're patches just the same as any other.

> Well, they seem pretty normal to me, and have been used by many:

Many people do them but that doesn't mean they're good practice!

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluaSqoACgkQJNaLcl1U
h9DOxAf/Sg3eVYBP2uScARjWPUawo8JKhyX7xlU/Ddg3jYqux6XSmgswNXpWDRdR
ICOjitwnTXT0/1kS5F4wgrPMJgaeWPvstMgVYeUfN6HijsgGWvGe9HOOcTxpigsF
ffbf8pDEF6tchp5AMd6GjVwU/PE7EhIlnWvxAlesis1Qs8tbw7pNWR5Rmwp3JkJq
NWc+W9bCmLS9az4VvyoiCO1p6lYdRxbW6tfkDttAiqL75FCnrW5p1unbOPgBBwo6
/pJ4Myj/iY/Ic0FvIZxJ7XQUAkmI3RMuL/MtqcckFxU5T7+5/OzRWS3jVYuqfWWf
gttVuD7vBx1lj92yChjQFyRrxZmJcQ==
=MtNH
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--

--===============8180457438271152792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8180457438271152792==--
