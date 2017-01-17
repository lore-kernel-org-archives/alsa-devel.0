From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC] ASoC: rt5663: use msleep() for long delay loop
Date: Tue, 17 Jan 2017 19:34:34 +0000
Message-ID: <20170117193434.ik624rx3ij6hukov@sirena.org.uk>
References: <1484146993-25429-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="usejepglpuzmqczg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484146993-25429-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--usejepglpuzmqczg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2017 at 04:03:13PM +0100, Nicholas Mc Guire wrote:
> As the overall delay is in range of seconds and the wait granularity
> is 10ms msleep() seems more reasonable than to put load on the highres
> timer subsystem.

Thia also contains a whole bunch of other refactoring that's not
mentioned in the changelog...

> This does throw a checkpatch warning with:
> WARNING: msleep < 20ms can sleep for up to 20ms;"
> but since this is in a loop and the intended granularity is
> 10ms with up to 2 seconds total delay this seems ok.

That does depend on how quickly the operation is expected to complete,
the total delay is likely to be a massive overestimate.

--usejepglpuzmqczg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+cckACgkQJNaLcl1U
h9BvdAf8Dt2zTF/ijNT++S0hNMijIoDtaL0vAWK5QhQ1wAUv7NgSf4kUL8oiO1n0
U2fAv8Qrec07ZcdHCxBcqDgU539xafTRzgi3so/l4UY4noU6+YaqC0pqgyAA7v3i
TBd/30m5UuWwLjYf2ST0UyvO40HYE46kgjrHOo1Z6SVRiJdv9wbdijUGIuwhKHE2
USfGXSuzqHoRpncdh9c3D4rOhM6eNjVBAlbxkSeuK7uV1SXeOxl/jo6PUdDCPADA
E2zU/1icj9PyP5fWFI1HGfO7+F7IoiNegiqhj6Yh2AVyGx0J5hC0Wi9XuaAC+E4S
m+QP24vWK/CIs2JfpUoq4C51qx8yQg==
=46VD
-----END PGP SIGNATURE-----

--usejepglpuzmqczg--
