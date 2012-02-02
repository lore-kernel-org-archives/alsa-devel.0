From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 8/9] ASoC: imx: add dt support for
	audmux-v2
Date: Thu, 2 Feb 2012 12:10:20 +0000
Message-ID: <20120202121020.GD7428@opensource.wolfsonmicro.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
	<1328148728-32258-9-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3615970447595965540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D4D782450D
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 13:10:21 +0100 (CET)
In-Reply-To: <1328148728-32258-9-git-send-email-richard.zhao@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@linaro.org>
Cc: alsa-devel@alsa-project.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3615970447595965540==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 10:12:07AM +0800, Richard Zhao wrote:

> +Required properties:
> +- compatible : "fsl,imx31-audmux".
> +
> +Example:
> +
> +audmux@021d8000 {
> +	compatible = "fsl,imx6q-audmux", "fsl,imx31-audmux";
> +	reg = <0x021d8000 0x4000>;

It's kind of obvious what it is but you should really document the reg
property for completeness.

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKn0lAAoJEBus8iNuMP3dAdsQAJyVXPJvhaxy6b+4+PyQBaUN
TVcScf4pYSTiwoY7T1qgHQSDpBtsq5HMn5ybp1KweH2fy5mg/FcUvKJ52p5Le/W9
fhxgvUdNyHFCgrmSy7NdXjxfbtuUx936gCSmH4vp79baPIk5uD9YknFuSB09wQpl
SxeHcFLzMvvv+YY2Bsuo7cwhbDUJScXJff5AZnRA0MQ+a1W8kJks58YVMuGsQU70
hsn70hMaftMsDzUfwI+YM+UNXFdetuA8zZRXskhysALJ4pYHEZR1VliwRCx0njPV
cjnLDzs+60AqEWKKLLGFAamaf0WsreoQrjTF9eGtMUvlfuq3nrFb/rC7xXvM3egQ
4eE9D1Pn1JsmZ1SxIv1qn11wgJAI/vmTwGZjRUEdUVGbpne9xOu0SAEpr70ZZH4I
NfpkKtADO91RWsrmGvAezWjfL0QRkIH6HL8JKQ2wDo08stXDOVvdXmtwFBIjlX09
bXGIAAIbiqvcMc/A4U8NWAcTXB6+QoiDYBf8BqI8oscbc10lqL8IYnu31RwHJ+og
u6E7pRSep7QnJXFy2uqcNeHv38FkC+wC+xvzNNcs63SeKYl5l1mkaFJzpDPG7DcS
czDktNTT4VouBcKomYdZEMQtnIYe7LHBBjqUKpNjFQ9Om/e3YqDftN2iOzrHjsrZ
tSKYlIHSl7msREVDura9
=s+V3
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--

--===============3615970447595965540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3615970447595965540==--
