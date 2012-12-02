From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 12/14] ASoC: wm8978: Use
	devm_regmap_init_i2c()
Date: Sun, 2 Dec 2012 13:07:44 +0900
Message-ID: <20121202040743.GP17981@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-13-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9078004628758931878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4ED972650EF
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:07:49 +0100 (CET)
In-Reply-To: <1353930587-12907-13-git-send-email-sachin.kamat@linaro.org>
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


--===============9078004628758931878==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G50dybFf3pRZKd7"
Content-Disposition: inline


--5G50dybFf3pRZKd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:45PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--5G50dybFf3pRZKd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutQJAAoJELSic+t+oim9hsUP/2dwasIhvBXaMBBTqhkVuFM2
s8OgYrzDuluH5qtIviPYF40kOijWO8E78LvheaItuyYBEBYIF7G4BvP/LwTf6xsL
1wk5Wau636kd0x5M7FXw6ztGeHi5RdwSB3Q99a/E1R34RHB7kQ+uKppDLCqg6zpC
gNBnZFB9gvfutvUCLMQxnFs3hQPMIzgp/1jh/YDSbQ7WBMhp/Bbi2EY989HvrdTt
w1y9HXSdgs3XANMhgRd52K1bDdWRrCEVhMkGhTHldflKiirezQkLMLMtIAzxQj+P
dB4fOtnvnAZ1Z7p+DzVtQjqXmAmFps9A7HjEmFh3KJMib9gC9RQOEIip7w27cn13
XHcAWzT0DAvOntz0sv4zRrTajvQTdy5s0fapQ1OzrA/sDd+bVVcRZ5xkppN6P4QX
4YJLMEDEB209kHZJ7u1j18HmeHp62TTZukBgjKUb4AuhgqS84OoOoDf5Ft85r+2S
mRhrST9RZJIZ4bSzOZANE55zDc15p7hGw7iDmU7Yh8Fw47DU5WY8nyFmJ1VWe6Cl
Lvt+QHUw14flPEf1yRByLHfVXOWOS2q0K1tABGy6hlXlDKQzHq4YWsgXK5XQwM6x
fdOJF2TYpOqFbderYi14nMzrSCkv22tdu84ODpXKCvvSc9gC+CmAqiWziRkcJ/Su
PfueD274p9DmM8vNEdTS
=qdKV
-----END PGP SIGNATURE-----

--5G50dybFf3pRZKd7--

--===============9078004628758931878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9078004628758931878==--
