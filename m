From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm4567: Add driver for Analog
 Devices SSM4567 amplifier
Date: Sat, 27 Sep 2014 11:18:15 +0100
Message-ID: <20140927101815.GF27755@sirena.org.uk>
References: <1411747721-38619-1-git-send-email-anatol.pomozov@gmail.com>
 <1411763466-29018-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2318874209473955896=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5B98260445
 for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2014 12:18:39 +0200 (CEST)
In-Reply-To: <1411763466-29018-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2318874209473955896==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIdIj/ncdD+VcXt4"
Content-Disposition: inline


--lIdIj/ncdD+VcXt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2014 at 01:31:06PM -0700, Anatol Pomozov wrote:
> Analog Devices SSM4567 is a boost class-D audio amplifier.

Applied, but don't send patches in reply to existing threads especially
if you don't include a version tag in the header.  This was very nearly
deleted unread.  One thing to look at incrementally:

> +               ret = regmap_update_bits(ssm4567->regmap,
> +                       SSM4567_REG_POWER_CTRL,
> +                       SSM4567_POWER_SPWDN, 0x00);
> +               regcache_sync(ssm4567->regmap);

This checks the return value of _update_bits() but not _sync() - make
your mind up please!  I'd also split the _set_power() function into two,
there is much more conditional code for the two cases than common code
in there.

--lIdIj/ncdD+VcXt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJo7iAAoJECTWi3JdVIfQD3cH/30bqGf+gDvFOEkOzsoEWDl8
0O8aCQhPMTRTawcB1jJLAgD+WWDF/96pzbcGzMIujUqEO/+LHex5VB//D9JuRnx3
0Upqk5C8/7Y7W0mHcpeJ/ctP9PrhWtFhyxrAwOEqHS1pCIVbwlTvJmiDTaFe3N7A
RfknEq0ym+Lmp7Y+ehntISJ6Loswo4RomNaFkTB44Kx+WTcms9gRDd8/UMG0QyOy
xZkpshlXYIBi3boWlZd1pXZbl9ppOZ5XWqDN3vtUT1EHjHYsy8HMgavOTsacetT9
ftPfMkOd3r6eWlmphpYGYJEAV9VOcystuGwl+omtk/06Ugk639I3PpP3bHDhdlM=
=cHQW
-----END PGP SIGNATURE-----

--lIdIj/ncdD+VcXt4--

--===============2318874209473955896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2318874209473955896==--
