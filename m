From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/8] ASoC: wm_adsp: Add support for
 opening a compressed stream
Date: Wed, 23 Dec 2015 00:14:56 +0000
Message-ID: <20151223001456.GH16023@sirena.org.uk>
References: <1450178989-8749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1450178989-8749-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0927718644262167352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC5A32668C5
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:15:05 +0100 (CET)
In-Reply-To: <1450178989-8749-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============0927718644262167352==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Content-Disposition: inline


--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 11:29:45AM +0000, Charles Keepax wrote:

> +int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
> +{
> +	struct wm_adsp_compr *compr;
> +	int ret = 0;
> +
> +	mutex_lock(&dsp->pwr_lock);
> +
> +	if (wm_adsp_fw[dsp->fw].num_caps == 0) {
> +		adsp_err(dsp, "Firmware does not support compressed API\n");
> +		ret = -ENXIO;
> +		goto out;
> +	}
> +
> +	if (wm_adsp_fw[dsp->fw].compr_direction != stream->direction) {
> +		adsp_err(dsp, "Firmware does not support stream direction\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	compr = kzalloc(sizeof(*compr), GFP_KERNEL);

You're doing this under lock but not checking for an attempt to allocate
on a DSP already in use.

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeed/AAoJECTWi3JdVIfQNSwH+wScJKL9MyTTsRegxIQv59wr
1BV8nW6hMPorawwz8ADvpuz3YlA+kjuR6GSWBv1KOwTBoYI/lNLNU3TptMGUOkfJ
EGPcOpgdb/Ax4K2c0Pbi4PHNCc+h96lNsKIsIm4lrJ6DoWt0ukOSKWo9hsqYGTWH
zxKbhioJVrGoDrIv+wprFFlKU6321taSvaeAjN05f//Q23VI4a0OqmSxsTamlJGw
i+7iQWtF4fhaQXJqfEUd6KU0Tz+Spc0OmAGpsk0yxvKEz+w8TfGgwc6eQEoFlLu1
1Snzs5sMK4jQqNbRN0Bbf+w7igUpUhsUoNXqZrpl37fF4dT53s51CE7CZvqBjhg=
=+f2G
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--

--===============0927718644262167352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0927718644262167352==--
