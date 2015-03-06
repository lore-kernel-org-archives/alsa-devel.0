From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: correct the OR to AND
Date: Fri, 6 Mar 2015 20:17:18 +0000
Message-ID: <20150306201718.GB21293@sirena.org.uk>
References: <1425012746-11355-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3151127177645526136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22A50265E20
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:17:24 +0100 (CET)
In-Reply-To: <1425012746-11355-1-git-send-email-yang.jie@intel.com>
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


--===============3151127177645526136==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S64v5H58h9sAxEJk"
Content-Disposition: inline


--S64v5H58h9sAxEJk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 27, 2015 at 12:52:26PM +0800, Jie Yang wrote:
> Here it should be AND(&) to check the status.

applied, thanks.

--S64v5H58h9sAxEJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gtNAAoJECTWi3JdVIfQJ8oH/1uoh6xhLB+L1gaiHXNF2+bM
IdzaXjCC4jsCEpz+lQk+Rm6c1D8L3V4E3Tzbo0NIYUHwQMZ7vU2exPSDi2Er1296
e2fnw6ZzTCi03kwbXmeE9MJR/xnX5dbH/tyQI7Pbfmd8+de8XVGq3KOsJBn34DHP
24RavKw8EvJYq7h8LIUDLkBEQjQRSuMzAlOwEOThJaxLFJHHfADd4oLT/Y+c7K3k
lYeIl3no6o/EmT8MEAIlv3uN25yC+1uzM8iayvHVrn0CB+lJFP5pYebhao8mwazp
YAsPSFGZz0elDK8na4DIcGl9Nml2W7UCI6r4JHo0f8wI8asY1QccJ9Lo7mC2wFo=
=Bbxu
-----END PGP SIGNATURE-----

--S64v5H58h9sAxEJk--

--===============3151127177645526136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3151127177645526136==--
