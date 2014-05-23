From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: sgtl5000: Fix the cache handling
Date: Fri, 23 May 2014 19:33:57 +0100
Message-ID: <20140523183357.GL22111@sirena.org.uk>
References: <1400856538-26859-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9187341135644303891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F1E26500B
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 20:34:29 +0200 (CEST)
In-Reply-To: <1400856538-26859-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============9187341135644303891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQhvuUkKKd6r3A8m"
Content-Disposition: inline


--LQhvuUkKKd6r3A8m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 11:48:58AM -0300, Fabio Estevam wrote:

>  static int sgtl5000_resume(struct snd_soc_codec *codec)
>  {
> +	struct sgtl5000_priv *sgtl5000 =3D snd_soc_codec_get_drvdata(codec);
>  	/* Bring the codec back up to standby to enable regulators */
>  	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> =20
>  	/* Restore registers by cached in memory */
>  	sgtl5000_restore_regs(codec);
> +
> +	regcache_cache_only(sgtl5000->regmap, false);
>  	return 0;

Like Lars said this seems broken - why are we restoring the registers in
cache only mode, and what is actually doing the sync?  I expect the
errors you were seeing when not in cache only mode were due to the I/O
failing, most likely due to the device not being powered.

This appears to be another one of those confused things that the driver
has been doing since the early versions rather than something introduced
by your patch (or the regmap conversion for that matter) - I'd be
surprised if we're not just seeing the results of better error checking
here.

Looking at the code what I'd expect to happen here is that
set_bias_level() manages the cache enable, turning on cache only mode
just before it turns the regulators off and restoring normal mode just
after enabling them, then calling _restore_regs() after that.  The
resume call should just be a call to set_bias_level() then.

--LQhvuUkKKd6r3A8m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTf5SSAAoJELSic+t+oim9bRsP+wcNDjMC41kv7z1KJcQdcbTb
Kum1NhvRJz9ZtpZ5yFhokGI89qD/iiO4DAAta1uCKc3zyK9XrhMbq4VRbsYLMC+C
8kqAeiBG9xSjFpTIkYph2u+uYmRb1uDuX59NPovKbgwuNqM0tI3R/WwKGZ5JJD18
SGI1UuTBz/JClQwemBS7KcbN3mjJse/Ju1NkUtBhZM/HaAU7EqzZVhUKjt0DO0Jb
4rTfNzwYTSb3oQzVbUdbCXXAfJUr7oFjRAwBXyxJ5/YQ9nZGpNtiv0i6u64s4MDu
2EbU/S6dC7YVcQoAIdnceYRkffAfEy99onexSIUvsLxMYdtE6NLqCECHa03r8Wm4
JVaLtzKPhmg7KfODISOu+e4bwHmtlW1nwnb44ika1GRzM5RGD7iorpCyxaqdyaeb
TNhlyZfnsaXfMwWp/vQRHqoZfy0WEAodLUnUNNhyMouARV8kNlbaV7U1+QvGnEUA
UOo5GSD3QoS0jX2N33b2nvQShmeqLHFMqlUKIXaZqtenL+3FMlJ84PokplBkm4BD
lnbk2c75sJAio83FAjusW89JUjl4NZmULpdJt5yZItcns64cy6US2y1J2OLyMkVM
w/EPppg43k0d4w8hTdHjZi045Qc0AOlYm82Gfx1UU1FLcospKrym9k6wGVcb9/02
7wr+11X+nqRex/ECOuw3
=7NJf
-----END PGP SIGNATURE-----

--LQhvuUkKKd6r3A8m--

--===============9187341135644303891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9187341135644303891==--
