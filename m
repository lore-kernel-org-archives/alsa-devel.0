From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/14] ALSA: pcm: Suspend streams globally
 via device type PM ops
Date: Mon, 28 Jan 2019 18:11:37 +0000
Message-ID: <20190128181137.GG11699@sirena.org.uk>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4637373550243705873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 02D57266A89
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:11:42 +0100 (CET)
In-Reply-To: <20190115162155.6308-2-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============4637373550243705873==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 05:21:42PM +0100, Takashi Iwai wrote:
> Until now we rely on each driver calling snd_pcm_suspend*() explicitly
> at its own PM handling.  However, this can be done far more easily by
> setting the PM ops to each actual snd_pcm device object.

Acked-by: Mark Brown <broonie@kernel.org>

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxPRdgACgkQJNaLcl1U
h9Dymwf9GZGJkUKZ8DWqheEbpprlIafqWbQyT9UIa33QMNlP9IcmvIJZfEKhiw7S
aSr5N+dFdXb6RaIrfA5wOu3c396W43bc6eYeuKex6r020qGaXURKD1pQudcvdxG9
/gDxUcLJRtnNyxg7dg6k3PDMcTHZNQ2IAQMP9DEpCi8dUlvfoSYwJvD+ERqLupgN
had6GXcI5cnkiCoDMXaNfwKG7JugpzBJftzfpcrG6q9PoeNn5mF8sddbesi/JwYD
UO7KLhsRbdDVkZRcLDCNtNBepsH26cw8G+yRYDws84kcBxlkxoQAASm9X7QpmMn3
qen9Upm7hTfbWlocfqpO/MZn9mYvNQ==
=+9+q
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--

--===============4637373550243705873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4637373550243705873==--
