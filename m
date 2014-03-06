From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: Fix build error without
	CONFIG_SPI_MASTER
Date: Thu, 6 Mar 2014 12:31:58 +0800
Message-ID: <20140306043158.GB13126@sirena.org.uk>
References: <1394038411-11045-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9139092653816555351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BDC8265232
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 05:32:04 +0100 (CET)
In-Reply-To: <1394038411-11045-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============9139092653816555351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BASZjVINLS+tv9G4"
Content-Disposition: inline


--BASZjVINLS+tv9G4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2014 at 05:53:31PM +0100, Takashi Iwai wrote:
> cs4271_common_probe() is called from cs4271_i2c_probe() but defined in
> CONFIG_SPI_MASTER block, thus it results in a build error when
> CONFIG_SPI_MASTER=3Dn:
>   sound/soc/codecs/cs4271.c:721:2: error: implicit declaration of functio=
n =E2=80=98cs4271_common_probe=E2=80=99 [-Werror=3Dimplicit-function-declar=
ation]

Applied, thanks.

--BASZjVINLS+tv9G4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTF/o7AAoJELSic+t+oim9PIIP/RTGQc48w+/Ty8ZAyGM4zS/h
qL0Nhc9RjanHVF3w1DpclBrgzN8SYx2yPFlw8uyGPr+Ejzvz+QRrqtFoh34eWchW
XBYbLAloQWRMHdtBkYU+YEv/08ZYH3iQ2a5QrO6ZnzAC5De+J8NbMaj3lSOlQ/Ah
HwsWhR1fJpmZQCOtAjqZNd7HRjd0pA0fggen55jYPFlL9xtwpxBGivGyPotezexi
mqZK3btukSKkaJxJbVL1kHCskFic26k21QwgyuPte4RfZyJ8g5oZ3pk/Y9sHPqzY
5OeTTcUR0uZlyx8WBMQACZrGnJWMIPoYibV/kgPdq+l/Whr7Ja9Xu19nAgD2oZD/
WQfRHz9hhuz0JU5E5aWSnSsZ7o/WAZjecombRKRYOG1GdsKi8xyrpk4B+wNZxUWQ
YC5ZqM6A8ramlODBxcI/s923hh5Oq/JXma77iHQNQyMCbzi/VsSXQHZVgK658Vxa
TZuBCd8mD7o9CWzzr1B1TiAm/ZJx/kSkCgKCCUgJO9cfO9w3ah/3RAI+blT/O71g
j5vowdUABV4eS1R1PuF8ya4EXN5dxWPN9M2WBPRYTR8ZeP7H1fDWRlDXZ03Id2AC
tuQaR88EzaB+UnYWcpNM/5u502IHn4hUAgFY8caNEGNZJSMQBSxF2rCjYvkgnhDe
ZsRxHQM+3fIKme+iZGBr
=QoS2
-----END PGP SIGNATURE-----

--BASZjVINLS+tv9G4--

--===============9139092653816555351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9139092653816555351==--
