From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm5102: Implement OSR support
Date: Wed, 27 Mar 2013 15:43:11 +0000
Message-ID: <20130327154311.GW18316@opensource.wolfsonmicro.com>
References: <1364388762-8477-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20130327151300.GG2141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3411078131427355239=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB54C26522C
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 16:48:31 +0100 (CET)
In-Reply-To: <20130327151300.GG2141@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3411078131427355239==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H23uHpCUqgUcHMpK"
Content-Disposition: inline


--H23uHpCUqgUcHMpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2013 at 03:13:00PM +0000, Charles Keepax wrote:
> On Wed, Mar 27, 2013 at 12:52:42PM +0000, Mark Brown wrote:

> > +static const struct soc_enum wm5102_hpout_osr[] = {
> > +	SOC_VALUE_ENUM_SINGLE(ARIZONA_OUTPUT_PATH_CONFIG_1L,
> > +			      ARIZONA_OUT1_OSR_SHIFT, 0xe00, 3,

> The mask here shouldn't be shifted just 0x7.

Right, a mixup in the mail rather than git fortunately.

--H23uHpCUqgUcHMpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUxOIAAoJELSic+t+oim9bocP/0ZZGlBfarmTXxHifoi4hjtD
zrN736vrwzW32501zk62H2rgUlsGPbcwCIwXKJ6cnBX6THjrXeziBSNLVSBkKmJH
HmmmsYoD7p585EmwgQeqnOJKuplTP2z8iq/NTURAT0cIF2HEuXaulq+znULUvs46
VSY5SkhOv81DMayraiLE03uO3EXmmqNv7z7rPwRSS/D2c12KywAbg1m2Rwdb9Quw
HmcgE+Sg7KJ2qBMwNSJeBTOB25z82jpLKugpjY9A0UiK49Z5eFzrzRM67v0suoWu
bizv5/odG1dz6W6HWdPSKjZ3SG+nLKSptGF8iUQ9W3e1iaNYcFfYZxJeyzPwC7NV
I0jyDKkqZbOqu0V4HMmRp7QxLxgHm7q9SJcHtORC4tltDRX6KtnO7eVK+63utQvE
vSyYjO76gfiBWYkO99+4FtGvSx3sQjeq03YBL2/4NNa+Atany9tAtDnuzbXSVdNq
jao50OhINM876x8u/wNsiRBvLjSyeRR5sLJoH5mjGlIFJs173+RXHRK86hS2PI/M
gcohQz4kxZN4OOC3ZWugH0s/04xcBwPszBjCRA5SGgCyu83O79CcTGwC/6qCc35A
5BIN9LFF+Dhk4hcTZn68XiaoTYU+P/3qUUkvBD8HsGbCQpkTOqnNthotv0x1vz1d
VrOWOMw/lYkC9yfgOMFG
=Mscc
-----END PGP SIGNATURE-----

--H23uHpCUqgUcHMpK--

--===============3411078131427355239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3411078131427355239==--
