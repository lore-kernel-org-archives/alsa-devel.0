From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5 v4] ASoC: dwc: Update DOCUMENTATION for I2S Driver
Date: Thu, 7 Apr 2016 10:53:26 -0700
Message-ID: <20160407175326.GX1924@sirena.org.uk>
References: <cover.1460047238.git.joabreu@synopsys.com>
 <ce97e6bb7ddb71e532c4066334ceead4d4d3e692.1460047238.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0888896417=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <ce97e6bb7ddb71e532c4066334ceead4d4d3e692.1460047238.git.joabreu@synopsys.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, CARLOS.PALMINHA@synopsys.com, perex@perex.cz, tiwai@suse.com, linux-snps-arc@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0888896417==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sL7C0a98p/u5aVah"
Content-Disposition: inline


--sL7C0a98p/u5aVah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2016 at 05:53:59PM +0100, Jose Abreu wrote:

> + Optional properties:
> + - snps,use-dmaengine: If set the driver will use ALSA DMA engine. If set
> +   it is required to use the properties 'dmas' and 'dma-names'.

This is not a good interface, it's describing Linux internal APIs.  If
the device needs to operate in PIO mode it should just do that.

--sL7C0a98p/u5aVah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBp6VAAoJECTWi3JdVIfQZokH/3MxQ4yVAhCrg3rnwoydPL/I
M8Ff+/af5imPOlJE9YCTxkmnDN6vcRiQAZVCltkUx1aofnL2XQI6M5pyR2wGhJBQ
kCfQSL2RSH7vTkDLRZceqQcSAx2Z7RE7UhV95z9GcZgqSnDbcomtDyh5bLA2zJmp
gtT15nIhDiHgtQcP1xTW/Jq4Ynp78hjREcgjGUEyqDN29icafnwJ8kzTarIeX104
EbWA22aGf2HzyjN+JPus3+9INVqLeOsplsdBkZ/FvCWVQe6Sc9dj1LDOyxucc2iJ
StbKXTplBhdG4DuX7HdFeTrM2VYaA7Deu5s3ajRVeQFKDivOpiHqY22wOL0pavw=
=VYt5
-----END PGP SIGNATURE-----

--sL7C0a98p/u5aVah--

--===============0888896417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0888896417==--
