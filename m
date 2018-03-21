From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND][PATCH v4 0/3] Add SPIB Support for Intel
 Skylake platforms
Date: Wed, 21 Mar 2018 09:34:52 +0800
Message-ID: <20180321013452.GS2186@sirena.org.uk>
References: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2620310948384992403=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E068826731A
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 02:35:05 +0100 (CET)
In-Reply-To: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org


--===============2620310948384992403==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MiMBASdxvnz+XAiL"
Content-Disposition: inline


--MiMBASdxvnz+XAiL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2018 at 09:31:05PM +0530, Sriram Periyasamy wrote:
> Skylake audio controller supports SPIB (Software Position in buffer)
> capability, which can be used to inform position of application pointer

You probably want to cut down on the number of tags you're adding in
your subject lines - what I see when I look at this mail in my inbox is:

-> 1061   T 03/20 Sriram Periyasa (1.7K) [alsa-devel][RESEND][PATCH v4 0/3] Add

so I can't see *anything* about what the patch is about!  The
[alsa-devel] bit is probably the main thing that can go, I know the
mailing list software adds it which is unfortuate.

--MiMBASdxvnz+XAiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqxtrsACgkQJNaLcl1U
h9Bmzgf/QqgN4zCb72suuWONn/sI+o29baTv7B5h1vKrEyDKO4H5tzeC0K3SXIeZ
/1Keol/MGQMjTfkl+GOK3+8rJrTGWg4OTZ5mAJSmnMgUbHrQSaMlybzOteSLoDtX
rDMznyX4o4doFNjGFNzxEOHbt7KDFy/XQKaZCjCLTOhgQ2CMe6y7hZfyHmV324HI
A5B9Vtdli6PpSm311gJ2cv0sZtZJoFFrUG4KHgJF/We41k+ttQIdBJkVUx3bbLm5
mlqH8U3ViiwPzGPR6idRI9ZATdtKXTd6kj4nLzMMlWTxQcD/X7PlSktkbSVvN1Z/
ceULYLcZVlEzhymWnYX/IxnGHrrGqg==
=HOym
-----END PGP SIGNATURE-----

--MiMBASdxvnz+XAiL--

--===============2620310948384992403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2620310948384992403==--
