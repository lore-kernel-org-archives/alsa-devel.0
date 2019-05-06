From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v5.2
Date: Tue, 7 May 2019 00:01:59 +0900
Message-ID: <20190506150159.GX14916@sirena.org.uk>
References: <20190506141144.GR14916@sirena.org.uk>
 <s5hr29b4qas.wl-tiwai@suse.de>
 <20190506144000.GV14916@sirena.org.uk>
 <s5hef5b4pak.wl-tiwai@suse.de>
 <20190506144834.GW14916@sirena.org.uk>
 <s5hbm0f4oid.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8989404743540186421=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 374D9F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 17:02:10 +0200 (CEST)
In-Reply-To: <s5hbm0f4oid.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8989404743540186421==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5VkoCU/Pi0S20qD6"
Content-Disposition: inline


--5VkoCU/Pi0S20qD6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 04:59:54PM +0200, Takashi Iwai wrote:

> The rockchip warning could be easily seen via allyesconfig, attached
> below.  For SOF, CONFIG_PCI=n is the key.  Attached in the second
> config.  For da7219, it's the lack of CONFIG_COMMON_CLK.

Yeah, I saw the rockchip one but not the other two - but I don't build
with randconfig type stuff so I wouldn't expect to see them.

--5VkoCU/Pi0S20qD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzQTGYACgkQJNaLcl1U
h9CAsgf8D4wKRT2+Wvh8jDEEQRWkLB1g7fg+oaWSuTY6UZcWUDv/5EM+OkY87T82
LYVMrgqAM3G/5prLmWEt/aFIVo5EbRaQvbfpyJtNKn4Ev1t93sYcOdadGbTGpcn3
l/4GVQp/mAG2vMsUtH9ZcGft3Y2x7jyN52PwzBbDuN8RVM1rRmg9K3/WTAZNqzer
Edzz9zBAMpqI1y5Kn3ZY3NNb3qxw8QmNvfd/j6fKXqVk3ApCGBIVa3LP0YYqdRxV
SLn+PsR8zBmdmo8lYYeT7kVVqJdwm5z6+WnVQy2euFHr29EeA4yn+aNwfFW+aLVV
Rhzyb9uDYncIM+50b+pSu2y2QCOWBg==
=TCvO
-----END PGP SIGNATURE-----

--5VkoCU/Pi0S20qD6--

--===============8989404743540186421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8989404743540186421==--
