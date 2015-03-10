From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: move sysclk source setting to
 platform_clock_control for balance.
Date: Tue, 10 Mar 2015 20:41:06 +0000
Message-ID: <20150310204106.GQ28806@sirena.org.uk>
References: <1425949538-20068-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6796216366456630457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD2AC2605CA
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 21:41:11 +0100 (CET)
In-Reply-To: <1425949538-20068-1-git-send-email-yao.jin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jin Yao <yao.jin@linux.intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6796216366456630457==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kjn60822oUuI93ff"
Content-Disposition: inline


--Kjn60822oUuI93ff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2015 at 09:05:38AM +0800, Jin Yao wrote:
> A playback noise happens after suspend/resume on Braswell. The issue is due to
> the codec PLL and codec ASRC are not enabled correctly due to the incorrect
> sysclk setting after resume. This patch resets the sysclk source setting in
> platform clock control widget handler.

Applied, thanks.

--Kjn60822oUuI93ff
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1bhAAoJECTWi3JdVIfQM58H/j7Uf5pjAW0K2jeorAWGEUSP
f7WXQiW5ZtiHGtfOwksvWqaULx/XUzCf5lKOCbfEw1d84TQZoPIN6eq5zCikDFzu
HiL1WUZVwappI2As4bGmxck56Nm02yOgjHVJ/o0BZXquWgmh8GDeD2WfsbskH9Wx
YrIPMvjMfDleUhikkohYAAwPp+9M/WStz5jTcq7Ughfvo/FikkRv3+NULMLxApuU
whidB9Yq0EZsUIR0rXnI5lR9Xt8J5cK3Pg33JxngrUR03M/e9+AiuwkkH+sTWaLy
cQtoL2kPkIgzw/twEIMRyfCJAfuDn9817eY96kremEQ/Ktv1CVekK+MtZeiFqfk=
=Ek02
-----END PGP SIGNATURE-----

--Kjn60822oUuI93ff--

--===============6796216366456630457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6796216366456630457==--
