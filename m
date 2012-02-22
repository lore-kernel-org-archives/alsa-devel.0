From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 3/7] ASoC: mxs-pcm: Request DMA channel early
Date: Wed, 22 Feb 2012 13:22:51 +0000
Message-ID: <20120222132251.GG7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6005789517817281115=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3649F103F64
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:22:53 +0100 (CET)
In-Reply-To: <1329904151-5927-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6005789517817281115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 10:49:07AM +0100, Lars-Peter Clausen wrote:
> Request the DMA channel in the PCM open callback instead of the hwparams
> callback, this allows us to let open fail if no dma channel is available. This
> also fixes a bug where the channel will be requested multiple times if hwparams
> is called multiple times.

Applied, thanks.

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPROwkAAoJEBus8iNuMP3d7XYP/i/LFAE/yWLpJL5XwaOrCwRU
dyvhPItX835bjRzS5byXRqumrW20qTLmu8FUh+F6PaM/O4yG8/70AmFT2+LZyPrv
KG5il3GPnOI7hWIuSb0XjID2XjYBCCT9sYRUPzB0SmKpg8ToL/nj0hms5ycUHr3W
kHWSd82C2hoGPMyd1bNoOYrmodtgG829koL01zAqLqa3GLuivOfmBDUB5zQzBD0i
/lHLGyZVpx6SwC+kfurHnAadX/ctsR0KX11ZoIgKT58PW+LWVAseptxaONGkKCRh
OKwVdG7hp60p8M9XehLAZPTCvrdm83BOzoQl1Y0zPZr6gg6qitw8tHop3KmieEJe
7Nh4fWmoYB3/uUINoAO0KWHWxfL1CkRVtlX+33++QCD1ZRVHC020+Pa+Grw0nh/e
9FhG8N8sjjgA3cf0AQ4LRfCXj08pcz8BnTkrCKS8USfyIJrllAFcT/2RUC1VNq2c
5Yupkx22jDJAMVMcwCioIErmjnFPdDIRm8P5FWOkAIRqNroxly0+LndnU+gyvmpX
fL5whwGJxwvwpn2madAJmqgSVC4H9YcvVpNTDVUG+8/GVROr/GsjkAI7jqGr1Y7n
d4hl4PBkmtacK+xemySX65pd+JYNcwl5J7FK6UxZCbrItsxnrolRhIW3E6Ur0Jsb
PnTEtFfzp0CbIU1fJXEJ
=LGZx
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--

--===============6005789517817281115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6005789517817281115==--
