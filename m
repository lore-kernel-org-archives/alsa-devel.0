From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unused cache_only from struct
	snd_soc_codec
Date: Thu, 28 Aug 2014 19:06:07 +0100
Message-ID: <20140828180607.GF29327@sirena.org.uk>
References: <1409224031-9334-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5448663356785899981=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EAAEE26A79D
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 20:06:11 +0200 (CEST)
In-Reply-To: <1409224031-9334-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5448663356785899981==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2014 at 02:07:11PM +0300, Jarkko Nikula wrote:
> There are no real users for cache_only in "struct snd_soc_codec" so remove
> it and needless debugfs node.

Applied, thanks.

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/2+LAAoJELSic+t+oim9tmwP/iPsDVGpMqnE3eatydrX4L8a
39uEgyj5PSl5wwDQ4yJTqGPdMVS0Ku48mlVMWUPMuAMpMdTkaJl/Q64jlxY1TfKK
nkJ6YPnnPqPvrAKVCXiENF5sgE68mGgiZ1UmzPEqflpVycC6+w3njFwv780IIem1
irzDSHWANnbLwyPH8bu2TgwvxypoIdg8FJx0/vfOlPkM9hYonjmEdLS81NGFqtdi
JXFFdLR9SyuMd03FpjzeMOneqfvZHkWRHVbLPS2dutOcige8UF8k0fg6qhiFhODc
Pz6rR+W7hXuHzHtNraYd7vJXwNZiwt6PqBPSenBb2sk3jXaubuBfUayO+uJlDM6O
NveQ/bht3XPXaFi+j3P2+OFiTMTQj2vdJWJhk+rsCEMd0yugVga7+H2vKdfxGY4P
Y00hNLr1fm8uaIFH/xJm+dJhA0agIOClI8RKUju60bi2Nju6aRCQBVvwyOTn8ebC
map+ZFyiH9uv8tws+RTydJHbnsSDAsLUp2q9Q3wd9yUjsJf4FTZ+Ah4HSjj5+mI8
AlxgC3JjNysxMk75jMb+osFNjtRaQ1Ux0LvOtpPD2pjSvduMQndbOOxZAantQj3h
nPrVYQ7QLrLMR3c6IxF9AX9dBr1FWtwTcKkQhq4z5kQM79vGimrlw65fy6LRHJvg
B7cjGx6Nc06YLEfAUDZ1
=D78t
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--

--===============5448663356785899981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5448663356785899981==--
