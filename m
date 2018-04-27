From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: tas6424: Allow disabling auto
 diagnostics for faster power-on
Date: Fri, 27 Apr 2018 16:30:21 +0100
Message-ID: <20180427153021.GE6872@sirena.org.uk>
References: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
 <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6709871785514105668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1F5226728A
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 17:30:33 +0200 (CEST)
In-Reply-To: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6709871785514105668==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2018 at 03:55:49PM +0200, Jean-Jacques Hiblot wrote:

> +static const char * const diags_enum_texts[] = {"OFF", "ON"};
> +static unsigned int diags_enum_values[] = {1, 0};
> +SOC_VALUE_ENUM_SINGLE_DECL(diags_enum, TAS6424_DC_DIAG_CTRL1,
> +			   TAS6424_LDGBYPASS_SHIFT, TAS6424_LDGBYPASS_MASK,
> +			   diags_enum_texts, diags_enum_values);
> +

This just just an on/off switch so it should be represented as a
standard _SINGLE() control with " Switch" at the end of the name so
userspace knows what to do with it.

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrjQg0ACgkQJNaLcl1U
h9B3BQf9G8mc2VxRhn8o5ZTSsYg3S9EJadQ1MvSluxiVPchmaCMOK6ubLlJO1oAQ
DFiElg3t0AZd+8Omo42op3mcadKYH7pskELHvBa65AkT/9ZSW5kSII2AA+FVJxPb
dmjdv36qXEvpUrKsA1jLn8yG5b4TU7dQ962kNg7ONO4IgolrC2u93e7WSJvfB61k
0bsmACPMOwDr+meF/cnG2uF1vXRmoE70uWgvKvemTmbKugRevRVSt9UNj/v6xBQG
o3He3kv1KRO7/n5G+xATph5ZxKc89kAUydV5hG0nTaMPF33BXXKhlOLHCuSM2ump
zCD8ONrDK7J8qXieQjzVBQjg8FvhQA==
=tWnr
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--

--===============6709871785514105668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6709871785514105668==--
