From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 6/6] ASoC: Intel: Skylake: remove call
	to pci_dev_put
Date: Wed, 16 Mar 2016 10:08:29 +0000
Message-ID: <20160316100829.GS2566@sirena.org.uk>
References: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
 <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5030804275841499903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 63C38265275
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 11:08:38 +0100 (CET)
In-Reply-To: <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5030804275841499903==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U7F658e60E1K4csu"
Content-Disposition: inline


--U7F658e60E1K4csu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2016 at 04:39:28PM +0530, Vinod Koul wrote:
> In driver remove we call pci_dev_put(), that is not required as we never
> call pci_dev_get() so remove that.

Why is the fix for this not to call pci_dev_get()?

--U7F658e60E1K4csu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6TCbAAoJECTWi3JdVIfQZ2IH/i82Xss0G4Rr3ItlKolbF6Ta
siIdqYnkUBfQ/CsqTpwvvQjg3moHzIXuByLDm43kKhpJcxQEvMXnK0l/vkzkG1Gy
uRqXnqHNhA5i1+knnHWMjay8Ho69bQw69cbtZ6oOErR3qfZYFiGY3tC54S5X/zgm
LqguO1qY+oMRKYoNNxQukAGuSB4aEnE1/92MevTff6bYpLkwWxaICJaBg7jFscjS
UXfjK3UEOROYE2pYt01+OUqYELpcF2+PfA/NK50dIB0CcESqbJDi0Aa/atJYAe4v
nZgIQLHKJkGlmwgpgC/UAIXHD5LvpR+zgn8sVRGrh7SO5ckPUxCze756Rm3OEfg=
=6uyu
-----END PGP SIGNATURE-----

--U7F658e60E1K4csu--

--===============5030804275841499903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5030804275841499903==--
