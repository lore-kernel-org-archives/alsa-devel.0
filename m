From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: davinci-mcasp: Harmonize the sub
 hw_params function names
Date: Fri, 31 Jan 2014 15:58:59 +0000
Message-ID: <20140131155859.GG22609@sirena.org.uk>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
 <1391087725-4088-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1956554582908374266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E80202625E6
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 16:59:06 +0100 (CET)
In-Reply-To: <1391087725-4088-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1956554582908374266==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mb1GmuWGbG8HO3cw"
Content-Disposition: inline


--Mb1GmuWGbG8HO3cw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 03:15:22PM +0200, Peter Ujfalusi wrote:
> Instead of
> davinci_hw_common_param - for common, I2S/DIT mode settings
> davinci_hw_dit_param - for DIT protocol configuration
> davinci_hw_param - for I2S (and compatible protocols)

I've applied this but please don't put stylistic cleanups like this
before bugfixes in patch serieses - it creates a barrier to applying the
bugfix.

--Mb1GmuWGbG8HO3cw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS68hAAAoJELSic+t+oim9Em4P/0iyMIP8ennadVcyNZgRpWx1
sjBAcf+izbNEChbjvZobbtTVuBwrj6OYl/hZfY+jPdHk+xnFvTRiaV3LF6qe2KQL
9Cc2Ryk08t+AyhkjwujgMX0r+38IQ1XHtCTfbe3oFp9HlolQThf0nHMlLhJ8yW6k
KWHpxfNPEokT+mjwxbNjiMEQzOznoP3Ilqd4DhIR1aaJTHpAqrocug66btEfy9w8
RNGByrwcefY8ARiFA/cik2SCRh88JDdIbfRvPT4LvruOYicgwYNrrQxeTM8ZJTmC
ooeo8WpjsKgyEuVa1HXzqK/EHG7ugh+hUk3UCJrarQrxeXzFQ0/S08YmT5fukFpk
0UaxN3C/TZcvK4E6C+sXfNk98Prr2V5sPg4qp6FX82O+RYMKfWPEPPPooxH+W1zo
LbT1ae0RYa7/Gxic0YCCv6nyTjeDVyYAaRaGMnShSTJcFAOrXcZvPP2/5D+4dSQE
Xap0Jf/eDgS3/32JOLCjprJXdUetnBqrafkNqhH/IzNWVZLR4If3oaymGS+8w0mu
e5tNWgX4X21prQqCSo8X5uKDvdJSkX1Z4pHin96+4RqDkkPnv9CgIV/Lsop+UjLV
hre1RRcBcqQ8rX2nvRNCH4iuBZKqdJNIENb1ZoNw5xxyWPQyw3j8pNqcS6XSsMZy
Pq/U/zYgsrKc/cfq7J0z
=UvB8
-----END PGP SIGNATURE-----

--Mb1GmuWGbG8HO3cw--

--===============1956554582908374266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1956554582908374266==--
