From: Eric Anholt <eric@anholt.net>
Subject: Re: [RFC PATCH] sound: bcm2835-analog-audio: Add
	driver for bcm2835(Raspberry PI) headphone jack.
Date: Wed, 08 Mar 2017 14:27:02 -0800
Message-ID: <87pohrjtft.fsf@eliezer.anholt.net>
References: <20170307092109.3083-1-mzoran@crowfest.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6405787081929892897=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF17266B5E
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 23:33:05 +0100 (CET)
In-Reply-To: <20170307092109.3083-1-mzoran@crowfest.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: stefan.wahren@i2se.com, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org
Cc: boris.brezillon@free-electrons.com, Michael Zoran <mzoran@crowfest.net>
List-Id: alsa-devel@alsa-project.org

--===============6405787081929892897==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Michael Zoran <mzoran@crowfest.net> writes:

> Someone on the internet mentioned that if we have a HDMI Audio driver, wh=
y not
> have a driver for the headphone/analog jack on the Raspberry PI that does=
n't
> use the firmware.  So I quickly make up a prototype that isn't submit qua=
lity=20
> yet, but is very functional.  The idea is to like the firmware, just use =
the
> PWM of the bcm2835 to generate the audio.
>
> Questions:
>
> 1. Is this something that people would want in the upstream kernel and
> would be seriously considered for submission?

I'm certainly interested -- the more we can take over from the closed
source stack, the better Linux on the Raspberry Pi will be.

Make sure you use standard DT properties for describing the DMA channel,
add your new compatible string to pwm-bcm2835.txt, and document that
that compat string requires the DMA properties.

> 2. Is it a complete deal breaker that the driver is a regular ALSA driver=
=20
> instead of a ASoC driver?

I don't think so.  I think the goal of ASoC is to provide utilities that
make your SoC ALSA drivers smaller.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljAhTYACgkQtdYpNtH8
nuiADA/+I+Ej4nOL+lvT2CWSC2k+s7ZVhR3u+9PW4ADG+8XrY+Z0Rddi641UlA4p
KvurzZbwYiU4uh3Sq/ljjXcmFhsbyyuQLjYMQgpPdhQxHUCc7nr3Axj3T52DcCXZ
H0Vh7m4CYjy7q94WXwnIsHE0U66TqzB9TJ37fXd81oRJdSPfCkIwtrHjwzSiUKNy
pPgn4EK7MajAYf8gabQCupiejH7xwGwxVAkVnxb5ldg3h78PhaUW4TqGQJdaQO1w
pbtgIos4/HsupfUra9EAPIq6Jnr7B5iaMM92Dgwgj/AKkiZsNXVsOVrngBcDcpEc
xG0D1LR1zHTfpriCCpYvVIwu+WQdYMZSIWfI4J1+S3WxTnYaA9sdEvi+HbbrhLhw
K14VepQaEhONKZULdcI7q7jr1BteI3Xc9T+uotd/mSKRnyqyyX0PAVNL2aipgFjH
cvu3iDJsKqge3+7YOv0ZSx3MCiUML4sGiES/TDFpp2/57tj4ERUbIFKWnldRbkvh
G9ihpc6h0Sczw5rV3bHmtQ/Qft/ZowU73EPUD4l6JFWNUFxX5orAruliXy2KYLH+
rX+1zgEWu1/MTIUj9jQXnYF9BDrWO8nMQdzHpi/GkIrNu6S01h1q1QmqMJhibMTQ
3QLaj9exc+YQLGDrwh4anfP1uI2tiXkhzlDLjM9Wo332AxPpsdI=
=Lkiy
-----END PGP SIGNATURE-----
--=-=-=--

--===============6405787081929892897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6405787081929892897==--
