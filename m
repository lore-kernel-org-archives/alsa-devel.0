From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
Date: Mon, 8 Jul 2013 16:07:21 +0100
Message-ID: <20130708150721.GK27646@sirena.org.uk>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4271437288377211243=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4271437288377211243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y/W7LeEItOXj90cO"
Content-Disposition: inline


--Y/W7LeEItOXj90cO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2013 at 03:29:49PM +0200, Richard Genoud wrote:

> + *		  Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * Based on sam9g20_wm8731.c by:
> + * Sedji Gaouaou <sedji.gaouaou@atmel.com>

The obvious question here is of course if we can use the same driver for
both of them.

> +	codec_dai->driver->playback.rates &= SNDRV_PCM_RATE_8000 |
> +		SNDRV_PCM_RATE_32000 |
> +		SNDRV_PCM_RATE_48000 |
> +		SNDRV_PCM_RATE_96000;
> +	codec_dai->driver->capture.rates &= SNDRV_PCM_RATE_8000 |
> +		SNDRV_PCM_RATE_32000 |
> +		SNDRV_PCM_RATE_48000 |
> +		SNDRV_PCM_RATE_96000;

You definitely shouldn't be fiddling with a driver's constant static
data.  You want to be using snd_pcm_hw_constraint() APIs to set
additional constraints intead.

--Y/W7LeEItOXj90cO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2tWmAAoJELSic+t+oim9SigP/2mwYwTpQGPNkYf5YXgcIOT3
Pvc/Q0MjIbEglKCTk5iydPoqZlr/649FXbyatcxwe6BMhvS7EHzZ7KlrGVDJdPBS
7UjW0S7ZmhZGEHRVSX/osqYgJZtxFe2ONlamlp96pOO/8T+jyF73g4p1UETyEDkz
76jdU77aP2V8J0+pQrBH+F8B/uNubGDXAV3ur3wuJvH/27fNDivQkFpG4yc7o07r
GwBU4viaLYfTws+kLtGucgEsg551ZAXVwymraac6bMmeZW/oFgo1U/PRTlNvevio
LRIDyg+jer2CJ4ajB9RO56lU+IEpCq+fhh9Q70Vf2CPVAZMOPpdf1flSURO1yFrc
dW0nZ6tmH/AguGTc8Cnx3X1/9uJOuBEycC1z6d0ZuZjHvf7cgbxnLFMaX93eFS5y
l1hQiDTG2GFfRIJPs0490vOuQ227hpKgofv8KyPolth7mpaSTcNGui8CvrPymJrv
DLggcgUI3QMnRqeWkZulfdduIhNUZNbl0JnHpBF8jo4VBrVXMvrkIZpMjB2w5Px8
v2SRWvzeqgT/hg6M/AxjYhLBESEFOic9PlmQX9G6C74Ee1qumX482vV6+0GnA+8j
vJG3p+OKe0bgII8D6pxcAEW7ZTQinkYOCV3nI1qqueZyInwfJKub+iMKKB9IuwFG
mhKXJJTp1y5ctR6ljC6T
=WiwD
-----END PGP SIGNATURE-----

--Y/W7LeEItOXj90cO--


--===============4271437288377211243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4271437288377211243==--
