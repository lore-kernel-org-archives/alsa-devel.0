From: Mark Brown <broonie@kernel.org>
Subject: Re: [DAPM question] DAPM support for single input
	multiple outputs
Date: Mon, 9 Mar 2015 12:20:55 +0000
Message-ID: <20150309122055.GI28806@sirena.org.uk>
References: <54FD5C1D.9030909@marvell.com> <54FD5F9E.3080606@metafoo.de>
 <54FD8102.7020503@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2011587355899077909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 781462605EA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 13:21:03 +0100 (CET)
In-Reply-To: <54FD8102.7020503@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============2011587355899077909==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2u6xDyV6U2OU5E0"
Content-Disposition: inline


--b2u6xDyV6U2OU5E0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2015 at 07:16:18PM +0800, Qiao Zhou wrote:

> I'll have a try to specially handle demux type. Thanks for the suggestions.
> BTW, is there plan to add demux support?

Not really - it's not that there's any reason not to do it, it's just
that nobody is doing the work as far as I know.  It's quite unusual to
see it in hardware (usually you see mixers in the places where you might
see a demux) so few people have the motivation to do the work.

--b2u6xDyV6U2OU5E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/ZAnAAoJECTWi3JdVIfQz+sH+weYFqAF5dmQPpbf+HHRVvU6
jyM7TVB0PY3iE1YBojU+gqsh/TG48uxMfuno48y2pQKnkHEQGchkcgRTqfnqHsIv
oyo/8hDINYvopdRnHKplO6x0+2mZxt4U5zp5QuovQIpRlyPELcpEZy3r+PLWZkvE
WmMYSVeyfTc/ItJ1EfBzFJ1+UCbSeuwOeozRrfhI9bkbCJHV6+2V+f8wpo2WvbR8
9AMmYDotPnZ0N5Vwmk5y0q9EigStfS4AwzNBrF1tL2krzqBrMXDiLvDcyvO/Cyi8
uuTlJk55VBmQcsb+NS7bcw5ukP9PXonK9+Jduv3LDzkHj4X6DTsYxYuMy5IvpRw=
=B5H7
-----END PGP SIGNATURE-----

--b2u6xDyV6U2OU5E0--

--===============2011587355899077909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2011587355899077909==--
