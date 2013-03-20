From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: soc-compress: Cancel delayed
 power down if needed
Date: Wed, 20 Mar 2013 11:25:44 +0100
Message-ID: <20130320102544.GK28775@opensource.wolfsonmicro.com>
References: <1359128299-17161-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130126085234.GB30594@opensource.wolfsonmicro.com>
 <20130308165252.GA22868@opensource.wolfsonmicro.com>
 <20130311092526.GA2141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1744859974446328478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B2532616E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 11:25:47 +0100 (CET)
In-Reply-To: <20130311092526.GA2141@opensource.wolfsonmicro.com>
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
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1744859974446328478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2013 at 09:25:26AM +0000, Charles Keepax wrote:

Sorry about the delay here, I had been waiting for review from Vinod.

>  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
> @@ -220,6 +221,10 @@ static int soc_compr_set_params(struct snd_compr_str=
eam *cstream,
>  			goto out;
>  	}
> =20
> +	/* cancel any delayed stream shutdown that is pending */
> +	rtd->pop_wait =3D 0;
> +	cancel_delayed_work_sync(&rtd->delayed_work);
> +

The work here uses the pcm mutex but the cancel is done with the mutex
held.  We need to either cancel outside the lock or just ensure that the
work doesn't do anything if we have run (which it looks like the
pop_wait flag actually does so we could probably just use a non-sync
cancel).

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSY6bAAoJELSic+t+oim9+bwP/ianKJoOYZz1NAeSqAl1qVid
10e2OWREHBGq8aVsWK4s0YmU4PbnHdJL3kzpB6NNirYGONv/5Ckx4inM10cIwWsB
S0bsfViDHkpXVIH0BcdlFR/dWLwX2G3Aky6QWS9aZl/KOTTlemekCnTIOLqZ4gFc
iYuLbsE1bMoYFxlxlouHQrSWDsyekueSd4IZTbePyLK2nKzo+ZxD2DecQUOSlNKF
wXH6WBrCz0mj0fLrrg6ef9lnHWP715zJ1DrdsnrXRnP7qYO52ZcQ96tHpjjYcqyH
4m0pP8nCGKuO7/UhH7Z/gb3Egk8kMo3P7Eim5Enpym2xhukmbTbi8NwrZMlrQ7Pn
XNdtGNe/k0SZwXT59F26MJ3YMa25U/ygPLH0BSU1URD+0ovpTe+7gYpsC+PTECDo
jPPXHMpZ7idO9k9FnbXwFE8WyL5qCBg0gvTO/vq34ZcZzMzB6hyXB2jwAyHxcN0u
hKd6PIS8RlYScsOH1TfZ8H0i+MrwlysP+ZjK+MxDxFuqiqFQQerI0oMKUN1pDVB/
q+EsUCfObj9+nwbn8m8x2glBEvaEkuCjJENEd8LFjgvDLaSYAMKgFY9pNClsUKZ5
Z70mVrafVIDdyYVpUOgpcW2dTqmKqOCgzDduNuPvFaooWYvRuoh+6bSl+lKdQHwG
quHo48nCtjS2DRYMNRh8
=EG6E
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--

--===============1744859974446328478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1744859974446328478==--
