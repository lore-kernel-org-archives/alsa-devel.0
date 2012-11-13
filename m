From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4271: free allocated GPIO
Date: Tue, 13 Nov 2012 15:47:18 +0900
Message-ID: <20121113064714.GG18224@opensource.wolfsonmicro.com>
References: <1352573570-23671-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4014039240282094594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 832562650C2
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 07:47:25 +0100 (CET)
In-Reply-To: <1352573570-23671-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Alexander Sverdlin <subaparts@yandex.ru>
List-Id: alsa-devel@alsa-project.org


--===============4014039240282094594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 10, 2012 at 07:52:50PM +0100, Daniel Mack wrote:
> In case of probe deferral, the allocated GPIO line is not freed, which
> prevents it from being claimed and properly asserted in later attempts.

Applied, thanks.

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQoezOAAoJELSic+t+oim9OJoP/RhLjkLSGVg7LvMOlubU1CIT
CCt6Pvxkuzu67FlN3d6YZr0Qe7L1/xJqEqnoab9tvUi8x1dqLn2LRng0uUCWrYLS
Sm3ax0hJ2IdqUN2a3agALzWLHJyBczWVWAzVfhAYQUHcdA/+UV/BUO5GmcLxhSpn
N5OtK2xsl88ST1AHj2VArlrY33CkwQNTp2lJGxSmKP95ob8sSCj6sJ5aeooZvqcn
0TXnUhMc4k/x96W9xflAvKQ0Ek+bdy4ciq7f0ONm95nDEoD3Fx4mvcRA7c7V+bX2
gY4G3IB09NjiAXId53Axw9Fw95L7TXepploUK5k8oM3bocvYYeYL42kk8DImAHUx
WZr9uSelMQMVn4AGbUdyV4ZEx0ri5030PNyCGpJqHT4q3o/xklInvSej2/z0xlhk
NNuWbrxGLBgRUF0DH1oYuXCjQG+c/bToLEdWbQqFqRn6uROsmLpicJTDAKp1Wndi
5bkQlF/hUxAeMbY1AR8ToLonaEK0ular7JjddPByNh0D+VTeGqK5d4y3LCFiFQ14
YU6cExHI21GkIjxK0LaZrN8n2s0w7JJI1iDNszFwd1ah75xp6uUKDt9xmvW+1gK8
eq1rrL94/IvjzTVOFZu4uNakP6N0b8ec8JJFGwocRg/yM3gQtOJqfgSqKw9gqoTr
QTHPUb1sfLkftt9wh7vj
=10qi
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--

--===============4014039240282094594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4014039240282094594==--
