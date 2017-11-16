From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/14] regmap: Add SoundWire bus support
Date: Thu, 16 Nov 2017 12:04:37 +0000
Message-ID: <20171116120437.h2ghxvwpsd6ovdhe@sirena.org.uk>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6257861490136718500=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 12B32266D7D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 13:04:52 +0100 (CET)
In-Reply-To: <1510314556-13002-8-git-send-email-vinod.koul@intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============6257861490136718500==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3a2vj7f2h7m7jy6"
Content-Disposition: inline


--f3a2vj7f2h7m7jy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 10, 2017 at 05:19:09PM +0530, Vinod Koul wrote:

> +EXPORT_SYMBOL(__regmap_init_sdw);

We still have plain EXPORT_SYMBOL() on the regmap exports...

--f3a2vj7f2h7m7jy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNftUACgkQJNaLcl1U
h9Cu7wf+I/NJK/4FdHL6Wca3HHC68wer7Z7ehlYvuACJxpyi90jLVSp5ZuA0Wxq4
qsWor/9hcf4F8bEEC6OIN0u2quKP4AlkN+Gt3yQgiYTKPLVYSOIPCFK9SZTqEDAu
28RsKl3OUEhOveARrKDNaIKWMp2911a9LKlBkpsE+cj4I7McWtEvRSxLbFN5iUbJ
KA9H9I765Gjm68fHuiGL55IUSfAVG+mKbt/hk4XViBmoc81d0rRKHd5wA7JWj1lH
1IJSCBbBenKRsNftI3y5dr9b2rFj+kBDsZKc92oXrYGq3fuux8UBUTQeakAMKKOu
YvX3IV3Qnhra6ETiKi9A+p6P/TBV2w==
=1nk4
-----END PGP SIGNATURE-----

--f3a2vj7f2h7m7jy6--

--===============6257861490136718500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6257861490136718500==--
