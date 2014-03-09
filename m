From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
	audio support
Date: Sun, 9 Mar 2014 08:11:02 +0000
Message-ID: <20140309081102.GL28112@sirena.org.uk>
References: <5315DF41.1090302@metafoo.de>
 <1393947831-26116-1-git-send-email-jsarha@ti.com>
 <20140305014259.GR13126@sirena.org.uk> <5319BF67.3060403@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1208276847846429339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10CC5265545
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 09:11:09 +0100 (CET)
In-Reply-To: <5319BF67.3060403@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1208276847846429339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gsH/BiyznuOL98BK"
Content-Disposition: inline


--gsH/BiyznuOL98BK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 07, 2014 at 02:45:27PM +0200, Jyri Sarha wrote:

> However, I think there is a problem with simple-card. It does not
> invert bitclock-master and frame-master values when converting them
> to CB[SM] and CF[SM] for cpu_dai as I think it should. I can get
> around it by setting the both cpu-dai and the codec as bclk and
> frame masters in the sound node. I volunteer to fix this if you
> agree.

No, it shouldn't do any inversion.  If inversion is required one of the
drivers is buggy, they are CODEC bit master and CPU bit master so for a
CPU driver the sense should be inverted when parsing.

--gsH/BiyznuOL98BK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHCITAAoJELSic+t+oim9qzoP/1M5RSbHmA6Q1byZ4NESftav
GIsTwDT5waVX5kGZF7HjHa5wUtxpaaPrs9e/oqaJJ/M+NDgdX8QAQyDW5VMBVP85
kssXjRzPedr+I8GEEqhphYe1yggZsF7igiab3Ql27r3pb95h0kOzK9HGyB/8TpGf
iBFkWKBnxQuHgGUWD7Lh4Mr5YZ/QH9VwueCN6FZGXsoqYhPNz8y8Ve6GHaguJN8H
yJAYaV3MdMDhFs9duSy7Iq6ciovYuvg3Wa8y2RnvJrAb0f3EcORxp4VcaHPwcjmX
DEfRojNphwKTQNvnz3iyad/aJ5gLMuhuUab9nplMSeNUJYJYvRZRnqWN7hfLakud
OcscKqWvVMFeLqrVsuQir7XbJeCaXy+rIIUIvDH4Tf2qHFiR9CDWLLtLrxT0qEhQ
ayfLMMFcsEzvrm3excpjLE8gX35aqml6CuC0Sd2udhg2F4RK0kJ7FVS+Dt9P+67A
q/TC2SxhozSo8vk6z8y880ZFbZfXbmwPbGlOrULbLF40GOQ/5l6LxAhjvAuT2UWW
Y3H6bfS6LH6oLe2qbS/xKARk+84VOmJIN6XYcu2BSUzstclS4LL3+V60Gh0ORIm8
Lz5BPiCABD4ZNX2RSBMhnINtwI9GImKGoc6HuzD3VF4FmLUdxhEiSIbzykYaJofd
ppIqDleL5hBoyd9GvBGC
=l0AJ
-----END PGP SIGNATURE-----

--gsH/BiyznuOL98BK--

--===============1208276847846429339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1208276847846429339==--
