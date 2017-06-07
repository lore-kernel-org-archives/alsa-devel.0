From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Add new widget type for
 constructing DAPM graphs on DSPs.
Date: Wed, 7 Jun 2017 20:23:04 +0100
Message-ID: <20170607192304.thekfsvzy7mc7lgl@sirena.org.uk>
References: <1496760282-6147-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6979492515563921113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48C68266AF1
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 21:23:14 +0200 (CEST)
In-Reply-To: <1496760282-6147-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6979492515563921113==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="22kqnctaqq2bh5py"
Content-Disposition: inline


--22kqnctaqq2bh5py
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2017 at 03:44:42PM +0100, Liam Girdwood wrote:

> +	snd_soc_dapm_buffer,		/* DSP/CODEC internal buffer */
> +	snd_soc_dapm_pipeline,		/* DSP/CODEC internal pipeline */
> +	snd_soc_dapm_effect,		/* DSP/CODEC effect component */

What's the difference between a buffer and a pipeline, or between a
pipeline and an effect?  We should have clear documentation, if they're
different we're probably going to end up using them differently in the
core at some point and if people use the wrong widget type it might end
up breaking things.

> +	snd_soc_dapm_codec,		/* FW/SW coder/decoder component */

Can we call this a fmt_conv or something?  CODEC is unfortunately a bit
overloaded.

--22kqnctaqq2bh5py
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk4UpcACgkQJNaLcl1U
h9DYEwf/QWbe4cwLffr6bZ3E9MW1SKjF0f7MqxFhddFGODxvDmF0KVvtwy5jpsmn
/rfF3Yom4jHMGJSVWl47PbQ46TuZTK5lSo+6vLQVzB/E3oOCs6Yq6sNyxWIt6Ewn
hpT/zt1EFzgKLBsPni0lj3gMqJn41Jsm3s9vPN38c6O3MWyP232+WG5HDoYKoNja
KgWsvXj/HFyzv8Ds059zfdPnZgsLwba4tg8mazhNAmH2c+474OqVXo+TlZfUyuQV
LosiLVN/65EZh56Z6yjYQmYz7xxprEOMFGsVUf/2Ll+07hQeqyq+QrZSWGKsgrDy
4VBGqgox+Z4P9olhfjDtxQEwpiJWVQ==
=+jyg
-----END PGP SIGNATURE-----

--22kqnctaqq2bh5py--

--===============6979492515563921113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6979492515563921113==--
