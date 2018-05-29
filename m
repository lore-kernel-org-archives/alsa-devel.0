From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: simple-card: set cpu dai clk in
	hw_params
Date: Tue, 29 May 2018 12:16:32 +0100
Message-ID: <20180529111632.GB23509@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1268507500448395861=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 258D526763F
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 13:16:36 +0200 (CEST)
In-Reply-To: <20180528193503.18905-2-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============1268507500448395861==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2018 at 09:35:01PM +0200, Daniel Mack wrote:

>  	if (mclk_fs) {
>  		mclk = params_rate(params) * mclk_fs;
> +
> +		if (dai_props->cpu_dai.clk)
> +			clk_set_rate(dai_props->cpu_dai.clk, mclk);
> +

We're ignoring the return value here.

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNNpAACgkQJNaLcl1U
h9CuuQf+NurrAONbNOyOOE9hCwuh6cEjHBdQlVpeDe+PURwgiiveVkI39MhwmPOr
BK4q8t+SC+2nUbrHbC7EPLB0YzBAAbzKBkpzJxUcmshzr+8OkfGfEnih/cY50IRg
fHHp37cwHSjdZTNM5AjPFG+1L+zw0QGAaAD8Pwq3c0uQE5w+tgko1olfRsGJnxpc
JPyhkOXjjVLFicET7pWEwCeJmofheufJzaw2gXNrYohhUKkMKXz6uiAMJAk4R3DE
3y/7kokChkgaUNAi9LMzTdjpruZHm5KC0Pd5ItadUn9uWp8p+f9zhKzPa5NmcWa4
5Y57jolKDLpGpFqdmGPiy6XlzwiJAA==
=CiAN
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============1268507500448395861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1268507500448395861==--
