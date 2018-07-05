From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regmap: slimbus: add support to raw
	read/writes
Date: Thu, 5 Jul 2018 17:50:11 +0100
Message-ID: <20180705165011.GC6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2458820619092973376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F7DA266E76
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 18:50:12 +0200 (CEST)
In-Reply-To: <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2458820619092973376==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 05:13:21PM +0100, Srinivas Kandagatla wrote:

> I think I got it wrong by looking at _regmap_bus_read() implementation which
> calls _regmap_raw_read(), this made me think that read/writes callbacks
> imply raw read/writes. Looks like that is not the case.

They are reads and writes, the thing is that they're reads and writes of
the register map that's also accessible for other operations rather than
something separate.

> All am trying to do is support paged registers, which seems to be only
> possible via read/write support at bus level.

Could you explain what you mean by paged registers?  There's framework
support for what's normally called pages but perhaps this is some
slimbus specific thing?

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+TEIACgkQJNaLcl1U
h9BV6Qf/YNI1I8OaYffK4zwYsjGpMRe4M0LvAW5ZMcqX3WI6v3DgqWeWwuZ2i4Mq
84riJ88XTtfuk0uQUm1GPBf5BIE7FOD7SaNR8QOfgLAZSAgq4sEcGu6fJRYK+97A
2GTylrltzsc/ZDOEsctJKTmdK/h0pF2DWv4zQ2SG9VpFB3HxpjxpYxG+N8x9cv8I
KNEcqJaK8uLBaiNRYRmuVB3HMSW0WO0hQhKOphETNelrGor2Y4HPyqO5q47yeuc9
HcCdu4sUBKYFWqNl3Fb4gtOaLYSlehUH68oL5GBT47+jPCYN4NKzHZdrQQmhDwBW
eT3qzOzZOQFUSffd64wlVZSxf7LF5g==
=bFLm
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

--===============2458820619092973376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2458820619092973376==--
