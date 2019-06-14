From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] sound: SoC: sof: no need to check
 return value of debugfs_create functions
Date: Fri, 14 Jun 2019 16:14:10 +0100
Message-ID: <20190614151410.GC5316@sirena.org.uk>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4730397191691594013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E762DF80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 17:14:12 +0200 (CEST)
In-Reply-To: <20190614094756.2965-1-gregkh@linuxfoundation.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4730397191691594013==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X2rN3GNvz+yeh2G1"
Content-Disposition: inline


--X2rN3GNvz+yeh2G1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 11:47:52AM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

> +++ b/sound/soc/sof/debug.c
> @@ -77,8 +77,7 @@ static ssize_t sof_dfsentry_read(struct file *file, cha=
r __user *buffer,
>  		if (!pm_runtime_active(sdev->dev) &&
>  		    dfse->access_type =3D=3D SOF_DEBUGFS_ACCESS_D0_ONLY) {
>  			dev_err(sdev->dev,
> -				"error: debugfs entry %s cannot be read in DSP D3\n",
> -				dfse->dfsentry->d_name.name);
> +				"error: debugfs entry cannot be read in DSP D3\n");
>  			kfree(buf);
>  			return -EINVAL;
>  		}

This appears to be an unrelated change with no description in the
changelog, please split it out into a separate change with a description
of the change.

> @@ -119,13 +119,8 @@ static int trace_debugfs_create(struct snd_sof_dev *=
sdev)
>  	dfse->size =3D sdev->dmatb.bytes;
>  	dfse->sdev =3D sdev;
> =20
> -	dfse->dfsentry =3D debugfs_create_file("trace", 0444, sdev->debugfs_roo=
t,
> -					     dfse, &sof_dfs_trace_fops);
> -	if (!dfse->dfsentry) {
> -		/* can't rely on debugfs, only log error and keep going */
> -		dev_err(sdev->dev,
> -			"error: cannot create debugfs entry for trace\n");
> -	}
> +	debugfs_create_file("trace", 0444, sdev->debugfs_root, dfse,
> +			    &sof_dfs_trace_fops);

I might be missing something but I can't see any error logging in
debugfs_create_file() so this isn't equivalent (though the current code
is broken, it should be using IS_ERR()).  Logging creation failures is
helpful to developers trying to figure out what happened to the trace
files they're trying to use.

--X2rN3GNvz+yeh2G1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0DucEACgkQJNaLcl1U
h9DcBQf/cyYj2+c9ec3uIgJuzwlTiySLaLJ3B3BoYXLPiBoyLbFpUZewrTZXw8j2
xSfZojAs5C7rYKGcIDiBFTXc5LTw6zlgbToEP6OZA/aw893qvNe6s121pYqTaTye
oXslK1jY2ZY+zAKqURXhJr/3MHNJE62KRCMn/H4zq6LJOafKadUkhHXDyDGMtSW+
g3m0UDGtB2YV/tOqKlqpKNl6Rt+ahd++mTcI2ScUoc7T1TuwnJ/xksi5Xrj7allK
i3oNLWHUJtLXYCNwufg5HEkDVss/BjIbbp283/MJxlMppUpASuuLPnOFC2MB07/S
65eKGsCgztc70KuWeGXkjkinf/9BdQ==
=jNCo
-----END PGP SIGNATURE-----

--X2rN3GNvz+yeh2G1--

--===============4730397191691594013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4730397191691594013==--
