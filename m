From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Cancel hsw_notification_work
 before freeing the stream
Date: Thu, 24 Apr 2014 11:32:35 +0100
Message-ID: <20140424103235.GK12304@sirena.org.uk>
References: <1398324876-901-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0700783368576917036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C61A0261B2D
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 12:32:48 +0200 (CEST)
In-Reply-To: <1398324876-901-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Wenkai Du <wenkai.du@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Derek Basehore <dbasehore@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0700783368576917036==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EsUqgJ2q7deBNL+f"
Content-Disposition: inline


--EsUqgJ2q7deBNL+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 10:34:36AM +0300, Jarkko Nikula wrote:
> I suppose there is a possibility that hsw_notification_work() may run after
> sst_hsw_stream_free() which can lead to a kernel crash since struct
> sst_hsw_stream is freed at that point and
> stream = container_of(work, struct sst_hsw_stream, notify_work) is not valid
> when hsw_notification_work() is run.

Applied, thanks.

--EsUqgJ2q7deBNL+f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWOhAAAoJELSic+t+oim9NwkP/AtTbgn3uWswtKWkR16UEJcP
nAlZKA5o2OuWkYnGCEfyBdIS5QZVRUL8EAqWQpYRLYmh2jLR+Y922RCMvtoSZYIq
Wy4uA7CkGtru9KAbwcdD0jhPGkuhYHPEcFnaa6D/bE9jWsIgxAUcUQNs9Q78RRYh
O8CZeIZfuVN/AHgJtwlxaxgzewPJ7ygzruGDkbqHgn4cgeLvuwjx56fhZjWLzAwy
u985RrD8uMHWvCvqINVyiT5pglbBdZH81/dQtcR6XIR+ZYaEUnBCItksl7E8x4m/
iWDXPTcjakFwc+ImXoZRNP89HkpG3lSyR6P9H7qPYjfbOnGLPeswqBwyaui6FeRS
qSRgOhZ7z5hVLX79AVmB03LinNl+sLo9hH15sf+j1b8re46h9O7X3eOFK2EagKRo
nIUsgon0y/C0WeKK5No/i6+MHAyyPVeMxQEt1EfdKzeMZlRsV9pKsETPGiW3aMEM
YrSMHJeR2zOWG/hkGypf8OJLCEDg+MfQbc2vXiqKaeTk6JP5X//e4IelFpqvkmK0
8eFTa6/NyjqIiuD17Ld6M+/qRDDF66xqjQlXlC3RRMeLHLIMB6CWlI9OmnOInf0l
H4dZBHlJg01u9Jh6ntYaLVCYQBUwa+YsQnU0v7NxlOcbVIw8xAD0T+E2xzn1CfvW
5EXGPwUJSVpPN5ZDiipc
=Ab7m
-----END PGP SIGNATURE-----

--EsUqgJ2q7deBNL+f--

--===============0700783368576917036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0700783368576917036==--
