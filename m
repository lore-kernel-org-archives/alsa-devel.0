From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: topology: fix get control data
 return type and arguments
Date: Wed, 21 Aug 2019 13:59:56 +0100
Message-ID: <20190821125956.GJ5128@sirena.co.uk>
References: <20190821123252.30920-1-jaska.uimonen@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0282348963489296831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com
 [209.85.128.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3613F800BF
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 14:59:58 +0200 (CEST)
Received: by mail-wm1-f98.google.com with SMTP id f72so2021206wmf.5
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 05:59:58 -0700 (PDT)
In-Reply-To: <20190821123252.30920-1-jaska.uimonen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaska Uimonen <jaska.uimonen@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaska Uimonen <jaska.uimonen@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0282348963489296831==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0FRtVia6Q6lt+M0P"
Content-Disposition: inline


--0FRtVia6Q6lt+M0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 03:32:52PM +0300, Jaska Uimonen wrote:

> +static int sof_get_control_data(struct snd_sof_dev *sdev,
> +				struct snd_soc_dapm_widget *widget,
> +				struct sof_widget_data *wdata,
> +				size_t *size)
>  {
>  	const struct snd_kcontrol_new *kc;
>  	struct soc_mixer_control *sm;
>  	struct soc_bytes_ext *sbe;
>  	struct soc_enum *se;
> -	size_t size = 0;
>  	int i;


> -		size += wdata[i].pdata->size;
> +		/* don't accept 0 size for data */
> +		if (!wdata[i].pdata->size)
> +			return -EINVAL;

This should really be a separate change.

> +
> +		*size += wdata[i].pdata->size;

We appear to be requiring that the size passed in is zero initialized
which is a bit unusual and seems likely to break even if it happens to
work right now.

--0FRtVia6Q6lt+M0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dQEsACgkQJNaLcl1U
h9B1GQf+Oiobkwncu2CQ4291dJFDKKCFU4KkgiY5kGuBhPPiTVrIA0nS4HrOqYgV
8jRQzjcPgW5ie4adzXjFIqJZBYpfQd9S+v5TjHiYN13XpoYaO0ykr0BeSXFSXcKu
dz78s1vupShO0ZdkGMev4DkKDTos3exppu66mXUM9Mx+9yAfEfPCWZGchhFbzM9o
eHEuvO5Di1e/8DXi6X37OsCx+idd0Et4ryd9vlDCsjvx5BpP7dJpqBkhQUUj3W+z
rxWYN8URKz8OAbmt7Uuz8NLGunx6JVVbBMnFE89pRKIXVQnhE07iEjO0SyuO80ac
WPX7VdTMDD5krV3O3Fc4i4nb/nzwBA==
=DdyM
-----END PGP SIGNATURE-----

--0FRtVia6Q6lt+M0P--

--===============0282348963489296831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0282348963489296831==--
