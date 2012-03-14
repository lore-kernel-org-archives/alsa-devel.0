From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6] sound/soc/codecs: add LAPIS
 Semiconductor ML26124
Date: Wed, 14 Mar 2012 17:45:18 +0000
Message-ID: <20120314174518.GV3133@opensource.wolfsonmicro.com>
References: <CANKRQngOkGTPM9AWEaHoaNQCyN65B_ESB24ctcT_DiEen050fg@mail.gmail.com>
	<20120302125819.GE3230@opensource.wolfsonmicro.com>
	<CANKRQngoDf_U8U7txG0AT1TKmSeq2FfqwjWD7EEiLROWzn+f5Q@mail.gmail.com>
	<20120306100012.GC19635@opensource.wolfsonmicro.com>
	<CANKRQniUnEPawXZHcPH9kG0hDiaZ-eJ_vOQrCefB0ntCu98D6g@mail.gmail.com>
	<20120306121222.GK19635@opensource.wolfsonmicro.com>
	<CANKRQnjFB8G5iRKZLQok+qnQrPXf7vcRGto_OyL+1=VNBTnetw@mail.gmail.com>
	<20120307114811.GF3107@opensource.wolfsonmicro.com>
	<CANKRQnh2JqhZBYLP=U_isgthh2pFT89_qBeypda1ciUJzoRXYw@mail.gmail.com>
	<4F60D804.30804@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3995932044988644923=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5AAF10425B
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 18:45:20 +0100 (CET)
In-Reply-To: <4F60D804.30804@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, yong.y.wang@intel.com, linux-kernel@vger.kernel.org, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3995932044988644923==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZUxj+kVYsk1YKJSS"
Content-Disposition: inline


--ZUxj+kVYsk1YKJSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 14, 2012 at 06:40:20PM +0100, Lars-Peter Clausen wrote:

> If this is for all registers, how does stuff like DAPM work, which uses the
> framework internal update_bits function?

I was assuming that this was just for specific registers which were
weird (frankly I've no idea what the chip designers were thinking if
this is actually needed).

Though based on some of the issues I found on previous versions there's
every chance that there's not been any testing...  if that's the case
it's possible this is a misunderstanding of the I2C read/write handling
with the chip address?

--ZUxj+kVYsk1YKJSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYNknAAoJEBus8iNuMP3d2vgP/jhn2e0LB6ofGvFXjy1KxyK1
jgMski1XZi2xR2PtXu654e10fR7u4Tl5InaMXTSjKHOv0ubWVqFGJP20zBd8K0XD
SL5VkaPE1CZrmLDoNdy9AMzxmW8jxN1ZuMPW9jLm39er2ntcvS5yA/IWpMRKesHu
dNhiDT+XlqJ4+GxNO7SjleEfct36WEDsJv21w0XWFHMvjbmZ5cCxNcAYLEbJkWsq
h99dPtl23272F5E9crshR9DqfOBXxzYvI2o+suFJXVLk3Wz5azYqfMlGbpElc/N5
iri7InICjfJGgC54g8xKQMU5jA4BbvdGFmlcNDn8swelaVKMoL18YL4OoIzJhBGb
W1+f5AkJDdFQGN0dFdIaNzJNO+PdbOxIvbKqZM3c5AUxF0lh9liblKHKSMoFuzt4
soIdYMNvbQXMYcQlbJHJ4+c0ARPhlRg5iK1S48LVCd9qnH8Mz+JJZPV7iB96b/oA
Y4jgQiZOqfLlZh1X6wolCJl3LgtGTq7Ivr1xwDe7BsPoKNysjiS0eIqIubzeCqzM
giVeRsooToEzubXxbRDdFe/6ofqaoFN1rzKG6Ei+VZCGPOn0z2kV738V4j4TFcqS
rVKWo/V6HejqbM759aNnYLenigF3817kEMz5XzncyZ+xKAKRPHtVZ7o5C5NGBxGN
FDYkO45EhRU8PiuPfcLX
=0iQb
-----END PGP SIGNATURE-----

--ZUxj+kVYsk1YKJSS--

--===============3995932044988644923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3995932044988644923==--
