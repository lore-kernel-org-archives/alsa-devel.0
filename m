From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: bug report for ssm2602
Date: Tue, 26 Aug 2014 07:28:46 +0100
Message-ID: <20140826062846.GS17528@sirena.org.uk>
References: <CAHG8p1BqrSHagAWor6ZqnnPReBPvYfwpXpbNOSWBjxa5n-raEA@mail.gmail.com>
 <53F71195.5030502@metafoo.de>
 <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7281603026059926543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 758412615F7
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 08:28:53 +0200 (CEST)
In-Reply-To: <CAHG8p1Cj9s1-WAyKNtFkCFK0Z74-YX0A7O1o0oN0+hPqNCrorg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============7281603026059926543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nsGkdDxeIUSTLY42"
Content-Disposition: inline


--nsGkdDxeIUSTLY42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 02:11:20PM +0800, Scott Jiang wrote:
> 2014-08-22 17:47 GMT+08:00 Lars-Peter Clausen <lars@metafoo.de>:

> >>      ASoC: ssm2602: Fix cache sync

> >>      The ssm2602 uses regmap for caching not soc-cache, so we need to use
> >>      regcache_sync() instead of snd_soc_cache_sync().

> >> According my test, regcache_sync() can't recover register values when
> >> resume. While snd_soc_cache_sync() works fine. I used regmap_read() to
> >> read registers in regmap layer and found it's the same as suspend. But
> >> regcache_sync() didn't sync these registers correctly to hardware.

> > That does not make too much sense. snd_soc_cache_sync() is definitely a
> > no-op when using regmap. Which kernel version are you on? Are there any
> > additional changes to this driver in your tree?

If it is the above patch is the problem perhaps that the register map
isn't getting marked as dirty so the cache sync is being suppressed?

> I believe this patch isn't related to the pm bug here.
> By the way, have you ever tested your patches on any blackfin board?
> Your patches for adau1761, ssm2602 and bf5xx-i2s all failed to run.

I guess this is addressed to Lars-Peter but could you be more specific
about the problems you are seeing?

--nsGkdDxeIUSTLY42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/CkbAAoJELSic+t+oim9mgAQAI+zfCs0qhM2VFy94XbQcmtt
Let7xn9IbLf0bod60DGDRBUxxVfc1vNepneFsihvcY86h+yhEPYHjvjvI0PPeQy/
KySi3eyg+408tsxh6DoFionw7sAK60k/Bc8M2C6BmQ47wY+XJekp9QJ7r4Hec1jQ
THaDwimuS00i1TZoDwVl3O4Ew4sLirHrNcX6YF5ySkr8mXHwro5USc8hS7c/+c36
ER9nxGHDKtcYmiElrmJIFbmXzXPPm+FjmL9TYCflCxGjDxOAIeZQh/r95UAJ+rZE
eJPg0rM/Zs1hOwe4NEMZ8dCXMIcmoTLCemipdPvDODxYnoi9QSGEUio1e/ZtFA8E
n/aC3L3XrgrsMxOIIN1hFXQUVV2iTUzHxtYT5sNRa48nNBn3LDMGywVxFV3budD1
e82V35eR3VdQ2bp5bVIXgwEdcEyoVGrO4OuA+eCzoKHEh/gAP3MQstN1d/L1Igjw
NxZs5bxWRGiQ1bwKlqUMfflHXtfcsVACnQNImBK4n+jqGwQjF2lNr9IA5GsVRgdc
GwpQ2+yQeOGeCNW86nFOcKryiau2GEVNTIGrklHl54Hn36Klvz1Vf2CDMlsVaxuK
GpU+GVn61KhuxKRgJmNbz3DvIG53o9ADtQ1MGjUmzx8FIfanW7jJd0gOiipCvHsa
YxxvC4746cTLfoCKpqnP
=z8Uz
-----END PGP SIGNATURE-----

--nsGkdDxeIUSTLY42--

--===============7281603026059926543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7281603026059926543==--
