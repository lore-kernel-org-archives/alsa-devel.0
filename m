From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ALSA: compress_core: Ensure device is
 stopped when stream closed
Date: Fri, 26 Apr 2013 14:48:51 +0100
Message-ID: <20130426134850.GX5019@opensource.wolfsonmicro.com>
References: <20130426134706.GA27501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3868378131150802243=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8DEC260816
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2013 15:48:52 +0200 (CEST)
In-Reply-To: <20130426134706.GA27501@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--===============3868378131150802243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HBXo5IaYAxUG7vuS"
Content-Disposition: inline


--HBXo5IaYAxUG7vuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2013 at 02:47:06PM +0100, Richard Fitzgerald wrote:

> +	if ((data->stream.runtime->state == SNDRV_PCM_STATE_RUNNING) ||
> +	    (data->stream.runtime->state == SNDRV_PCM_STATE_PAUSED))
> +		data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
> +

A switch statement would be more idiomatic for this sort of thing.

--HBXo5IaYAxUG7vuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReoW7AAoJELSic+t+oim9GZAP/0PvKz8sbc84P6Gr29kpQ/lO
u7/D7ZxNiAfAwLOvhfMLusQhWKOkHkze0bN4SCDbpT37F9h/E9p8A1JrT0uliLlM
UKMBdwZTqA5MIHxj93L/ImEpoxLoZdsoSiOimyDGZtFdnC5U0bZkCGkoCUwOU4EC
YU3MGT8aMPLArDW8Fu4K26FYXdHodQ80nNHjHvLSwS+S3jgmJYoNmb3Ejw8nZeXM
kLXlGnj7qErKws35YlgqMW9e2ZSHv44BrkGjECnTuWYQpHng20wLR0gW0jKdpaBl
cX5KyPh1Db3x6UUmbqcmx9ARya3G4Bq6fwF4U+YsanrC0cKeJxkXZrmYLG9SLkpP
okQYAPU/9hMtZ8OJoDAg8RQ09DbporLbEp+aZKDoHHBTrS2g87Qy12ydpUwabeim
qT+be/6swBQ12skLN2QJv0yuRAxv4Is7M1zUreC+X4oY2MGaC5izmH0DKIgD6re9
W6Oj3aanNsnc4J9t8QbJxcs5Q7qHb+pGoIufCMq8oqallO3vb92Fy47d7pyfj5DT
0Jh8mzOBvR8x2ZDSHjRQhqMCQzrxGLARXEkvNUcP/37s08X1OSZR2MWgr6xs2RB4
qUYh2ktPftdLd3RsKjws7ZFfHrrPiQic72VasBPcSk8AcdQ3fw8nOoQqwm8o0Cf3
zsm94lZphUHdebv64L26
=EgcL
-----END PGP SIGNATURE-----

--HBXo5IaYAxUG7vuS--

--===============3868378131150802243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3868378131150802243==--
