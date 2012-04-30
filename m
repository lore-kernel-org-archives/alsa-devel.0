From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Mon, 30 Apr 2012 11:04:52 +0100
Message-ID: <20120430100452.GE3170@opensource.wolfsonmicro.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
	<4F9E4CB6.7090606@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7905176609000895978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D2F9243BF
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 12:04:54 +0200 (CEST)
In-Reply-To: <4F9E4CB6.7090606@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7905176609000895978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2012 at 10:26:30AM +0200, Ola Lilja wrote:
> On 04/27/2012 01:15 PM, Mark Brown wrote:

> > No, I really don't see any value at all in it.  The machine drivers
> > aren't actually sharing anything visible and the effect of what you're
> > doing is to make the selection of machine a compile time one instead of
> > a runtime one.

> No, that is a misunderstanding. We are just dividing the machine-driver file
> into one main-file and then calling functions from other ones. It is not
> affecting the framework in any way. We just want to divide the code in a way we
> find useful. One file calling functions from another one. I don't see how that
> can be a problem.

The code I'm referring to is this:

| +#ifdef CONFIG_SND_SOC_UX500_AB8500
| +#include <ux500_ab8500.h>
| +#endif
| +
| +/* Define the whole U8500 soundcard, linking platform to the codec-drivers  */
| +struct snd_soc_dai_link u8500_dai_links[] = {
| +       #ifdef CONFIG_SND_SOC_UX500_AB8500
| +       {
| +               .name = "ab8500_0",
| +               .stream_name = "ab8500_0",

which is definitely compile time.  It's not the factoring stuff out,
it's the way it's been done.  Library code like Tegra uses isn't a
problem but this sort of arrangement does cause problems.

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPnmO3AAoJEBus8iNuMP3dQ3IP/j/UPEqquSGKk/rJC7OxhfxM
NpweeS8pGFzAZF5OqcNmT9fLWNErT9JlXS0Vev+rOsAAtbgkgEacO1Py6ENb9Jrd
50cXSPXrlbYawPstOB3ddFrq0KN+7vMRVGYqe5we9Glt+to1Y3naSnsqaGsDLl7H
5o7GTGY1A9XuaLq+LbOdh2khUkir3RdmenPwOBoHNNHHEkCV/V05vxIzXGcOMKfn
s6tTyQSur6Hr8gWW/ZoU5cZ2tAW3vGRR0mpTimjzWe47/akMDVZjhxFWxcWIbp/s
UogV6d7J4gmcFQi8A07wMcUQs0SNEUKOofxUXhOHEm/6kEOFefCGrSiSLVZcuK6D
rXOYRvmnO3b8WZM2lTnkhXYF3yOMjvk/kjScaJJzbp9Xu4mvPnj82XwHSAAjIIXR
tq0VkYAKIJ8lzmlh947JGeZzRSMhc15ZOYNBI3YVSMTF0HzJtlqXsh7Q/uLndOSl
54jhP6rw5CRLttR1/lPs3CZvwPy/1JzrkuUiehimNsXzmqp5/oRY5IvOthGgi7n7
fnQUV4KEMZFEwzGGB+gq1iPs0TZ/u1SYc7KONojXOBz5uysRhZ9OKXBMEUGIr75U
rUIGEsXasJippBVZJz0aLKNyePTQnL+1HA8tGvPICvmObFsvZbVYctHdEE709o9s
z6pdl10ranejeLPovMrt
=amkt
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--

--===============7905176609000895978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7905176609000895978==--
