From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: imx-audmux: Fix ssi port numbers
	in sysfs
Date: Thu, 5 Apr 2012 15:25:35 +0100
Message-ID: <20120405142535.GM3129@opensource.wolfsonmicro.com>
References: <1333629952-18243-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1400352011031752177=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E553E247FD
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 16:25:40 +0200 (CEST)
In-Reply-To: <1333629952-18243-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: joancarles@fqingenieria.es, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1400352011031752177==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+utxuhC6KVTvgNz"
Content-Disposition: inline


--m+utxuhC6KVTvgNz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05, 2012 at 09:45:51AM -0300, Fabio Estevam wrote:
> Doing a 'cat /sys/kernel/debug/audmux/ssi7' causes the following oops to be printed by the kernel:

Applied both, thanks.  For bug fixes like this which apply to the -rc
releases you should generally submit against the stable tree (or Linus'
tree) so they can be sent to Linus during -rc.  Fortunately git am just
figured things out easily so no problem this time round.

--m+utxuhC6KVTvgNz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfatUAAoJEBus8iNuMP3ddM4P/Rv8bBNrAS+EdRC8NOwHaFKQ
dmo7b6XKYiWKqVklsXo0Semj6AGVmy1sT0RIQTWL8yyP05QCvd78vrFlJQB+7iZx
Fuskm/t03RaDeZJJD7MW2gTgDfQ/Vf9o2BVyuQNSmvdunyyPrp+H8EseNuO6KKDM
vJeoxF5dRZb3Rm+HUolV5LaLcycRNAUP7yGdHD9pRntQZr+oDHosOLKBxsGrS90Y
Jz4REndIOH0S00VUVSn4dSIyV1lzoeLI0dIOgS/kULdycgSaDXXaVva4N3BGXVl2
EnL8HUEN75Z5zF8obEOkF+39IVq5IYFICjzNX0aNaiPxlKGaPsvXjP2Toadiy7J8
s5SoVW0gjhB66N4sCdboc53VMs4SijFFcReG1tweSDLftoqhod9fOfnDr3S/76CW
EFd5tiA9FDT0BW2Tjj78UJKtUSeXizk9EKVzN55FbGnwM8pX8q78fmhSp9zP4BEf
oTbWdlmRDYByUP9lWsUGXfE+pDW1AslgBhHliyqJcxGQNVM3Or45w/NexxhY3Ez4
Xnb+JezIsAAV3KNgUMUS36ghkLLpd0+ab4YjtyohuTLoFVKfss8sxZRMMtec4nww
yZbGV1+gTF24P5z2mwJM2GiJXC9eQfcXD3xkul8o0fQWClnOlpBmQOJ9t04dKLAW
4oAE59eqU7MxU7+pQXby
=HlnS
-----END PGP SIGNATURE-----

--m+utxuhC6KVTvgNz--

--===============1400352011031752177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1400352011031752177==--
