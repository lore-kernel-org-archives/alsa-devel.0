From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 16/21] ASoC: max98088: use match_string() helper
Date: Thu, 31 May 2018 17:02:06 +0100
Message-ID: <20180531160206.GE13319@sirena.org.uk>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-17-git-send-email-xieyisheng1@huawei.com>
 <20180531114921.GD13319@sirena.org.uk>
 <8009e494-9ba0-bff3-e900-37f8923886a0@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8009e494-9ba0-bff3-e900-37f8923886a0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 31, 2018 at 08:25:39PM +0800, Yisheng Xie wrote:

> Anyway, Here is the cover letter of v1 and I have add v2's cover letter to you:
>   https://lkml.org/lkml/2018/5/21/303

> Each patch in this patchset is a separate one, for what this patchset want to do
> is use match_string() helper for echo subsystem.

For something like this it's generally easier to not send everything as
one big series - it avoids any confusion about dependencies and there's
no actual relationship between the patches.  Instead just sending each
subsystem as a series or perhaps even just a bunch of separate patches
should make things smoother.

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsQHH0ACgkQJNaLcl1U
h9ATxwf/cfSRfTKeyj24thB7iAGirKwmtfR5w42ZeMDl76thS0CTw/StQYGuUgTj
NTtpwb4GlvYRVN1k4pYScbie2kf76MVLw/gsAkctuwYbOGuD6MR7bRqv/mkEBdlK
1S0DW6iqmNLZ5e3lW1xnQAl1czz3fCeY6dD1XojeYKkAZKNuVLFFuF5t8If/YWZi
T1zOT1ExDHHfkAaPRo2SuEDTDpPXKenkfLu6vbw5qNnV0lkBGLDNfHMw4Qw3f4t0
G4hQNiHEUD8VYruFLQ/fzQs8y2+fVx8mnm06x4ZFC3X5bd0lWTxBVDKa0wmR7tmE
fmX6fLq8NEoTw7ZBOdnrZrHXRf6rRg==
=G6H8
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
