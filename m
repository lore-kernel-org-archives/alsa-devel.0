From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Fri, 16 Mar 2012 19:25:16 +0000
Message-ID: <20120316192513.GJ3158@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<CA+7tXijgsT3uitVa-=VLmKY2ubQpgff0hkKjA5jz6QCFp9_PiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3175222112189169870=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24F9A1047AC
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:25:24 +0100 (CET)
In-Reply-To: <CA+7tXijgsT3uitVa-=VLmKY2ubQpgff0hkKjA5jz6QCFp9_PiA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3175222112189169870==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 15, 2012 at 05:28:13PM -0400, Trent Piepho wrote:

> There is a race when the constraints change dynamically.  See the
> fsl_ssi.c driver and the sample size constraint in synchronous mode.

This is just a limitation of the ALSA ABI - there's nothing we can do
about it without changing the userspace interface so we just have to
live with it and error out if an application ever manages to hit the
race and pick something incompatible with other active streams (note
that the symmetric rates support has a dev_warn() complaining about
hitting the race).

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY5OTAAoJEBus8iNuMP3dPbgP/06fbhoA6mykARro2B7UrAx0
/PCRm3Qj3X6pK1QjPrc0V2zeL3YDqSBbVpAv5Nco9O6Udx4wvEb1dv7/kcpmbZQ2
lTaTeWqyrKu8ixOxmvHTSgLbyfMXmtk8rbRRgiOE37S6zYe6kYJkFPpIXIjxLgNA
e/8rtL5Sla+C1lbuu+AMA2Uj6oGZ2JFHnzyVQDLeUtLsuPMgN8dHnqfZnlmEF/gd
Z1LR0V6NiVVUCNpSV5gO79+Ehrr7niFACoAjRA0+rWfSDsW0NqAWksT0iizs72X3
oPrAR5D9V7wgpwAc01oZx+wm+M0gMzaRCB05lnyUd919pJTt91Ej7CKibNd6prVL
6cPvCDb9b8nCJ+K375pUs5Plscm5NxW5HT2SMuUbr4rfKZt5FHP+OeyXWo/AnP3i
cF4q2oI6OBf6FzJo+kb5i1jSfpxEdEp2ZqVW+cS6g4WReUsWpBIkuj7ljwbrXrWt
XSXv6eAhlCSzRlLM/1TsviR6rAR/T7nowupcU/LtMklPaZ7Na8hbuRr0yAHH/rU1
FrQFXCXqm643QPrE+HYjHMbojp5zxAuEGWgthrhzDFW/y2BxCwx/6yqamzceLLbl
pBLfWwWsbYOYRpYkGbI0N8/I/wnio9Byt1rZM+1qDUxeCtw3SIgPUnzQP3YHajs/
u+7q9nVhYSUwrP9EF618
=wKWQ
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--

--===============3175222112189169870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3175222112189169870==--
