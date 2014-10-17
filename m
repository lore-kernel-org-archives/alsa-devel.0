From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 3/7] ASoC: Intel: sst - add pcm ops
	handling
Date: Fri, 17 Oct 2014 14:07:10 +0200
Message-ID: <20141017120710.GG1820@sirena.org.uk>
References: <1413469819-18775-1-git-send-email-vinod.koul@intel.com>
 <1413469819-18775-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687476701591763585=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9939260665
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 14:07:20 +0200 (CEST)
In-Reply-To: <1413469819-18775-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0687476701591763585==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2014 at 08:00:15PM +0530, Vinod Koul wrote:

> +int free_stream_context(struct intel_sst_drv *ctx, unsigned int str_id)
> +{
> +	struct stream_info *stream;
> +	int ret = 0;
> +
> +	stream = get_stream_info(ctx, str_id);
> +	if (stream) {
> +		/* str_id is valid, so stream is alloacted */
> +		ret = sst_free_stream(ctx, str_id);
> +		if (ret)
> +			sst_clean_stream(&ctx->streams[str_id]);
> +		return ret;
> +	}
> +	return ret;
> +}

I keep on asking for this to print an error on double frees.

> +/*
> + * sst_get_sfreq - this function returns the frequency of the stream
> + *
> + * @str_param : stream params
> + */
> +int sst_get_num_channel(struct snd_sst_params *str_param)

Cut'n'paste error in the kerneldoc.

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQQZtAAoJECTWi3JdVIfQ4aYH/2mZlRnmjTttGWiQWc2VDu6q
9zi75trRmeYHeYSlkTixw7euscFQSEqyn/jTQnLvOdzdCrgamF4MFHqfPSD37v/V
0x8TglzNE6lSYuFQGClQjkJDRTV07okwC41Djg0Kn+o56AQLrIwX3mJLGIzHl/wS
rKlR8HvljWmWQvpgxa2RqRhiS88hqgpglxH0Sgzbr8SEIlq3zbeO3IBXI5sFEoXN
HCuZkiMkQtJlm5dMdOJt7bYombD6MbvMJNHsZ8xCiI+NIlwuVkZgwffT2tb3AJNa
umIgrPvBx+feN48Vld/CfnVcDyXh230sst4P3mCGvyPpQ9Jz0Kg9u1z2BfM2n44=
=9Rbc
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--

--===============0687476701591763585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0687476701591763585==--
