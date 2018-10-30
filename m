From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: stm32: sai: fix invalid use of
 sizeof in stm32_sai_add_mclk_provider()
Date: Tue, 30 Oct 2018 16:33:19 +0000
Message-ID: <20181030163319.GA6462@sirena.org.uk>
References: <1540606799-164510-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0275382506579668185=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14A252677D0
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 17:33:26 +0100 (CET)
In-Reply-To: <1540606799-164510-1-git-send-email-weiyongjun1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, kernel-janitors@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0275382506579668185==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 27, 2018 at 02:19:59AM +0000, Wei Yongjun wrote:
> sizeof() when applied to a pointer typed expression gives the
> size of the pointer, not that of the pointed data.

Someone else already sent a fix for this.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvYh84ACgkQJNaLcl1U
h9D2PAf8CQBR//hQIVawDMD9txVZHFp1FeTXTFRNmYHoG7e7Hukr3a2IEhRCBa4f
eM4kmf1UpVKD8V5kUPDKDllx9SGVxrxEeDPAQmu3detQ8vdWsS1p5+Q8fCvwbTsc
GuBk+IXKzFybzSqiu3tAf3DSPU9p0z+00mo4KmghbrwUAZuKAeu55KC32EEf85Cd
WDPAVGEQ9rUm+YcdNGidf604yjGQy0gB5DuwLpq+t5f41O1NscnLEeusM83if7Qh
fSpFccKSr+CN8yniLocbcRE/B2NUZymGfa7+ZMeqD+eU+G7fCHqQ1yBJH9OhpH/f
Swim64E6tY3M8WOeqe+ZLrLN/De0dw==
=Yi0e
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============0275382506579668185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0275382506579668185==--
