From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 06/12] ASoC: SOF: Add support for
	loading topologies
Date: Mon, 3 Sep 2018 17:19:11 +0100
Message-ID: <20180903161911.GR10302@sirena.org.uk>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-7-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5527103719484329348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC7F52673F4
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 18:19:12 +0200 (CEST)
In-Reply-To: <20180831151910.16122-7-liam.r.girdwood@linux.intel.com>
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


--===============5527103719484329348==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eyYj78xbwv+yMvU1"
Content-Disposition: inline


--eyYj78xbwv+yMvU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 04:19:04PM +0100, Liam Girdwood wrote:

> +static int sof_widget_load(struct snd_soc_component *scomp, int index,
> +			   struct snd_soc_dapm_widget *w,
> +			   struct snd_soc_tplg_dapm_widget *tw)
> +{
> +	/* nothing todo atm */
> +	return 0;
> +}

> +static int sof_link_unload(struct snd_soc_component *scomp,
> +			   struct snd_soc_dobj *dobj)
> +{
> +	return 0;
> +}

Missing implementation here as well?  If these functions can sensibly be
optional shouldn't the framework support that?

> +static int sof_route_unload(struct snd_soc_component *scomp,
> +			    struct snd_soc_dobj *dobj)
> +{
> +	/* TODO: unload routes when topology is changed */
> +	return 0;
> +}

This seems like it should at least return an error.

--eyYj78xbwv+yMvU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNXv4ACgkQJNaLcl1U
h9DKyggAgo3j03d5mrmcabSnmhz5EsEI16V5OW+ooOkX20j9sslcwcWNWA4QY1d7
M+eCph6g2BLjQzI6DD+VnwhPxLdcpng1KDFT/t3bGYvyYUn/PewBYnicHgrxKOCv
PzIaBK1aY6umImYgK44hj+a9C2UslgrnbNmTEQePuV/Sp2Tkb3xgTge8HwOOuaxn
mpdwroxfOXMQ/FTuA8GGcVe8/sMFtyc1DagmP2bdJfNDm7Bjk3taSQ2E9KdMbhN5
fmJ7otyQ5ktCnJ6GlOQF9AfDqUIyXFNXc0xVdtjHQQgOghExZW29NHpOkkkZm5An
6TIK4kg9KscylUDew7JNSbQIZnJL+w==
=6hyV
-----END PGP SIGNATURE-----

--eyYj78xbwv+yMvU1--

--===============5527103719484329348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5527103719484329348==--
