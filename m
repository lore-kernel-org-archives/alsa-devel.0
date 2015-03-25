From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: snd_soc_tas5086: Reinit register
	values on probe
Date: Wed, 25 Mar 2015 09:20:29 -0700
Message-ID: <20150325162029.GF3572@sirena.org.uk>
References: <1427297379-17736-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7227407915761801310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E96265363
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 17:20:15 +0100 (CET)
In-Reply-To: <1427297379-17736-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, zonque@gmail.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7227407915761801310==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 04:29:39PM +0100, Pascal Huerst wrote:

> If the machine driver has been un/reloaded, the register values of
> the codec driver have to be reinitialized in order to run properly.

Hrm.  This isn't something that I'd expect to be required - I'd expect
that as part of the machine driver teardown to put the hardware into a
reasonable default state so that things come back as normal.  Can you be
a bit more specific about the problem that you are seeing?  We probably
shouldn't need the existing reset that's in the ASoC level probe either.

I do think a version of this is useful regardless of the above...

>  	tas5086_reset(priv);
> +	regcache_mark_dirty(priv->regmap);

Since the device has hardware reset support we really ought to be able
to do the register cache resync only if the reset GPIO is missing.  How
about putting your code into the reset function and doing it in the
case where the reset GPIO is missing?  That way anything that thinks
it's resetting the device will get the benefit of your code.

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEuBFAAoJECTWi3JdVIfQKBAH/0eIsWORRP9dyVF+jgISgL83
8Fn4/Jh0ig9y3W+WilmHKlRnR1UcPyEj5RTYQHRYX6Z02K/zpHXcilOsanM4QMVp
5E+E6tIwwmxfRr8hfL7vdeVKheNzIKAH+hcCiqZ4dV1CDSh32BVCHvTPrcNzUZke
ErvWr3339deCPsjAOuaaaAcQErCW6VmSsljbN2dwi9sdfjlM65cN5cgz2YGwUzZF
9iOMzO6pydXURo6VNuCR9M46ZvARxzueEo2YxZrGbHuOX5xJWXvk5wOOLxsNbVKB
/9dsoVHBY9X8/pWeOeHY8+1gyQTldRAyI55nwpWslvu8tgKcTb7kaIQEBbdSad4=
=pM3k
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

--===============7227407915761801310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7227407915761801310==--
