From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: Fix arguments to set_sysclk
Date: Fri, 30 Jun 2017 12:45:59 +0100
Message-ID: <20170630114559.ljqeozccdnmaqkho@sirena.org.uk>
References: <1498722411-2387-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5366377785328174352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF7332674A1
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:46:14 +0200 (CEST)
In-Reply-To: <1498722411-2387-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5366377785328174352==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nvdp7zfwztnh7ico"
Content-Disposition: inline


--nvdp7zfwztnh7ico
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2017 at 01:16:51PM +0530, Subhransu S. Prusty wrote:
> set_sysclk expects pointer to snd_soc_codec. Fix it.

Someone already sent a fix for this.

--nvdp7zfwztnh7ico
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllWOfYACgkQJNaLcl1U
h9DOTQf9EAZEYdOztlORq0fK08mqa1FPY+AmRHU77ClD2DgyxVbV61zSQPmqvpLD
BthaU9No6MqYy6cVXKAZa6JIBjbw45gPi04zaRvySeDSRTmV6L0zRnkHiUuH9AaD
YKwPMaLYDDOyYqRUw3vWa2KZ20Ro5jYorF3kx7Cno8zyL7TA7yXsZLOzCn4hMBIA
oDg/JGntES9ofFDzcgKt5Swlpz7ostbko0fveiWFg5SAIw/n7OlkGjISa6wBCre8
eGAkg15qX75elodZckLglAINksWxXqVKH/mDUBxrAXPYOYu9m9i4Hgn8c3wiZPdS
YV6KzqpmSqQeG82M1xz+1jdXAgsN2A==
=+XOc
-----END PGP SIGNATURE-----

--nvdp7zfwztnh7ico--

--===============5366377785328174352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5366377785328174352==--
