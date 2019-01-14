From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Mon, 14 Jan 2019 23:26:08 +0000
Message-ID: <20190114232608.GL11073@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8153143238265222882=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BD772670AC
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 00:26:10 +0100 (CET)
In-Reply-To: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============8153143238265222882==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/jkxxxtAhYIHVDuh"
Content-Disposition: inline


--/jkxxxtAhYIHVDuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2019 at 01:44:02PM +0530, Rohit kumar wrote:

> -	if (!soc_find_component(link->platform->of_node, link->platform->name))
> -		return -EPROBE_DEFER;
> +	if (link->platform->of_node || link->platform->name)
> +		if (!soc_find_component(link->platform->of_node,
> +					link->platform->name))
> +			return -EPROBE_DEFER;

If we need to do this for every user (which we do pretty much it seems)
we should just be doing it inside find_component().

--/jkxxxtAhYIHVDuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9Go8ACgkQJNaLcl1U
h9A11Qf/Yrxphh6cv8p+IFzDXG9ACozaoDAZvSVV28Vk8dLUNepecWcgeJs1Y5bQ
bbRy093mTSg7itKQBgYok76GwpdQOQbtGVHgVQqvoY/1Ns2M/UZF2bYIfRV6JRUS
RD/lUVc5K+2xz9bOvte60oMNwjBurRYv1kMdv2t7gQ3GPx8p5Jkp8MBREULYCRxG
BnYgpCO7nneoRa5617M9QctJvcEbTAi7IGCoSyHufrAcMh7KbWcGsK2vu4M8Muen
f1ThSHZ0esdV8elN3niT2mRMN49ZbyNE5FOIc8brEg9gkG7SSuRDFsFLu172a3iQ
oiJBUJ/cUCcqjIuGgvKOQ0q37CyHlQ==
=IF84
-----END PGP SIGNATURE-----

--/jkxxxtAhYIHVDuh--

--===============8153143238265222882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8153143238265222882==--
