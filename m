From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/5] dma: mxs-dma bugfixes and cleanup
Date: Fri, 11 Oct 2013 17:03:09 +0100
Message-ID: <20131011160309.GE2443@sirena.org.uk>
References: <1381493539-31756-1-git-send-email-mpa@pengutronix.de>
 <CAOMZO5AG_efwTbtUjG8TPEY=_kyjrcZkEQV6XfZ6CLZ3_msWig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2861245688744499694=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 03435261A80
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 18:04:16 +0200 (CEST)
In-Reply-To: <CAOMZO5AG_efwTbtUjG8TPEY=_kyjrcZkEQV6XfZ6CLZ3_msWig@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
List-Id: alsa-devel@alsa-project.org


--===============2861245688744499694==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 11:01:29AM -0300, Fabio Estevam wrote:

> The problem I see is that randomly the captured audio becomes
> extremely noisy and loud (throughout the whole 10 seconds) and then in
> the subsequent loop it becomes normal. This is very random and it
> happens at a 1 or 2% failure rate.

This sounds like there's a problem with L/R sync or noise on the bit
clock and the samples aren't being well aligned with the clock.

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSWCE6AAoJELSic+t+oim9EhkP/0FrrjX+BaqkG7Qifi0rPdSM
p/uFm1YF11Po+I5tU7lKJWqSsS3YEcv0hVpm0+zJscZdFURJW6P8bxI7/nxNSFTG
u54EvtVjv4nyZOqUcPZ7CuunkBC4kznhTR5PSPN8Rlhs90UUczOSomtVMxJmUO4d
XBkg7kz0zf17ZpPwESZU9UmqieQRNx1r8PoFzzAJIttcg3+SdJeQSZK39IuauZKQ
7DAWLwtibQ7Qd00Dm/HnxxlnejfKtQbr9kJqE1WYcbL6KEXSknK6CawcjzdzauCF
7/lde+R5aliFF3ee9UOOBeA5bLEHmekxQSl8wB6pGDkdmvdOxgsF5xzilldgynEx
rYtkuIenmLP9BKTuXcFo5c6KAkUyNTGt7G9fxYofA+NIdp1yJjNMdD4yvNBP+Edv
yoDckIikYMrVxoJOKRrLtTpN3YdrIfBeLAPH5yyVEYHb2+SV9bCh4/1+MZUWNiqJ
ftT52qk/RRT2OAnKU8X6V14F3FBUP+WTWI0xgQI4mgvrv6Z1Yv31kia4cy51mlPf
CglD7ZjfbWRTcMKmZgDJKOOUAY6YJ2nvh0Mbzp4iFuabiKFncUJODDDJYTiD3Zt+
AwjjuJs/hGoULCRi7A8CMJ7lLj9bnePrpVDxKwotxbJW1t2ymvGE4MnBEsk5+o7u
RerNrnihIiYO3h+gKOHE
=agum
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--

--===============2861245688744499694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2861245688744499694==--
