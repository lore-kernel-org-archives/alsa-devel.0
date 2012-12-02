From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/14] ASoC: wm8960: Use
	devm_regmap_init_i2c()
Date: Sun, 2 Dec 2012 13:10:07 +0900
Message-ID: <20121202041006.GR17981@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-11-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2762679884180148397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D16F22650DF
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:10:11 +0100 (CET)
In-Reply-To: <1353930587-12907-11-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2762679884180148397==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tcb1KvpfnM4LxW2s"
Content-Disposition: inline


--Tcb1KvpfnM4LxW2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:43PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler. There was no explicit
> regmap_exit call in this function which was probably a bug.

Applied, thanks.

--Tcb1KvpfnM4LxW2s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutSVAAoJELSic+t+oim9FbEP/3gRN6SqarS6QkiB6oT0J0h0
QJz1vja72pXrWV9T0DsQrNFAlUoOgXWSRTn3tQCooHvbbZzgilpBd26mJTsit0XM
AmmDSQQWg1RYWwt6rotBpWT93Ht54C9y6gwg12DkzWXfj6kESo9+vbUhcW8h1tw+
NNrIjNzNVm1ZWkduDXyWowusxuWRvSInYrxKK/jIe9ibYOqrvf7TerbVu492QSEn
we3YmTVl2qsW5bZdIvkIzsVLMqmeWCPJbqBynCRPTwxDCMeXtEM97IDcpS5Zq3vF
FHSWwc8LXO/rCQK+osLy3+2xm0V/4FO8/rfr/C4R5/fYZF484J05gJlOpUhH5LGW
sEySWCh/uhetJzi9igEyD1BMeQTmTcgb6MYts3MowhZi0/tvwYAv3gYXh2jcmrkW
4LV1Mhjh0qpKbQRU/S4LfrTDbBh0/FV+Hg8JDEa2o1JOFF7ryOWFKUFuM4zKMjRw
QOnOO0qtspg7iC4vFx90EMfDwPB5EiPzE/w0HmNpyxgqKQCxUAf+vk2hlAFkD0T/
DSAha4SjklN2ahPr/zqW3nECwJFWzjx+jIl81vD43hUNaTMga6qaccb86uGDg51k
xVDHnwNEmcEb/GHLabgPP9LW0c+hXvQwv7m4mcDBx4wnHR19eqdj9isx0E6Q7J0Y
UwxvK3LV+CQOCQS3VGir
=2Vp/
-----END PGP SIGNATURE-----

--Tcb1KvpfnM4LxW2s--

--===============2762679884180148397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2762679884180148397==--
