From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][RFC] ASoC: soc-core: WARN() is not related
 to component->driver->probe
Date: Tue, 21 May 2019 19:32:42 +0100
Message-ID: <20190521183242.GC16633@sirena.org.uk>
References: <87imu939x3.wl-kuninori.morimoto.gx@renesas.com>
 <0ba565ea-2f61-015d-f6e3-63124f94e78a@linux.intel.com>
 <87pnoeyo9f.wl-kuninori.morimoto.gx@renesas.com>
 <513fa7aa-60ca-dea2-1888-1d9df531f478@linux.intel.com>
 <87d0kctzwb.wl-kuninori.morimoto.gx@renesas.com>
 <5d16b18e-fd21-931a-ced6-f682afffc5b8@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2969139787793035730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26AFAF806E7
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 20:32:48 +0200 (CEST)
In-Reply-To: <5d16b18e-fd21-931a-ced6-f682afffc5b8@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2969139787793035730==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2019 at 09:22:47AM -0500, Pierre-Louis Bossart wrote:

> I don't know how to help further. Doing this change will result in the
> warning being thrown in cases where it wasn't before. and since no one knows
> what this warning means in the first place, either we leave it or we remove
> it, changing its location would be very odd.

It's fairly clear from the commit message what the warning means - it's
trying to catch drivers that had buggy probe() functions that left the
device powered up when it was expected to be idled.

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzkREkACgkQJNaLcl1U
h9Dm8Af/bmXmRN5vMf5QNJ4HF13lG7ZP1MTfDnXMA/C86c8Sn02/y8veeOI5bXY8
BJMgxYSAgChCdmSPM/O4RGpvwopbVu2LNZWSCOduChiqb98GEi52sob3WJETjMA6
b6NMhvV46Hfbr/TVC27Bw0bRujmZDlVtbBfQ51Tw0ZJKbsx6kEul43JJ6KZjTg91
ETCdKBEAceCHM0VWxEINqUcYVcaoYdewjIhcLp8pq71OxgKdcCXMjp65sVyULnZ1
CvgyKM0oevSmOow7k4REipUJIznGkUz3oepucn+RpXpyqgc001UhDQHNgDY2hesE
qKMO3435h00P587Z/877ZPJ+bGJTQA==
=5x+g
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

--===============2969139787793035730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2969139787793035730==--
