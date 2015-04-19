From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add static inline funcs to fix a
	compiling issue
Date: Sun, 19 Apr 2015 13:22:13 +0100
Message-ID: <20150419122213.GI6023@sirena.org.uk>
References: <1429407948-14158-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5113489503551887611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89129261A3B
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2015 14:22:19 +0200 (CEST)
In-Reply-To: <1429407948-14158-1-git-send-email-yang.jie@intel.com>
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


--===============5113489503551887611==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n1Uk1UcYPcMfp5mO"
Content-Disposition: inline


--n1Uk1UcYPcMfp5mO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 19, 2015 at 09:45:48AM +0800, Jie Yang wrote:
> When CONFIG_PM_SLEEP is not selected, calling funcs
> snd_soc_suspend and _resume will generate a compiling
> issue.

Applied, thanks.

--n1Uk1UcYPcMfp5mO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVM530AAoJECTWi3JdVIfQ8cwH/16MqoCFim7n+d3GWgsaefbE
ql87Atn1jdJDTZOsmUTAZGrXeWgCUX0fSnR1hX67zbsmho7byxKI+24aNtPvVctf
68zofQmUlIW22QvmsAGdF5rgHF3VEvM7zwKwv4fhqvW5/eKPxUG2MpM90cacUCgq
PR/LXloNz2MTj0W5uNeY4BkzfNLjgfYO9K/1EbaCpDYepVWW9fyPuKHR3iQritcs
gycN0fJsj+RNsJVedLsnicA73yVgxCAB7j7VWR2sGxc1JcZdXFv3hxwNn3fQzdZm
72/GpJHcSRBUbp5cM9pZveXvBuNWa59vdvU10yf1Ho2vvFI54b8sT3LqpKku0uk=
=FsDb
-----END PGP SIGNATURE-----

--n1Uk1UcYPcMfp5mO--

--===============5113489503551887611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5113489503551887611==--
