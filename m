From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: fix the states to check
 for allowing read
Date: Mon, 29 Apr 2013 16:24:22 +0530
Message-ID: <20130429105422.GM24632@intel.com>
References: <1367136322-24531-1-git-send-email-vinod.koul@intel.com>
 <20130429110714.GF5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8484542347987268268=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 59E442619F1
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 13:27:11 +0200 (CEST)
In-Reply-To: <20130429110714.GF5019@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8484542347987268268==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2013 at 12:07:14PM +0100, Mark Brown wrote:
> On Sun, Apr 28, 2013 at 01:35:22PM +0530, Vinod Koul wrote:
> > for reading compressed data, we need to allow when we are paused, drain=
ing or
> > stopped.
>=20
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>=20
> > +	/* read is allowed when stream is running, paused, draining and setup
> > +	 * (yes setup is state which we transistion to after stop, so if user
> > +	 * wants to read data after stop we allow that
> > +	 */
>=20
> but I think there's a ) missing in here!
Yup :( I guess since Takshi applied it he can fixup it at end of para, and I
will owe him a beer next time we meet :)

--
~Vinod

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJRflFeAAoJEHwUBw8lI4NHSgAP/jv5uPiY4/EaFnZFo5bbWjIm
V60Vjvz4yYueIqarYjQAeGwiRMrA9a9nfiWAzKfzd+8hUbYSICqsGQrALW57dH8m
jFUDt1sNwEbJdUheTlV+CnNGyngT1vRVSTuzERMdqc9SZpKai/t6xwtKJpO54BXw
VFC80pp7dkd2d24ApkRTBgqmjjbv4OKFY6emzKyNEwod+rAVpOld629wtjPPglkw
ARmcXvKMaJTk9zuRY0L62ApcVTZGtRKpQoIjKiUwCImU26MkUDot6t1mJIHGFEdJ
XZdYKhZQTuNSImMTAYxXf2vk6GKZEcD8n8j75M/I0Lcpr8e6R8fmUm//dKIoV8j+
uZS75lpJimbg2WQv16w7MsTgHyHIBG+Kj/272WvsXYycShfK2R5s0wMvIgZCoYUo
sYmzptl3XiXtwNbndh85szXobPO7Hn76eJAn8o9/rmd6Ee6w/30qAZCkosWKuGKy
LpNBWh0vxhykA7gwxJXvzBuGwM719mkoD/2K4pUbbN0ohM6RkyAQnI/ezQj8FvMf
oacLBIh5MN7VCRtQDGmf7WZQj4FBbWFzOLY6UbHKBWBL+BnrtQ1K/frzktdzKy13
fKFiMZMk9/CugZgaXu4A8AflZmIecylIXRfhClpFnXft+ywzot7gMh3YJRmaTfxN
3BVuwT+mVw73KUSZpkQZ
=/6tn
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

--===============8484542347987268268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8484542347987268268==--
