From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Allow imx-pcm-{dma,fiq}.c to be modules
Date: Fri, 5 Jul 2013 18:33:21 +0100
Message-ID: <20130705173321.GE27646@sirena.org.uk>
References: <201307051745.16140.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gh2JYkGr6j7wjbGc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307051745.16140.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: alsa-devel@alsa-project.org


--gh2JYkGr6j7wjbGc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2013 at 05:45:15PM +0200, Arnd Bergmann wrote:
> This is required so we can build the imx sound support
> when ALSA itself is a loadable module.

Is this actually OK with the FIQ APIs?

--gh2JYkGr6j7wjbGc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1wNeAAoJELSic+t+oim99ksP/3F7up3niULTjowtgQBPN4Qs
XmeUai1mgaVOg5+El2EifgYUR1XE7x4cSbuYI+wsRIQLzabxUl8wsqvBQHLQN8zh
Mf7cieanDbdfPBjb54nrkq6vhSdCxOgm4mMmBWHItk0EH4U7TRoJMEin2h6E1Rd5
NiTe69FA6atqfzBMPaTZkevApJQSs0wDxdst6dqR3k3IiBACFFeU5XM4BSKmEVa+
Ham6pHFSlVaLfTZIiA8qnvI01FcjNZcm+YJsn6+zadA2MjW/zl/ZWji/5DIsaVOv
EMMxh7zQp3MwT77hEL2Nt/xO12ik7CYQWQYxJ8llk1qW9pk5VwdR6CLxGe1/cV3Y
71BW80gEPSkSrrcFJDhNPEvxVUrQe/fMA8dpJvoIZ6CfNvrm2192wAtJRCClsRe7
wDIAyUQjq/4FZAaxlnAClnxDtxZIRsY/4v4dr3qYRe06lfYcrqZQyaenZleRtE3M
47zD2WTlPi0EQnp9Su5FctjnWAnrMvpoTDqWEaj43Zb89JzJSJD4c83ATfwVv3YR
r6Z3FHbqtHVYEv1VQvxpjx0rucI9FBbEsm+efUzzuey8EbAxLI6oDE/rqSfsexQ9
Y39iCl4EryprFegDqO6RQPLkXKrFg6zV4EZBmnJkvRwOrPnx7qzMp2/5f657bjV4
TPUJUSHfGkmdGnybmaH0
=aJxK
-----END PGP SIGNATURE-----

--gh2JYkGr6j7wjbGc--
