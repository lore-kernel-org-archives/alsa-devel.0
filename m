From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: dapm: Fix return value of
 snd_soc_dapm_put_{volsw, enum_virt}()
Date: Wed, 24 Jul 2013 14:56:49 +0100
Message-ID: <20130724135649.GB9858@sirena.org.uk>
References: <1374672459-5202-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7809066841750541461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E6994265373
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 15:56:56 +0200 (CEST)
In-Reply-To: <1374672459-5202-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andreas =?iso-8859-1?Q?Irest=E5l?= <Andreas.Irestal@axis.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Hebbar Gururaja <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7809066841750541461==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9o6tjhKcA+PBUYK5"
Content-Disposition: inline


--9o6tjhKcA+PBUYK5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2013 at 03:27:35PM +0200, Lars-Peter Clausen wrote:
> The ALSA core expect the put callback of a control to return 1 if the value of
> the control changed and 0 if it did not. Both snd_soc_dapm_put_volsw() and
> snd_soc_dapm_put_enum_virt() currently always returns 0. For both functions we
> already have a 'change' variable which either contains 1 or 0 depending on
> whether the value has changed or not, so just return that.

Applied, thanks.

--9o6tjhKcA+PBUYK5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR790eAAoJELSic+t+oim90tkQAJLcTZ/Cu+1Iceg+xZhdEKvV
k8eRFqKGsHR+uO6VZGjKxsz7qlZa8x89ZKC4j7xglQc+tE5fObxKXDFxWaEJmOa4
Y+jZGw4P2PDag8l9BOJR1j2qLB+CeBmj31AsK01Ocukse1levPnLTDwKXBSzyvuC
yo8zm02RMyW4zg0oduOVC3lzKuDXet40YiOzOQ+JSNrrtMr1f5MjJmDBt6kA/qWI
f6Irs5U4r0Itx2m6dND5YdrG61VAvhtDgBh5gcaXkwGtU0IDx16vIxt1X0yffLN/
uuGpUmunfTa/YSfcPDUZPovmm+a5LjIcoayi6iGPpdF9Hdl02KFixou4xAtQKxDj
fHrNT/KWXdPrQN7i7w8fB4sEFFt2niZ/lE4tU4l/kBdXpBVXy6+1xEcbbytvO1iE
iZpHwCh76rqtaLYY78utapdaZvOX6wqdQkUdOUikvovqIT3iCx6SvYNMsiQfhMyo
ZME9mSejXJ3qpNOHW7JeTpkK3h+nHBwO5zo9GBrrFiLz3+DX+gQqSmZ2MDt9Yj1A
fpySUxKLpiJy++2ClhmeEgoArhDKjtC5ZkAuI3GRBAbYJpW/bDvmEG8skmZvm/Qi
BsO4VUG+GXJo7bJXUu46ruyFFsrTv5KL9JFtkFQcy+CbIV7ri409aO/2JFbMMYrz
MeQFHoprtA0cOQTjBQxD
=3dw7
-----END PGP SIGNATURE-----

--9o6tjhKcA+PBUYK5--

--===============7809066841750541461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7809066841750541461==--
