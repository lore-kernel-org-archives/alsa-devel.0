From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Thu, 23 Feb 2012 16:14:47 +0000
Message-ID: <20120223161446.GA7245@opensource.wolfsonmicro.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
	<20120223151934.GB4553@opensource.wolfsonmicro.com>
	<CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0445402500875766639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 039401041E5
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 17:14:50 +0100 (CET)
In-Reply-To: <CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============0445402500875766639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2012 at 04:58:09PM +0100, javier Martin wrote:

> So, let's see if I understood properly. If I want to configure the
> i.MX SSI into standard, I2S format I should do:

> dai_format =  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF;
> snd_soc_dai_set_fmt(cpu_dai, dai_format);

Yes.

> While initially TFSI bit is set because of I2S flag, it is then
> cleared because of the NB_NF.

> Does this mean this is a bug then? If it is, I would gladly fix it but

I've no idea what any of the register settings mean here...

> there is at least one platform relying on this misleading behavior
> that I can't test:
> http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/wm1133-ev1.c#L81

That was correct at the time it was written, though the code has changed
since then and I don't know when it was last retested.  Of course
depending on the signal it may interoperate well even if the setup isn't
actually correct.  I'd just fix the driver and if it works for yours
it's probably OK for that board too.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRmXwAAoJEBus8iNuMP3d4nAP/0tbweT3zIEquKN0qh38nYhK
RD98AYTXumIXszByTR8mw8cSe9x1+5ACeFMeuema1JG0/8k8Ivq6EI5UIneCA7yL
NTnp4CJYwnjI2rePo+ASQt+LbY/H4wHWw4bk7yu4kZQ8Yhmato3UBn3LYOe93pkf
BKSbFViAznlY9CIjmNTlRJsRXcOGq1c4x0ZKFX3NAwAYyiLYUnAVWCMP64SD1KSa
f4+YpDeuAFu9KGw0ukcCdoQ9uFWuT3EHtqf+lHPn2/jz9dn/lUJVDmgFlLfaMzKl
0YlKN9AXcCWbfGv2lmQ6ifNXxeJKJHzMZaIrjiPBklguCaIu61h1BrmtX3oNgU1b
xcVhKu7KYAuOI9ujD9LYhZyQGC4TelX/oPekE9M68Hx3fpKWTTvae+VVrspE8SFr
C6g/YMof92CqA5PvMOVCakO+Xm4EkQ1yEj+Nl/gy0tJIajrFgqYu4l1e0J5i5haO
H980SKWCJ36Dp8XgGvXwakRbz2AN3ifdTBKKaEjv9+5K/8/0D9GajUT4CNs5NaxZ
hxZpZtCUz09BFGp+PFxBPgkoGWW7Ocdqf6f1A84cAdFluZ2wYMLQG/L/chPvkG94
Ryb0rpLNTOg41ApfTTGk4OJZmsp5ENtOilh0s27w5cDbOepzqjWJ8CFxdrKzMSzq
DGKlcAgOPMUQZ9UuMySo
=synS
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--===============0445402500875766639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0445402500875766639==--
