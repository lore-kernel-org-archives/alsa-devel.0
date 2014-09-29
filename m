From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: wm8{350, 753,
 971}: Use snd_soc_dapm_to_codec() instead of dapm->codec
Date: Mon, 29 Sep 2014 18:31:52 +0100
Message-ID: <20140929173152.GZ16977@sirena.org.uk>
References: <1411983642-12793-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5446290747438447981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85C66260645
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 19:32:08 +0200 (CEST)
In-Reply-To: <1411983642-12793-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============5446290747438447981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PjJwPjbdn5RfZuWK"
Content-Disposition: inline


--PjJwPjbdn5RfZuWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 29, 2014 at 11:40:40AM +0200, Lars-Peter Clausen wrote:
> The CODEC struct in the snd_soc_dapm_context struct is deprecated and
> scheduled for removal. Use the snd_soc_dapm_to_codec() function instead.

Applied all, thanks.

--PjJwPjbdn5RfZuWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKZeHAAoJECTWi3JdVIfQEFUH/2RG78eGy/PHNBYjDE/fFXcT
iWlsuitPFnedqaKzySnsvBXiCs5H4izZWecaho8zj8rYclLEcu/A72alv4ZKLkTo
6fCeXFPBkfeBaRl/n5rCr4xxEw07hpWYimC7LhWKEo/uc1MfSIle6krYtJSCEru7
MAVn+oW9iLtoi+w0gNog7y91p+EeqOFvMcrq48W5YzHSNa4XJClebiMIZrw3NrzA
ItfBEgKRh1G10aXSXd1C84+SVGI6aWztpEWhxdVrJohkQq2ahENoA86zKry6LlXO
ghwJQjg+CM2aCXQ3IiUmbwi5/RDtByunLC9sz9X9pGp9naWZ6Z7gYB78CV0tcx0=
=oYFG
-----END PGP SIGNATURE-----

--PjJwPjbdn5RfZuWK--

--===============5446290747438447981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5446290747438447981==--
