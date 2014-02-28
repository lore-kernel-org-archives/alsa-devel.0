From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: io: Clean up snd_soc_codec_set_cache_io()
Date: Fri, 28 Feb 2014 12:47:02 +0900
Message-ID: <20140228034702.GI9383@sirena.org.uk>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
 <1393494593-26310-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="588wvpgrYaEESfyK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393494593-26310-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--588wvpgrYaEESfyK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 05:49:51PM +0800, Xiubo Li wrote:
> Now that all users have been converted to regmap and the config.reg_bits
> and config.val_bits can be setted by each user through regmap core API.
> So these two params are redundant here.

Applied, thanks.

--588wvpgrYaEESfyK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEAazAAoJELSic+t+oim9OlwP/0coeFE0yRzho8Ed73TOG7Vh
3nMmsBQg2xyYeMo5/rEz2S9NEzWwCzQ2103c76EEu7YXSN2BT39vqknKaYhWsdd2
/c2dqTHVmNrs0rvjhiGrI1yKAUCrxqpl6U1ICsUPtbD6UHObzesZZRXwlo6QRsJi
k599BJHpMUGhd7+uHGY8LaLKn+QIMTxzBzs67bm59LF/anlXzuBjPy7F/xY0x1+e
xNzSpO7NeVGxseg4okfXz8xp79A0/IRtwKxBoMST4LiaQa0e12hb8xPCKeja2A9B
/iEycwjVfy4T8zIOh3AWAQvFf59RV2X9Wv9b/K1ABbx5Kjag5UAa2/DyNJ4YqrYL
n3ayXndLcO9u8Mdl6SO46T4Ct0+H8TmmblUTb27CbTecQ2peE/GLNiO1OKUtiz60
sLPrVUsfpyqRG+4/Hncyvr+oM6UeaKzgRicNdfAzrJ/n9YjYrY2FW5ktqEwy8dmr
uH/ouqC2kVtaqPfggPXya/eNkfO8uLe/Pd3C/8wOZh5m4mpK1wM31u3IO/EvkkIe
J2TBadE+3myWJcFJu/iYsv3jHCbAuylIcuW8lCRrx3vQVdShg0tC7oNVEy/bktKo
65rBYN0iywAtauJDYdiCSm7ZHZK1velnS9ifnYMGlGtxxxVKHypabpNgwvL2IWDj
cm4BypfcqWGExSwPqfHL
=xFqG
-----END PGP SIGNATURE-----

--588wvpgrYaEESfyK--
