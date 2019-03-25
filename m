From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: intel: Fix crash at suspend/resume after failed
 codec registration
Date: Mon, 25 Mar 2019 12:02:12 +0000
Message-ID: <20190325120212.GD7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
Sender: stable-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2019 at 03:39:48PM -0700, Guenter Roeck wrote:

> general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 2811 Comm: cat Tainted: G        W         4.19.30 #15
> Hardware name: GOOGLE Clapper, BIOS Google_Clapper.5216.199.7 08/22/2014
> RIP: 0010:snd_soc_suspend+0x5a/0xd21
> Code: 03 80 3c 10 00 49 89 d7 74 0b 48 89 df e8 71 72 c4 fe 4c 89
> fa 48 8b 03 48 89 45 d0 48 8d 98 a0 01 00 00 48 89 d8 48 c1 e8 03
> <8a> 04 10 84 c0 0f 85 85 0c 00 00 80 3b 00 0f 84 6b 0c 00 00 48 8b

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYw0MACgkQJNaLcl1U
h9BpXQf/XfEhm9WgqLCoQ+xlQVQEw2hewJ8Wk1PV54Fj6bBmRWT+tth9k6itaC31
DZzkoO6uBFN7Oke8ca1GiIhZGMjunhdPw1/qz0XWAlxdTog8HxkQTUKnbBCPJ7NR
3ju+/14lNBj8/mwmmVMnSquEwpdbLqzNkRhvi2bIwVggirTkzPSYDWa+lJkhVIUm
fonPORs/dNw2AZL4l4ZsjSdfAg1CDF+U7BwoiWqwahCSWFYmx8xk1k721idiFBwg
emR8gaozeE2TVTxUuUWrjbL7jbfuqcI27z4M6LoLLWCqgQa+QGkv0VwfSCfvCuMk
lR9K+ideBQjls3GBiMawPDqyNvyWFQ==
=ggRp
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
