From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/21] ASoC: io: Prevent use of regmap if
	request fails
Date: Thu, 26 Jul 2012 16:25:34 +0100
Message-ID: <20120726152533.GS3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
 <20120726114215.GB3099@opensource.wolfsonmicro.com>
 <50115961.6060509@linaro.org>
 <20120726151217.GO3099@opensource.wolfsonmicro.com>
 <501160F5.5050807@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1608472379353226274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFBFF265EF9
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 17:25:32 +0200 (CEST)
In-Reply-To: <501160F5.5050807@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============1608472379353226274==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rnz0oC2K6vQ5doJs"
Content-Disposition: inline


--Rnz0oC2K6vQ5doJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 04:23:33PM +0100, Lee Jones wrote:

> What's my 'control data'? It's not used in the original codec patch.

> The old way wants to go:

> snd_soc_update_bits() -> snd_soc_read() -> ab8500_codec_read_reg()

> When then calls back into the abx500.

> So what 'control data' should I be storing in the codec struct?

You're supposed to use it for the data you use to call back into the
underlying I/O code.

--Rnz0oC2K6vQ5doJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEWFmAAoJEBus8iNuMP3d8QEP/2oL+z1MeWLQSD8YFGzK2Ob7
gWdPOUOmFYfvGHUNK+1cshwG2yqa34MrQy84L6Pcq+NNTmoWz6w+YAfJVjmc6dHH
+dDmUVGl5oKzov7bJPdqNh06F0ChQkiLFFP/Rims/UpX3+3KJKM46jZh1P7DEk7C
TnYZKOgMglFLhYXc71MZVXw18XZ4lCE4bjwS7NntYnTahIJRTW3mz4SLCPL0LLuj
TyPo3BnbdGEtyuEuYgfAnu1hEZbZu125h9SJZ0jGZlWaNpnUYBUWYvYwl3XlK7dZ
CO1alKEuiTNtaE4Khzkq97jn40pncVjzU+bk9l9Tokko1nzJHLXKrhf3bXyS82CU
3U/5JLCrCA8l87YwVml7rTyiklZUALgV3uTn3dEy8iT1zk4tOJUcC7UvSYQil4ca
4zbuSn28zrmHBBTnmuGjVYHjDuKF0orDzB4E/kpsJ45qr5SWqsOgI4mn0TkXPaRO
nvMg0yTxKy/ElZ/J+qqLSLW/+if5xnqVYycx2muCtZz/PR9mCCV7qb+JXnXQhYb+
57uF+ozUM6y83sSem/KBqS46diXQAXmXbNMSB0dYqJzTuSpP4p7AylUNRGVkTaRb
9D7S0rGTo8+U4wtI4gdJxMmDf5ZngVPN3gA4w5E0PY5weyvk3YitD2va/pykieli
9DC97Z96jBV1vOyR0mVW
=4sRm
-----END PGP SIGNATURE-----

--Rnz0oC2K6vQ5doJs--

--===============1608472379353226274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1608472379353226274==--
