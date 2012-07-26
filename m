From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/21] ASoC: io: Prevent use of regmap if
	request fails
Date: Thu, 26 Jul 2012 21:23:11 +0100
Message-ID: <20120726202311.GC4560@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
 <20120726114215.GB3099@opensource.wolfsonmicro.com>
 <50115961.6060509@linaro.org>
 <20120726151217.GO3099@opensource.wolfsonmicro.com>
 <501160F5.5050807@linaro.org>
 <20120726152533.GS3099@opensource.wolfsonmicro.com>
 <50116ADF.4050700@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1512748410078864875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BE31265F25
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 22:24:29 +0200 (CEST)
In-Reply-To: <50116ADF.4050700@linaro.org>
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


--===============1512748410078864875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 05:05:51PM +0100, Lee Jones wrote:
> On 26/07/12 16:25, Mark Brown wrote:

> >You're supposed to use it for the data you use to call back into the
> >underlying I/O code.

> I don't understand. What 'data'?

Whatever your I/O layer so desires, the core doesn't care.  It's
generally whatever the lower layer that does your I/O takes to identify
the device.

> Surely if .read and .write are populated in 'struct
> snd_soc_codec_driver', then it should just call back into those?

Yes, and in fact that's what we do!

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQEacfAAoJEBus8iNuMP3dEasP/3A3n/FxKTf/QXUrkiPW7T6n
Pgafq7YAXayZ0Xps44bkxTFQ8qfy53a2RiumkngR0FxZO8f1EzY0PdhNaCgMbAmk
EfCzak6zgJLaij+dNehjtyQk4G5JDpYnoTzScYRbs6a+3nsFQj72LSrK5r6MbVPv
jYuCnPZZbjWw4V/BEGDzWRkwO+YK3ofPL+JlSOyu/kpfb/IUpuQWpE7vwR5pSOjr
mjVGmJ/3pL/rgVY4YU+o/D8uUP5Ty/YJ1Qo1rCntWFq3N3wWG66HIT6Izlxy9CPs
hGaDXbKsiwwpmZaSPGzVMrmsnEryefErN3tuaZdGZlk3qyRY4ajcZ5LGr70+L/lE
xIIm04lYv9Xfi8gC/MNhntDU2my08avOeZEtoPraVjwtW6tVxXD4jpIPkmLkjU+4
EF5i8T5KvJpWtYXehJWLZ5VUT4dk+dEkVTB9JaytSnX64Yv5NC5hf2pvBZOTN1s+
f1HduEu/rNwCFbwhnDK89eePqcrXH9G1QPNwn3WES5Z8PsW7FQ587IgVGP5kZ7WD
c371hLhrWto4EPJmNa2K9IqUr3vAKhCu4/13QXaYDze22d6pbPLCFAZEk4vdNodz
oN4ax/8Ha4KjiiwWEjJJu4kl4zR1u8FlMV7YRORo89TetXBYo7k2rYcDWOoxIluY
tdw+U5f1UG3NYirAraHS
=akTz
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--

--===============1512748410078864875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1512748410078864875==--
