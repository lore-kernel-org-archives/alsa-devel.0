From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: atmel: enable SSC_PCM_DMA in Kconfig
Date: Tue, 23 Jul 2019 18:18:17 +0100
Message-ID: <20190723171817.GP5365@sirena.org.uk>
References: <cover.1563819483.git.mirq-linux@rere.qmqm.pl>
 <ee65cc7b889b2a8d1139d1d25977842c956d1cf4.1563819483.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8286793214168287420=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ee65cc7b889b2a8d1139d1d25977842c956d1cf4.1563819483.git.mirq-linux@rere.qmqm.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Ludovic Desroches <ludovic.desroches@microchip.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8286793214168287420==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Content-Disposition: inline


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 08:27:20PM +0200, Micha=C5=82 Miros=C5=82aw wrote:

>  config SND_ATMEL_SOC_SSC_DMA
> -	tristate
> +	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"

This breaks the build for me:

ld: sound/soc/atmel/atmel_ssc_dai.o: in function `atmel_ssc_set_audio':
atmel_ssc_dai.c:(.text+0xbd9): undefined reference to `ssc_request'
ld: sound/soc/atmel/atmel_ssc_dai.o: in function `atmel_ssc_put_audio':
atmel_ssc_dai.c:(.text+0xc74): undefined reference to `ssc_free'

It's not selecting the SSC comon code.  It also looks like it'd be
sensible to add a dependency on the platform (or at least architecture),
with a || COMPILE_TEST to help with build coverage.

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03QVgACgkQJNaLcl1U
h9DBZQf+JgxSye18m4nNkKnsgjUuG28GzeGRZgauDTClvkb/W5198CjJg1y7Xxbd
gEMn+eyBP2iwXez0dYeRw0mye4Zbl9VJfhCwN31JslTIlXwpNZxSH1TF/tgYnoXn
hkM3zfs7b5OdVmZKVY5Y7+27JkL105jf5yf7V6oj+8s+hVSmuwZZqodwy0LF+NsM
A0CDfSaTFQuM5NV6FmA4xoqju935Eo7pWauKRhJr4zsSCk5R+R5SbHzNtcBO24Kk
Rcbb+/BoLFdhySnAf1+FhvsNNNiHSTC8PM6sCmDU2sTI8NXj9F6BbP7DFq+NoqsG
qEFuuCbXXLuFYmtHWHII3zEkqcAPHg==
=pVk3
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--


--===============8286793214168287420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8286793214168287420==--
