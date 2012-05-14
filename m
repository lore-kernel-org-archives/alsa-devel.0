From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Multicasting transfer mode
Date: Mon, 14 May 2012 09:54:06 +0100
Message-ID: <20120514085405.GI31985@opensource.wolfsonmicro.com>
References: <4FB0ADA3.3020304@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3129386766056661531=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72D312495A
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 10:54:08 +0200 (CEST)
In-Reply-To: <4FB0ADA3.3020304@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3129386766056661531==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2012 at 12:00:51AM -0700, Patrick Lai wrote:

> The hardware I am working on has CODEC transfer microphone signal to
> two SOCs simultaneously . In the machine driver, I have two dai-links

This isn't something the framework supports.  You'd need to either
implement the support or wait for someone else to do so.

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsMgJAAoJEBus8iNuMP3dvZ8P/2THkdgTR0QKKt18wqejXiOM
IfGEjQkKUlB72BjWWR4JMK4/xZJ2YZ2LOPwmaM4W15ENQXpMCnJ0sPWz00kgzd8b
DnVfFaXtZYgGEHlVp+wRZrq2298+YzV0wWpOZPanOUSNCb/4A54qo58pqy2DdWMm
5wOFZejeefjNa5wglN6fN2NX5MDkKuXyuooZARmklvyghV5Ur9nl7ecV9AMq9YMR
7JqNfuddXrzLfr63wxcUBfYwh8kkwG5aojs46o089aJMlpbCD0UQhs/I/wC4LEFn
3doeOeTr0ffNiftXaGpb+Mu2yuR8ptwFC9L+2i79UblqA0TIoLrqBY8SaBSFwVDv
jlzlXNm9jeC+UE72Yu59LF9ob7PuaKj7c5QRBflkyJjgdxEQsiaNBbWCCX3MCwW6
UOPW1c+XAvCQi2A5wugpM/7xKA/VEkPOxlxSnx3GmKu3lYOJkRTMc8ctG1s4S2zh
hpCEEUrt85tKi2GYMEr/AeZfJkYnQA5WyJjHnXG5kymGxfmGF5MA2LWylnV4Iq45
TTFmOzEL7PUjYnieGI28ErmiNXE7kuDrB3I8KuJccjkWvXuJ/i60caB/E+YXVxCT
DwnOuBr1UEFY3KJEl6EQx7WWmStj72PZL07MDz3nuqfPBzJkZKxBq5Q0vWomJDvv
Gjvs2GVU4fkJaptdiizc
=Uo6Z
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--

--===============3129386766056661531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3129386766056661531==--
