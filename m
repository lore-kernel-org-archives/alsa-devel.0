From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/13] ASoC: topology: ABI - Define DPCM
 trigger ordering for PCM
Date: Tue, 23 Aug 2016 18:41:35 +0100
Message-ID: <20160823174135.GA22076@sirena.org.uk>
References: <cover.1471599648.git.mengdong.lin@linux.intel.com>
 <24428c2714d09062f3ace5803679c743d36afb04.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7262177619879321641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7D33266EAA
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 19:41:41 +0200 (CEST)
In-Reply-To: <24428c2714d09062f3ace5803679c743d36afb04.1471599648.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7262177619879321641==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W18qbkTAGYos9/y6"
Content-Disposition: inline


--W18qbkTAGYos9/y6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2016 at 06:12:55PM +0800, mengdong.lin@linux.intel.com wrot=
e:

> Definition of dynamic PCM trigger ordering is exposed to uapi asoc.h,
> and topology allows user space to define the trigger ordering for PCM
> (FE links).

This seems *incredibly* implementation specific.  Why wouldn't the
driver for the thing implementing the topology be able to figure out the
ordering here?  What's the use case?  What happens when we change away
=66rom DPCM?

--W18qbkTAGYos9/y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXvIrOAAoJECTWi3JdVIfQVSwH/Rt7KH9rPJxHmoTy8bJ6963d
F6Faw607xTyHNkbh2+wZgkaT+eLiyVhBAqw7rJU66iQwbPUdfWvNfvbPgXYe1twg
DigSAO30N1sIgKK7zvNL3U9zCNi4jfoA3DQ6QdgJ/tPBazFQk5I2la6eXXkk1JVe
+vR0EIs5Fvni+Cyr1vXAL+//yqOQPwASVrNbVvdHwnv4z3kYvLQsK8G17ZXT6B9Y
B9UJ07VYLDsKW8uRcW7YzHZlL3R9I1E8ff/FkTb4qFXYTuTkNdNsvPIb/Asgi8GS
N+GR8t/8wAB/y2WhgSLcHle6VUhDTqxT6q/hi4Wj0BpL67SWDoW0/EeU1F25ItY=
=j1hv
-----END PGP SIGNATURE-----

--W18qbkTAGYos9/y6--

--===============7262177619879321641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7262177619879321641==--
