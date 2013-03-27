From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 resend] ASoC: cs4271: preserve "Master
 Playback Switch" setting
Date: Wed, 27 Mar 2013 23:11:30 +0000
Message-ID: <20130327231130.GD18316@opensource.wolfsonmicro.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
 <1363895035-20356-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0823704258204085362=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5BC1B265364
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 00:11:32 +0100 (CET)
In-Reply-To: <1363895035-20356-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0823704258204085362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5Yj4BWVzBU0tpZR"
Content-Disposition: inline


--W5Yj4BWVzBU0tpZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 08:43:55PM +0100, Daniel Mack wrote:
> Currently, both the ALSA control for "Digital Master Playback Switch"
> and the ALSA core (by calling dai_ops->mute_stream()) control the same
> bits in the CS4271_VOL[AB]_MUTE registers.

Applied, thanks.

--W5Yj4BWVzBU0tpZR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRU3ycAAoJELSic+t+oim9rPsP/iNLg2NlT5m/F4b4GUcI6mSZ
2se6EKGFL1gzV1ijueBL6zR0zbQvtm6FWUf44UTiTZI8ikThUVzPSymVybXO2av2
XXInzWcH7iXbx668m/F5YWsTafPAyoDq7nqTEGyqvOBI/B+KSdrrA/aO7qwFUBrO
gI45p3b6EQLC0YFMXSSmtJKDA/VhPz3N9A/86QhNLPQSDhDs3qqoc1036k5XJWxu
40wWlSicn6zvx35/3oRANzdrAAwCojwLAEFGWQ+PzdjEqCqRxrLzSsjDSdATY4xw
Gq9gsoHVG8VVY/GFAoUUOVupq6bAhoZVoQZmj3BxGcn38H/huleLBqEDFQNv5D2J
cmymEytOEF4n39z/vKCbsbrku1gh3jl++CQ6kzGnfM+W7YLrib84CFDG70C1mQRf
rdkFCmoS6CmiRCDOosuFRgSxZA+yX+DT1qGFSPxzi8HMmQ/BP7BVxnG6EoQLNbZ0
qHf+bTx+JOoH6rgOSgVxGpWYt0RVxZi0B23B60QGtUTNSwCaqs06pM1r7b3GNpu/
J9KM+HGoC9poFMQeuIGSjl6cf1r0NtdNfj9MEh+IP6kHrhmgp7MBaPy5tuH52q2c
QoCZWcX0QPNnjxKZsleEyn2t5to/ySnUszQD0nWEkmq7u3r2WzalM0VeHEVRX+IY
XBYhz/r9ZIdGvgCeUkq8
=/tAB
-----END PGP SIGNATURE-----

--W5Yj4BWVzBU0tpZR--

--===============0823704258204085362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0823704258204085362==--
