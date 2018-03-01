From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 10/25] ASoC: qcom: q6asm: Add support to
 memory map and unmap
Date: Thu, 1 Mar 2018 21:28:44 +0000
Message-ID: <20180301212844.GU12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0960365840037577997=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FE24267C40
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:28:46 +0100 (CET)
In-Reply-To: <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0960365840037577997==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="niUlcCfh/sMBwTxc"
Content-Disposition: inline


--niUlcCfh/sMBwTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:22PM +0000, srinivas.kandagatla@linaro.org wrote:

> +	num_regions = is_contiguous ? 1 : periods;
> +	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;

Please write normal if statements, it's much easier to read.

> +	buf_sz = PAGE_ALIGN(buf_sz);

I don't understand what this is doing, buf_sz is a length not an address
so why are we attempting to align it?

--niUlcCfh/sMBwTxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYcIwACgkQJNaLcl1U
h9BM0wf7BJhu/GsY5odkp6NACTy4X6ZG7hEyKG7kzoSlcdOkp2LTimDfQXjM6WUi
T/uWJuO2pUeR5tXp3nVZbjeyeeEjhBbNyBtxcBZFHtkh0mUyKoYxSsYJxanLcXDg
Pdgl1BWCXrNQIhyhleHidL8McBKUmz08ecsuO0aPRn52dRM0ZwIqNPcVzwpW2/t9
8YsDK6uH1wtM2G9cI6dIJCW5aKoAs7SU+jd+HiPm4PWP6df76nucNKesoFnB9qvd
4fpOubTMrCqn/f7JazBLlLT+6l1BJToHbxEBNIm9Xg7edElwxhPGUILOF5CbAgKa
RfpEpX/inf0urcCjJsgdF4AUYfHVQg==
=xWCm
-----END PGP SIGNATURE-----

--niUlcCfh/sMBwTxc--

--===============0960365840037577997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0960365840037577997==--
