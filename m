From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt274: add rt274 codec driver
Date: Tue, 18 Jul 2017 14:48:15 +0100
Message-ID: <20170718134815.xomcjskmytryvnmm@sirena.org.uk>
References: <1500013552-1304-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8586569793424051904=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D92266C4D
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 15:48:26 +0200 (CEST)
In-Reply-To: <1500013552-1304-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, guneshwor.o.singh@intel.com, lgirdwood@gmail.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8586569793424051904==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vd23zjgvphbsqf7q"
Content-Disposition: inline


--vd23zjgvphbsqf7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2017 at 02:25:52PM +0800, Bard Liao wrote:
> RT274 is a HD-A/SOC dual mode codec. This is the initial codec driver
> of SOC mode.

This looks good, I've applied it.  There was one C++ comment deep in
there which I didn't want to trawl through and find to quote but can you
please send a followup patch making it a regular C comment.

--vd23zjgvphbsqf7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlluEZ4ACgkQJNaLcl1U
h9B2CQf/f4e7aE95MGfMWNxqMmQCUgI8s7vkOmrsesGXCuX52nEba35v+YmsgnlE
ttk+Kn47TxmHcIwmBS6UpfFQNnkNihy0jD1m+ppjao9RCY6Rvor0RbQKO5TX3Hfs
r2Z+gIqs9UecXMsFQBeQITHO453heBXQUJAvtc4WbzkGDUDQ9m4JUgfjc+PS7icz
v+7KsuKwcZySR4TtpVzGHvE8mz5ljS6K6UzT5mrxQEQgrC+Y5z1dtyAKp5aAV65C
PzGzuvJkfa+HSXLcSrcZaAnZ7J01bjVeSHFcSnQr4WevLps1Ipcumqmpt2mP5ObX
dD9YFw1SIJ3TvdYDJhr1NebUydnC+w==
=PiKU
-----END PGP SIGNATURE-----

--vd23zjgvphbsqf7q--

--===============8586569793424051904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8586569793424051904==--
