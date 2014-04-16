From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] of: add empty of_find_node_by_path() for
	!OF
Date: Wed, 16 Apr 2014 15:25:02 +0100
Message-ID: <20140416142502.GR12304@sirena.org.uk>
References: <1397630960-26677-1-git-send-email-shc_work@mail.ru>
 <CAL_Jsq+MtkQcKs06xggrZkQHncSCBx6ABCaiud8HokEgAX2NMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0941287116966526628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E8F6B26533D
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 16:25:20 +0200 (CEST)
In-Reply-To: <CAL_Jsq+MtkQcKs06xggrZkQHncSCBx6ABCaiud8HokEgAX2NMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robherring2@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-ALSA <alsa-devel@alsa-project.org>, Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0941287116966526628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Og4V1LL7XI16KR+9"
Content-Disposition: inline


--Og4V1LL7XI16KR+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 16, 2014 at 07:26:13AM -0500, Rob Herring wrote:
> On Wed, Apr 16, 2014 at 1:49 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> > Add an empty version of of_find_node_by_path().
> > This fixes following build error for asoc tree:
> > sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
> > sound/soc/fsl/fsl_ssi.c:1471:2: error: implicit declaration of function 'of_find_node_by_path' [-Werror=implicit-function-declaration]
> >   sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);

> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

> Applied.

Is there a branch I can pull into ASoC, or can I apply it there?  This
fixes a build failure introduced into there by some recent work.

--Og4V1LL7XI16KR+9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTpK7AAoJELSic+t+oim97AQP/jc8LMDOZjmqGtkXeDHfTh++
SPnjdkvQTJjnrUXraxW5pGOWZM4M7PIDe7Wffl+0b8xgpppgtt0eL27qDLqtZmpu
IMCOihxuNlsUOrV3W5IxpIfROqhRpiA8sLgoTxIbzZQnAfH2AZQRimRDWony9lJ+
PFfu0jc/c7MxFHWknFMRwNlNzdpXxzM/f2qI4nRNDXmzqVuK48uIUHfD5d4pimCm
9Q3fTY4Ip3IqJrE8yhvwcTwOx7FxQGcVfxYP2yk3nD4RHlFZdOkfOYAV9CZeEC0j
/tvM7KDAxCqy5QVN3KpiXNPxDHSsJrhVW3b4nTUm1Kph79iTKNOD+sdBKOyJCOwA
KhL6mC8Qi4T6RtbvosaYDZEGHcGnykTytZtA+BqMkFCyIFGKPE4HbWG4nqgJ/lbN
BpeFJCRBldNDIVY9ZfHCOJUO3cgPpFy1h2ZMTIyRUmrFJTLYQpkQLqMqf6WlSjVR
dcTYKqAaSscjb6fcOueSwfPByx69fKHEVp1jgBz54oH0NTXC6Hf7Rs5N9DWy1/bQ
66/Ke1GxcF22r0z8OZ5lY3F24wVMBcrxcuej+kP2Wc1iA4jl/vY+roITK/JnSScS
zCQJJCVcMleQ575B4YQUv0IfUNi9stn1pR4Zf4+fRSzOELQ72IWNtXJAWyUw130/
sAMcwRWRdbtLLpyfHHs1
=2JN/
-----END PGP SIGNATURE-----

--Og4V1LL7XI16KR+9--

--===============0941287116966526628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0941287116966526628==--
