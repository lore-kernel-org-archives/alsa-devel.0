From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/7] Documentation: DT: update atmel SSC
 with DMA binding
Date: Tue, 9 Jul 2013 16:05:43 +0100
Message-ID: <20130709150543.GE27646@sirena.org.uk>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-4-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2115762173461622414=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F66261ADB
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 17:06:09 +0200 (CEST)
In-Reply-To: <1373379933-32749-4-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2115762173461622414==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3R3nSPuqRo8A3eCW"
Content-Disposition: inline


--3R3nSPuqRo8A3eCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2013 at 04:25:29PM +0200, Richard Genoud wrote:

>  - reg: Should contain SSC registers location and length
>  - interrupts: Should contain SSC interrupt
> +For dma transfer:
> +- dmas: DMA specifier, consisting of a phandle to DMA controller node,
> +  the memory interface and SSC DMA channel ID (for tx and rx).
> +  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
> +- dma-names: Must be "tx", "rx".

This is added as a required property so...

> -Example:
> +Examples:
>  ssc0: ssc@fffbc000 {
>  	compatible = "atmel,at91rm9200-ssc";
>  	reg = <0xfffbc000 0x4000>;
>  	interrupts = <14 4 5>;
>  };

...this first example is now invalid and should probably just be being
extended with the new required properties.

--3R3nSPuqRo8A3eCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3CbEAAoJELSic+t+oim9I8QP/Rph4kKN+VjQ2oWGKdLxLPWn
FBljuJNaDg7AAXYwrDEy2aYIlyMEIarnFONQNGV8W83r0p3BzLoujAddzS0l62a1
KHZkK+hipI8Q7JsqR7j+OZBTNSkScdEAozAO39XiWfUvmIiibgZzHhSql9l4Z1ne
8B95mRN9SVVtNeVIrnM2kT7XC66bfDfOmedAgduqB5YWMMzUqj/8CNcy5EW6fMPk
EXvfe9gw5zaGZUcPDFEgnjOeAxoYptcURlH9muvDRe5gR5yaGYDVwijY4h7P12p+
lHUIBmMHeKPwlX6Hd7plTacRAS9+P2YdI12le4CjQ4c21Z+OgA8jM2kXns20lXA0
rnJQIByLqTCKfViF3Dh4UaCjA4O8Ew+tAUD47Ow3yiDoMh0hJCE739rNME2UDu4D
ktHmIa5Mpgun/euMzyYKiOdc2QM+Vla8Lm0NmLJXTP6wUipUEmC2c1y4zVgvEh1J
LrZysRULCcTgYlJt6h9PO3VnnBCD+JMxLcWNjHTXh2EEf+DFhgCMwmIJf7pVDzas
ttE2T6dMCdlsR6Y8t0TDj+3vBqbk1GKGvvQdpcZ3jmoA6VsZ4rs9xwA+kwwlYLoZ
aw46RhNkph7MAedRCD20v9F0B8YQWjK8TGxckDp6janVxJHWqnCtHDaDd9z9Lg8J
lz5uh/ucPD76kk/5QDea
=jWF0
-----END PGP SIGNATURE-----

--3R3nSPuqRo8A3eCW--

--===============2115762173461622414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2115762173461622414==--
