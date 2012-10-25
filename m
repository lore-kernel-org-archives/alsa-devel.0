From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: supply and micbiases shoud bring "up
 to" STANDBY
Date: Thu, 25 Oct 2012 17:49:18 +0100
Message-ID: <20121025164917.GR18814@opensource.wolfsonmicro.com>
References: <5FBF8E85CA34454794F0F7ECBA79798F37A052B72B@HQMAIL04.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9198856022348977161=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28AD6264F47
 for <alsa-devel@alsa-project.org>; Thu, 25 Oct 2012 18:49:19 +0200 (CEST)
In-Reply-To: <5FBF8E85CA34454794F0F7ECBA79798F37A052B72B@HQMAIL04.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shaoming Feng <shaomingf@nvidia.com>
Cc: Daniel Solomon <daniels@nvidia.com>, Stephen Warren <swarren@nvidia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============9198856022348977161==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="foM9DbudB2CcldhH"
Content-Disposition: inline


--foM9DbudB2CcldhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 24, 2012 at 02:19:35PM -0700, Shaoming Feng wrote:

> /* Supplies and micbiases only bring the
>  * context up to STANDBY as unless something
>  * else is active and passing audio they
>   * generally don't require full power.  Signal
>   * generators are virtual pins and have no
>   * power impact themselves.
>   */

> According to the comment, the target bias level shouldn't be higher than STANDBY.

>                         case snd_soc_dapm_clock_supply:
>                         case snd_soc_dapm_micbias:
> -                               if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
> +                              if (d->target_bias_level > SND_SOC_BIAS_STANDBY)
>                                         d->target_bias_level = SND_SOC_BIAS_STANDBY;

This will do the wrong thing - it'll mean that if we've already found
that we need a bias level over _STANDBY we'll pull back to only
selecting _STANDBY.  The intention here is that we should raise to
_STANDBY but this shouldn't distrupt operation of other widgets.

--foM9DbudB2CcldhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiW2HAAoJELSic+t+oim9XsoP/jGvG0OzNSzh009ItMxeUc+3
fcLYtkvAGy3/Lnb503r/PN/MjvuYZdANAGb0r35IbNmh2oT4byBRvY8cTpmQzb31
h0edyZjE9I1CmWvA6bmtfnFplrBrrIqCL0YQ4P296ln6jqF26hIB368x4pffbfMk
sjY4D/T0qVKtCH0eBebdRgq+bber1h1hlOvMjZdycv7QbG4elhx8XVb0oJCDRFP5
+2wEb5AX37qzs5DOct6XoyFuHlwKegNV1/U97/HyarhJI6cB55vIr5ykv8UlXt6L
jO5ZxLjShrRG9pHldXR/eLKmkq76DexsHltwT2vSfk+qh85uTeu/w/B1zkPlgg8d
mMA08coFSy6zlM/5x/BxHj/hToO0brR9nw89veyBIuFotV3CZ21BJUjgIcL/yW9D
dAIg5w7XjTKQ2e02qHQb4v5rrcmd2Bq9r4FVjKdKBtpU2qs8cBOkma9iOW9o1+HJ
bqvNl4RrW8Ll5nHEAKUZ0hmS4ZKSaIpr37jyjeEN9FLnKt55hZ5YfpuOMPNzcNjh
nCr8m76E6j9eU6BBG8WCbIDuphS5VdIEfKUlR3l9aKkB30s+MnpKnKmxXADeyb7J
C73UIuzZkAZUobW/ZlhbImq4S8PiN3gV+AQpdEkeh54Gf+doawXxDlZO/8RJFU7I
Mn4vQueuft22SkAdr6Oy
=xRMR
-----END PGP SIGNATURE-----

--foM9DbudB2CcldhH--

--===============9198856022348977161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9198856022348977161==--
