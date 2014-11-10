From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/8] ASoC: Replace remaining users of the
	CODEC mutex
Date: Mon, 10 Nov 2014 19:08:45 +0000
Message-ID: <20141110190845.GI3815@sirena.org.uk>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9007139818847733475=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AFFF2667E4
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 20:10:04 +0100 (CET)
In-Reply-To: <1415548864-27203-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============9007139818847733475==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0nQ2sto/tqFewMv"
Content-Disposition: inline


--V0nQ2sto/tqFewMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 09, 2014 at 05:00:56PM +0100, Lars-Peter Clausen wrote:
> We've stopped using the snd_soc_codec mutex in the ASoC core itself a while
> ago. There is still a handful of drivers which use the mutex to protect some
> of their data structures. This patch moves the lock for the remaining users
> to the drivers private data struct and then removes it from the
> snd_soc_codec struct.

Applied all, thanks.

--V0nQ2sto/tqFewMv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYQ08AAoJECTWi3JdVIfQHgQH/ihU0BBGJj5mj6XsMtXfT4he
WCX+sUzAPL7AK68kmkCYSQlN5XqKFKS8eh9o6iuo/5uwLl0aGBxEwyDQ2ChCCmNi
nLB0Q1WJtryhfQaUjexDbWKddglX0ZM8aUF0I3vYW6jRvtv/UsMBw7wgJMat4z83
GYjdtGxUmFt8YWjm3ybVLkw9Tx/aS8FUlvsZm+0ZG7FbMTtE7fEvHuFEOWsMLOoA
GMIye4S1FiBV7VxJgto4xtQJ7VKvjVjBPrc6tbzhbLGmR9Vyych7Wi078Fz0Fm6p
npYH4NEZK8q4gIzencepHYQyDOVNAo9NSFwJ4Haj3zvEzAJguz65xPMBnQcZS/g=
=FeV5
-----END PGP SIGNATURE-----

--V0nQ2sto/tqFewMv--

--===============9007139818847733475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9007139818847733475==--
