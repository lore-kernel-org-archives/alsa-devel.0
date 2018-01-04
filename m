From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add
 db820c machine driver
Date: Thu, 4 Jan 2018 14:03:19 +0000
Message-ID: <20180104140319.GH10774@sirena.org.uk>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
 <20180104120244.GE10774@sirena.org.uk>
 <418b531d-9d51-80c5-85aa-8ab8ef27bebb@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5903333804434298245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4009726782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 15:03:22 +0100 (CET)
In-Reply-To: <418b531d-9d51-80c5-85aa-8ab8ef27bebb@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5903333804434298245==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2018 at 01:44:30PM +0000, Srinivas Kandagatla wrote:

> Initially I had this in pcm driver, but looking at example usage of
> snd_dma_alloc_pages, most of them use card->dev and some of them use pcm
> device for allocating dma memory.

If they're using card->dev for DMA they're messing up, they need to use
the device associated with the DMA controller.

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpONCYACgkQJNaLcl1U
h9BoKQf/eOIMROEd6tM9fz3SDflcwGWZ21eXuHgpcKHxqV+viREPLlp+3Os7eg39
VyI0YVbI/vIBpp1qib/3YngsOdwyRbdEYBiNiM3faO6LrxH6gMnjcG7K26MB8W8U
dBgj8PK35qzMx8W4/rEqoxAo8zqwO5q0fFaUo47WoRyLuPSH8o9pFni80BYzniax
aqQcp2XdGVeWK9TUBYHYC70HcsOYmdAtbd8dzsbNfe1xn41Ry0SN8kN+5wjS9qcn
YyORT4kwKoCjUrtEgVsGbf6W8pgzyNUgGjb/a3Qnve11gt2ri4dgT9GxHbMTE3zt
owRonpUYnJtCzv6LDValisU4vXahmw==
=x4AZ
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============5903333804434298245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5903333804434298245==--
