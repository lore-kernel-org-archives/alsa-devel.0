From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 04/10] ASoC: Kconfig: imx-ssi needs imx-fiq and imx-dma
Date: Tue, 12 Mar 2013 18:55:10 +0000
Message-ID: <20130312185510.GV19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5673740431734987900=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1362940391-8338-5-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============5673740431734987900==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tYlHSoJ8Aop8eNG2"
Content-Disposition: inline


--tYlHSoJ8Aop8eNG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 10, 2013 at 07:33:05PM +0100, Markus Pargmann wrote:

>  config SND_SOC_IMX_SSI
> +	select SND_SOC_IMX_PCM_DMA
> +	select SND_SOC_IMX_PCM_FIQ
>  	tristate

Really?  I'd expect this to be an or, if we've got DMA I can't see any
reason why we'd want to use the FIQ.

--tYlHSoJ8Aop8eNG2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3oBAAoJELSic+t+oim9LCIP/iQCXHJ9k97fm42yRMnNedc2
c6ul4WD6IitX3feYP0WRUsXZahPAgoP4kJ/O4c+TffENs9M5kNhD3jDPXiLTnoZq
Scdv8dGFjoJSGl7WpP4GvzOIEzg6hLwaKd2MsovTjo78xO2Z66y4N/gYBjFJKHRr
X9z9m3Hhm6/R1GrWEceAEEgZFOxcUpFR3I3x4y8TEAdKa09kVTUgdQvTNTTfmas5
e75Vvwi6oY8mmNUyArl34MN8SDj4XgmaeqPzQ46BZDq7CTq25Qsc3NOxdmoJTmC8
U70r57nS62DYS5Dz9huYynB6kYsIyAMIegEAsDUAirTGBtvloXQW5P2WiGahQuUl
HQeWNs0qr3CdLZFpdRu0FAaSNWyhttAxzX7DZgDf25xV9XVY/JGt4/CKV7H+GA3n
9IAM7YMiqznkT0P+qYBJHUiJy56oNAncUOtKcP5Do01/YmbaVAwz2EU3mnNNhimE
SAOHa0+rlMEe+b6MQg6YCiJzQf2MUeBPMKvWnnIdPRV56ec5RkYL6nUaOYHOY8+o
SFw9ldga31AWydemkok4gkzos8opapa3plcbkiI4jQbdWVZxe//1XuFTAb0ZOn3G
HlLqpR6sEwQvyjT/SXWGiHZn4hODIin76i09zNFCAmxB1Q3VAasL1mAs9IbxkrO/
ACAtTAbh3A548M/cxFt6
=sRWF
-----END PGP SIGNATURE-----

--tYlHSoJ8Aop8eNG2--

--===============5673740431734987900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5673740431734987900==--
