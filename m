From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Add stream direction for
	pcm-module map
Date: Thu, 8 Jan 2015 18:33:28 +0000
Message-ID: <20150108183328.GW2634@sirena.org.uk>
References: <1420698741-26016-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4785462568355332403=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7BB260498
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 19:33:32 +0100 (CET)
In-Reply-To: <1420698741-26016-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4785462568355332403==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="axJNYNH3XkMq26GG"
Content-Disposition: inline


--axJNYNH3XkMq26GG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 02:32:20PM +0800, Jie Yang wrote:
> A DAI may have 2 streams(playback/capture) and different modules
> may be needed for them respectively, so we need add a stream
> direction here, the combination(dai_id + stream) can tell us
> which module we really need here.

This doesn't seem to apply against current code, can you please check
and resend?

--axJNYNH3XkMq26GG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrs13AAoJECTWi3JdVIfQ4xYH/3obAIQl3Xz7VTdqtOmGpyYN
gXnwcWGcjybOQZPl6qGpE5CnQbYl4FB3bPG0uHbGLRGqUyP0uJsNufdUik9ed+Ty
BlJPU0X5y3xz+NQCJQkD2UDewA+Oi7xRbno6nRfmP9G5gUddEMLk0AFMxzcNSZD1
Bb2j72e9SLJjmLYT+rYILg022MZjeSmWdpWBcuYbtRECMTNrYLKE3Jvc/Nwxg6NG
LnnfapXx3EN4c6tMyfEt2APfYwDC72K6A07U1I8aWyIXtsNt1OvcfQb4/4/fDOuv
gHUMqScCyGWJOPwMU/V0l4NqHc7Y5dBi7fJ2psU3c4yHDuFUGFB44M9twDqGZUE=
=aTW8
-----END PGP SIGNATURE-----

--axJNYNH3XkMq26GG--

--===============4785462568355332403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4785462568355332403==--
