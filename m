From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: wm8997: Initial CODEC driver
Date: Wed, 12 Jun 2013 18:10:25 +0100
Message-ID: <20130612171025.GQ1403@sirena.org.uk>
References: <1371054560-28770-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1371054560-28770-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8819494401344958855=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C6444265095
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 19:10:28 +0200 (CEST)
In-Reply-To: <1371054560-28770-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8819494401344958855==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="suroagWEfFHnktSq"
Content-Disposition: inline


--suroagWEfFHnktSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2013 at 05:29:19PM +0100, Charles Keepax wrote:

> +static const struct reg_default wm8997_sysclk_reva_patch[] = {
> +	{0x301D, 0x7B15},
> +	{0x301B, 0x0050},

Should have spaces around the { }.

> +static struct snd_soc_dai_driver wm8997_dai[] = {
> +	{
> +		.name = "wm8997-aif1",
> +		.id = 1,

I'd expect to see the Slimbus interfaces here too.

--suroagWEfFHnktSq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuKt+AAoJELSic+t+oim9k+wP/0VjoTqL1aNqjEWpHlbmhzo0
K6xu/ZT5Ks7SS0yde5OQQ+jZUwn6gChA7K7r1A9yOvZAVLqfhgRlj4asecLAllw1
8TcQZZ6oxUQZHZg8vdNS5D59gE1XpDnm0ASlATyYOCxSXQ0ra5XSzCdLlo7+gbjS
2HH0ZNvg+i/ZPY0DwLKRvDqNf40FD9JtcwOFx9InTbs8U24tpsvUqX7pYjlqPE0J
mn868+jj6HJ/tpVpFCVob/9g/NzuXRBB8rlC80vEhImQirzwANLJCBP0UzJiSzv/
Y3DzVD45lkMIoC5K+iNYD1GYsZ9Y+fU1O7xJ7+iKZLD8gm7Qkum46poqrwdMzLvQ
Jn5BvmmSMxNwVaZwUj4L4XvR4MU5Hbx8qnbdtS3VVtH5QRIUoNFS3SLjWTcxVY9y
xmTtCXRpwPPaQOkxI3M8fLKyvPOd2BzjjQC+v8xwSqEN2FWZbkwEKal6PwnfXaOo
b7eSLJ844mp9H6lG0GiZo4gzvS1/iyyFpmN7Cx2aH1n3M+LdIXffVEFhTQIA8C/S
oH08vVYXNtIhwwya9/iY6i5cxtUrLgvJ3LghbWrqc/REmGINp4nIBG/bFIx3jcjw
LkyEOhzVONZtYNa4qlCQWYF4rUYE5Q4weXEt9ttGz8IT3RiHdrZE6YjeyJNVkyKB
hhPxkbx2o0lHeUwTt3cd
=bjsp
-----END PGP SIGNATURE-----

--suroagWEfFHnktSq--

--===============8819494401344958855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8819494401344958855==--
