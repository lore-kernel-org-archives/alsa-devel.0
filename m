From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: arizona: Add GPIO output for DRC
Date: Tue, 2 Jul 2013 16:36:42 +0100
Message-ID: <20130702153642.GQ27646@sirena.org.uk>
References: <1372776817-29811-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1372776817-29811-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3278963718871068357=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DA95826549A
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 17:36:48 +0200 (CEST)
In-Reply-To: <1372776817-29811-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3278963718871068357==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r37Bb06VX9AMv3jz"
Content-Disposition: inline


--r37Bb06VX9AMv3jz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 03:53:37PM +0100, Charles Keepax wrote:

> In some use cases, such as signal activity detection, the only output
> from the DRC will be a GPIO pin. This patch adds GPIO outputs to the
> CODEC driver and hooks these up to the DRC when a GPIO is configured to
> output the DRC activity detection.

> +static const char * const arizona_gpio_name[] = {
> +	"GPIO1",
> +	"GPIO2",
> +	"GPIO3",
> +	"GPIO4",
> +	"GPIO5",
> +};

This seems like the wrong way to be doing things - having the GPIOs in
the routing table is needlessly complicated as the don't go anywhere
routing wise and they're not exactly helping anything usability wise as
the function of the output is translated into a magic number making it
harder for people to write code interacting with this (eg, turning it on
and off depending on use case), you need to know which GPIO is in use so
it's harder to write generic code.

Just have a functional thing in there, enabling or disabling it by
default depending on the GPIO settings seems reasonable.

> +		switch (arizona->pdata.gpio_defaults[i] & ARIZONA_GPN_FN_MASK) {
> +		case 0x1d: /* DRC1 Signal Detect */
> +			routes[0].source = "DRC1L";
> +			routes[1].source = "DRC1R";
> +			add = true;
> +			break;
> +		case 0x22: /* DRC2 Signal Detect */

You're going to be using these in multiple places, #defines..

--r37Bb06VX9AMv3jz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0vOHAAoJELSic+t+oim94HEP/1zR9AwQa+fGb462QiDrA6UM
Sj4uaplIOI5ytaBPnFfQbb6W3SZWNi7miD1e00TYtw0akabxVQYiDrQjeFCFOAuV
QxoBJZpFVUJGtSUYeKCElXrzkj2Q93inpL/YABubgokiCNo392/BI3BlFnDFnasX
rzYj3u+NsYIcwliD9xMRS54JqpDx5bG6iIMYE9FUmZQQXJh+Uiqg9mIktLD4JJMx
l3PJPwoy+wQmuGm6oUWjIV7L1PAzpuCsiHxgDUsH4UeHKOH9iSPsWEtaow2q8eG1
ouBAgSPE4ZEEM+qvGWvEzymjvJgvwrzkTwjDai0z4AUhz0om9Pyrt31v7hnAVKj8
UIOe1STZZ7HyQpXDFVPBn6KuYF7Uv6G5cTMh3S2nAkOVxSwHZFVAyUgP18BY0Pom
cpF2VV3g/6SQP04lGqh92hIPtEjEab/JNUQlAJPQUTLzsR9uJCI0fkUPMBF345q3
63UNd8uqUv8NewUK7vk4n+GGPNqMwAeuNflc1guCrN9/0Szj20lPgFYp7QVGrSwA
vvbor8d2RQ7DudN2FHqFAmt7OWDM7rnK+RRov7MjDBwHQkd1nAeO7a8Db9uyv4MB
6Zi7drPorYTDp6vDL0fAtIufan4lHd6QQQHYcPgqlRHaqtem+VVj12CY13mtbSES
vyxWpt+ot9EBXYugl8Ap
=OWF+
-----END PGP SIGNATURE-----

--r37Bb06VX9AMv3jz--

--===============3278963718871068357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3278963718871068357==--
