From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: fsl-asoc-card: move 'config
 SND_SOC_FSL_ASOC_CARD' to 'if SND_IMX_SOC'
Date: Tue, 19 Aug 2014 11:12:17 -0500
Message-ID: <20140819161217.GK24407@sirena.org.uk>
References: <bfed4dfd3cf1ef134dac1f114f3d2b8cedf55c68.1408440952.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8143237863939285033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B84A261600
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:19:59 +0200 (CEST)
In-Reply-To: <bfed4dfd3cf1ef134dac1f114f3d2b8cedf55c68.1408440952.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: fabio.estevam@freescale.com, sfr@canb.auug.org.au, alsa-devel@alsa-project.org, timur@tabi.org, arnd@arndb.de, shc_work@mail.ru, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, xobs@kosagi.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============8143237863939285033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 05:36:41PM +0800, Shengjiu Wang wrote:
> Build kernel with SND_SOC_FSL_ASOC_CARD=m && SND_SOC_FSL_{SSI,SAI,ESAI}=y
> leads the following error:

Applied, thanks.

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83deAAoJELSic+t+oim9uToP/i3y1fRfHj1rQn0Iv+LEJd91
MjSO6dPrx5Bvb7AOzfSNTYpu2i3vnHiDfb/tu9/316WllJFZPf96rECTqJJAYnT0
63BM1UfkYtSR3nXB1EEa9vpKc2GJbEZthz3ONRiB8UGVmH0RHNhql6ErGig09TgZ
v6EylmP6t18LhL9rFzzZK0CpjaLAKADk59rTCqIYU+tyh3YEtQwAnqBOzsVtCfwU
SemBNPD3SkOoq8zoi1Pc9Ohc2pOgws2BSMOZDURZiU2vqNASJUIrb3Tgq7yiFqFA
Pf6xVBBZ0b3wS4I8FcWzyOnSs8PWGPTHQfUbeCqDmD1IBH6BYpTnzwS114PXZaNk
aThJnaYVEzhR5LZGCbfpfNMeDyKEXCOk99R7H7UCowBEAWBdzziZ6vz00sDLrACR
Z8pe4s0EqklPtYYBNqMu/OMR5Q5R5wJIGIrr0LiEZFs4O7vZ0rfDaqOw5N+f7VQ4
16vL4aTPIR3g2F4ehzUFldgL/Q5LdQlaTO9cGJ+x4B1Suim72Wboe0OywIeUlJXy
Sq7c+MHPHiEw/PnXrnhHvjjBV+vFx8UfR0wLyVge9QILofkccz4SiEzu9CClNDBN
O6TbXLcMnB3OsakT+qHe16dk5PuMKfIC+XUgA9DrXlKLgHt8yc+eJUQLJcMBGrmO
ZtHiCPbS2Qz3htw0LZrY
=V7E/
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--

--===============8143237863939285033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8143237863939285033==--
