From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Wed, 16 Sep 2015 17:37:58 +0100
Message-ID: <20150916163758.GJ12027@sirena.org.uk>
References: <cover.1442298607.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8832993922841784183=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3CDD2616EF
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 18:38:08 +0200 (CEST)
In-Reply-To: <cover.1442298607.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com
Cc: bernard.gautier@intel.com, alsa-devel@alsa-project.org, tiwai@suse.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8832993922841784183==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ua9yRDb3E+6+FhiE"
Content-Disposition: inline


--ua9yRDb3E+6+FhiE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2015 at 03:00:16PM +0800, han.lu@intel.com wrote:

> BAT works by playing an audio stream and capturing the same stream
> in either a digital or analog loopback. It then compares the captured
> stream to the original to determine if the testcase passes or fails.

This is really cool, sounds like there's some overlap with the tool
David wrote to verify TLV information?  Actually in that vein one thing
I started looking at but parked until this got posted is something that
goes through and tries to stress test control value settings (trying to
set out of bounds values, make sure all valid settings can be used and
so on).  That's probably better kept as a separate tool I think given
that it doesn't really overlap with audio streaming.

--ua9yRDb3E+6+FhiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+ZriAAoJECTWi3JdVIfQW00H/0CkceoqHcEBWQ4sRXzQ5FT8
pIehaVYwjQOUAu5/1rFNFVLrndi0DkTgJA/37ge7RQju/aXFkg4VbxgfI0gMbR+u
RUkx4WE2P8R/40wPPNKZzKKFQb7b5tWmykaTnkFyGWfB5Zy6x7Wj8oJqZfCdMFAI
ZFWFufWX5ertHnDbTFKIfmSETlIYWK8xeY5kwPrMrpY9FVTNp818mmdzCfoT/WOu
5II3UNnN1fEM0VX2qzqQdksd0MHLC+7H2UevY7AH1rXS33gzTSK9vy+9t1Rz6tP4
TivxEbJGfjcpQ+cNVnGJzeWj/sZUGaLzqgs6cS8met+4S1wC7bVU7s6HRxSvAqk=
=p1Ea
-----END PGP SIGNATURE-----

--ua9yRDb3E+6+FhiE--

--===============8832993922841784183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8832993922841784183==--
