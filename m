From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] topology: ABI: Increase
	SND_SOC_TPLG_NUM_TEXTS to 32
Date: Fri, 20 Jul 2018 13:39:49 +0100
Message-ID: <20180720123949.GH10784@sirena.org.uk>
References: <1532082427-4912-1-git-send-email-puneethx.prabhu@intel.com>
 <1532082427-4912-2-git-send-email-puneethx.prabhu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4088919661535779221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D5E62267749
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 14:39:55 +0200 (CEST)
In-Reply-To: <1532082427-4912-2-git-send-email-puneethx.prabhu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Puneeth Prabhu <puneethx.prabhu@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, pardha.saradhi.kesapragada@intel.com, cezary.rojewski@intel.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, gustaw.lewandowski@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4088919661535779221==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2018 at 03:57:07PM +0530, Puneeth Prabhu wrote:

> index bb8aec7..eb61483 100644
> --- a/include/sound/asoc.h
> +++ b/include/sound/asoc.h
> @@ -84,7 +84,7 @@
>  #define SND_SOC_TPLG_MAGIC		0x41536F43 /* ASoC */
> =20
>  /* string sizes */
> -#define SND_SOC_TPLG_NUM_TEXTS		16
> +#define SND_SOC_TPLG_NUM_TEXTS		32
> =20
>  /* ABI version */
>  #define SND_SOC_TPLG_ABI_VERSION	0x5	/* current version */

Hrm, we should be getting rid of the duplication here - include the UAPI
header in sound/asoc.h rather than duplicating definitions between the
two.  Otherwise someone might modify something in sound/asoc.h and not
realize that the UAPI is affected.

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltR2BQACgkQJNaLcl1U
h9CkTgf+MUCq/wb79AzMjJ72I5Eg2ygjJPzplARBmjheuKdfbJ4ExU+ui38VWFKM
vDpymypKckXYxbbMzdubdpmKBTOmYap45cfYHnkTEy2jwXgL9ZCUf1eWz7LI5dfR
VLeWjjfkmdkZjajjCkjKfUnSvqxHtUdDKZcXlRIu01f5DN0gYgYbPq6r6sudXbJE
E5V7iUb9xXI4vOqlnQUxIqGGtISoI90uRU/NGE/Lfu873DhCFw81gOR+9iF3Srl2
56J8tpu4gvHv0ELWNUaL4QALq1UF6/cvvbqfa9E4h75UWZJmitdGT3VOIhhfAovq
odCteK5VFD6854z28VpKvNv+tu4qAA==
=kf+m
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--

--===============4088919661535779221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4088919661535779221==--
