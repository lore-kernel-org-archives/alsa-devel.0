From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: arizona: Add signal activity
	output for DRC
Date: Wed, 3 Jul 2013 16:21:44 +0100
Message-ID: <20130703152144.GM27646@sirena.org.uk>
References: <1372855126-13122-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1372855126-13122-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4971351441504026144=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C659E2655C5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 17:21:50 +0200 (CEST)
In-Reply-To: <1372855126-13122-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4971351441504026144==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6yI7Fv2tfqWgENHd"
Content-Disposition: inline


--6yI7Fv2tfqWgENHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2013 at 01:38:46PM +0100, Charles Keepax wrote:

> +	switch (arizona->type) {
> +	case WM5110:
> +		snd_soc_dapm_disable_pin(&codec->dapm, "DRC2 Signal Activity");
> +		/* Intentional fall through */
> +	default:
> +		snd_soc_dapm_disable_pin(&codec->dapm, "DRC1 Signal Activity");
> +		break;
> +	}

The comment there is a sign that you probably should've written this a
bit differently :) - I'd just make the DRC1 disable unconditional and
then people reading this don't need to think about why there's an
intentional fall through.

--6yI7Fv2tfqWgENHd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1EGFAAoJELSic+t+oim9KRYP/ijJ0VpnKlAkfQH4O3o8xFyP
pkQjvrNb83bRN3iq+4+17V9PMB5k1LjRrfdAwolrRqHC8m7vCUNEz0v9kONBGsUG
/iGkaRuh7E8o18Dz4QotMRC4fMFACQSghKfrgzL6hR9/iQOujLYFHgMJ26r5z4M6
aUhJMJi+qI/9KbOsfcsK+aK91NZ0VpnLZSqg7Qk0sUq4yTws+I6f9FDcsfGvgCuZ
DPzhn26UpX2edoKs4KWIeHERQXZvKDUUXKOKNPF0JWwqt9hYs0K97QIg6chegXEE
cPocYz39s4F4SnkkVeWjCw/kJ45PgwKYxsDXD2L+KbANlEP8WyTY0tWA8iqr6A+T
9XXPTpLQkV1kX+jxI7WzlWXo3mkNOlR7ib01V9/LBZ00yfNDNclCKEG1P/4FbeTv
Vz/JQN9I+4PC5hchqZw9iFMIeiVy0sbMWqfgtKO9f/wn4MDZu7xKTQVArHaOl1P3
qs2InZyVRSm2FbQsK374688CDlbB82NMQcuYvq9wU+LDNUe6vEAo7PG9LrAF7hIF
3+qVjOcYGaMGLk/zjaubwIljhuJjsar2PruEeASe15avd9kCvrMHtQd+QkAFr7M6
gSFJPmWkDnfINzEE5Vml4o6nVmxSb5RfJGfCUcy5+qRyWlbyuAhDsTPvGEVc+B/Z
Gv2w/tICytn5q42Pjs1s
=eGUx
-----END PGP SIGNATURE-----

--6yI7Fv2tfqWgENHd--

--===============4971351441504026144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4971351441504026144==--
