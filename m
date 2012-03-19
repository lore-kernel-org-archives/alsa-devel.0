From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 1/8] ASoC: fsl: separate SSI and DMA
	Kconfig options
Date: Mon, 19 Mar 2012 13:56:54 +0000
Message-ID: <20120319135654.GD3130@opensource.wolfsonmicro.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1636884782898410178=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F5E310410E
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 14:57:04 +0100 (CET)
In-Reply-To: <1331888204-27058-2-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============1636884782898410178==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 04:56:37PM +0800, Shawn Guo wrote:
> The fsl_ssi driver will possibly be shared between Freescale PowerPC
> and ARM/IMX families, so give it a separate Kconfig option.  Then
> fsl_ssi driver can possibly be selected independently from selecting
> PowerPC DMA based PCM driver.

Applied all, thanks for doing all this work!  They'll have to wait for
3.5 at this point sadly.

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZzsZAAoJEBus8iNuMP3dZxcQAIP2F7rYEj1WJtBo0HtW7yF1
ERZ/KK3lJ6sTSvSWALZzCLinfbxRJ5Z84hA/BVsAAbETXKIhdmUwTdu4TI1hoihK
V2CVMhWJtVlDTP9+omYMcyViE4RXvu2keyhsqFpXkWaMlTwUZ91bieERDrhEkou4
HcRvbHSix07WVMoZ+EtgmKg4F1mgwpH8yH5AcuqF0pQodK7pMwlryoQTftHZ2iFJ
tsz20Dceqq4FYv9i1KDYOoSojoNsLSNVShskTfreOFx9BVtT+nQpEkdsJOYoeTiH
E5M916dIYPxZRdnT5ow7+cfaEt8pqtp4CcuxgrtX9W5MRsg1GwAym5oPy8ynbVOL
jwgWDmp3WcQyo4s5zrb6jeMKFrMICkJLcSFi+cf3VWnX2uZ1IvXakjSM1WgaAIge
4sE0xH7XKGqDS+lgH0uORwfJmBYRssQqfjc787EUeSkZvlxmTU/U6gwoXYAEBzkW
mDojbvwOGud1CUqb6cRUP9OqKsf+Mh/ra5OYe6nrgHYegLxnRzv0NoLudIVd3JaM
VALLclxRpE2tMImESqoP15tVy0d5hEHx7h458OM5sVd46AXQqn2RJ6qUPO61k9BF
cKLXcN1c7iDTiDo4sYF4cgJeuh6AQzBRuwtHIP9ZHeK/fIByHYaEBe2Gw5+TOjFM
wB8nFHdJ6+hgWIVRnT7E
=X7pk
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--

--===============1636884782898410178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1636884782898410178==--
