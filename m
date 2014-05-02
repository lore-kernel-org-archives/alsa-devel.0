From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix block offset calculations.
Date: Fri, 2 May 2014 09:52:35 -0700
Message-ID: <20140502165235.GJ3245@sirena.org.uk>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1399046194-5544-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8392316874203375000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF7E8265232
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 18:52:49 +0200 (CEST)
In-Reply-To: <1399046194-5544-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8392316874203375000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c4jr9uOfj6q35Id2"
Content-Disposition: inline


--c4jr9uOfj6q35Id2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2014 at 04:56:28PM +0100, Liam Girdwood wrote:
> Block offset calculations are done in the contiguous allocator so
> are not required here.

Applied, thanks.

--c4jr9uOfj6q35Id2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTY81QAAoJELSic+t+oim9uAMP/iry5FAh7ks8S238XXgm/Zny
C0FBUXKXjmJY7qTDbkrMRYqJYYQeSsw52oNgzUdjhuNRf9eMBUJP7CU2LZkIncqJ
sSDiDg6hUkt3CW3C4iADgqhCvO7pWSlY9dZu1tl2dAOnWeUm78BWHBxqv8r0XuvY
OcwHD1u45Qiti6Uqg0QFugttlnMihROVdnrcbtY5hzeyP36LQXKu3+ZnSQkHyN7C
xbYOqRzJ3j05cKS4MuuOrQO/x0qrJT++wl89dhqWWjY6KAxlEdG9DPusTAbWIlRg
YEQKH7Z/DIzHVCL+siQXaH880GII7+D7cjepZfQ0qTv8RWeKOJ0hjRddtIfAXYSE
3oOx8Tm51AfVCkJ8RxSumR8RzNL22+6dpSRgFom0AqXO5k0USBIWkwvSo+kdgP1P
jEEDf0kqI1OAecbCw3LQzQKhouxZLMaeb715jHRRgWLkJ2uzyT37UFND+8n5mcbx
Dyj+rp63W5HKxeG9lksdMSa3LCS4UktS1Ar1FvwnSUT6eeyaAzfAldFYzcUwPI28
Ih4D1AldaOA/z4Pkic1vQbYHyqRrW9hSrbA99P9+QnTnQotKRtlnpQUXumXmH8t/
c3K/TBsebQ+J/+hfRz6VYrrNv4hsFeK0f8ghLXbbGz2LADabzkZ4LG//taZmRj93
CHmuJUQ4FDX7mshDfn/A
=1KCm
-----END PGP SIGNATURE-----

--c4jr9uOfj6q35Id2--

--===============8392316874203375000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8392316874203375000==--
