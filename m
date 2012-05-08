From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: omap-abe-twl6040: Add device
	tree support
Date: Tue, 8 May 2012 14:59:13 +0100
Message-ID: <20120508135912.GR15893@opensource.wolfsonmicro.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
	<1336479314-27766-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1469435980931569896=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C80A10439C
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:59:15 +0200 (CEST)
In-Reply-To: <1336479314-27766-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1469435980931569896==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Content-Disposition: inline


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:15:14PM +0300, Peter Ujfalusi wrote:

> 	abe-twl6040,jack_detection = <0>;

Shouldn't this be a boolean property that simply needs to be present to
flag detection?

> 	dai-link1,codec = <&twl6040_codec>;
> 	dai-link1,dai = <&mcpdm>;

This seems like it ought to be an array of nodes, one per link, instead
of having an index in the property name.  It should certainly be easier
to parse.

It also seems like it's not at all board specific and should be factored
out.

> 	abe-twl6040,audio-routing =
> 		"Headset Stereophone", "HSOL",
> 		"Headset Stereophone", "HSOR",

Binding should document what the board-defined nodes are.

> +Example:
> +
> +sound { /* ASoC */
> +	compatible = "ti,abe-twl6040";
> +	abe-twl6040,model = "SDP4430";

Please don't repeat your binding documentation in the changelog, it's
already in the patch and means it comes after the documentation.

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqSaqAAoJEBus8iNuMP3d5u0P/inCsUV1uVETaPCV8Tl15TX9
A+vaYo5oQRq/c+a4061q+d5lQ/k1JEZQI4XHlaF/v80edOhObLlXs2LzWWfm3oLm
XSwGgZhffiwvtofTY9a5IM92OaHrR1hRMI8QHc3FtxYya3D17ZO6kW/BvLDC/cZy
yvLbCQqUFNarjUC7xP92D9X6hF7AjqrMGd5fS50CQ6XKONR7628GBHKBgCTxo8NC
USCPYRMOcdjY13/Oe9v+WoUrtriT59nHHQB+S40FMa98N6I0+vIDHoxGDF9D3wyK
Jps6vR9DPt2ZRxFt1HLmIk++6h/8GTlRKTd9BOeWFf0Vf0bWBE185KfzjFE3IwTL
U6ni59/8oBcxH2U9+kQtKVKvFHmZIay0RNSm24bNYMRT8O6t+o6+JpfW69r2dVBE
LgpFxlcxfix3fXyU1RAtoFQkbQR2T/yQPiwFC0cJqVuXXmLvJPreNUid0S7s6akC
ZJ02F2npdGrFoxN3ALiPl7CTgtS3zfuyhzB6JpgP6CIi+Ajse72cgn+XuEe2kRLN
Xin+PwfpfJYKeC1bX7QdFFZq84F9zTcf3/pb84uMmix7tMLCCXQXOfnQafJGFlxi
RlWJSa5O6QY4rQRWbUU6gs3iSNwK5zNtysuTO9kfa8ayXDB+xpIKIGiCuMIALAIQ
I/6WrW+jooF5J33A5f1Q
=TRth
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--

--===============1469435980931569896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1469435980931569896==--
