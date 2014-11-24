From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/32] ASoC: wm8711: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:20:29 +0000
Message-ID: <20141124182029.GZ7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8764545062248484117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A914E265361
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:22:33 +0100 (CET)
In-Reply-To: <1416746269-4935-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8764545062248484117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fzZAfzrt3Jhvp+ma"
Content-Disposition: inline


--fzZAfzrt3Jhvp+ma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:22PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner. Also remove the extra write that sets
> the WM8711_ACTIVE register to 0x00 in the suspend handler since this write
> is already done when transitioning to SND_SOC_BIAS_OFF.

Applied, thanks.

--fzZAfzrt3Jhvp+ma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3bsAAoJECTWi3JdVIfQLy0H+wdG41wADLkYWuHY3N8IaXnL
unSt1Vu/qne/lfmP3ssBn0UUFxh6TfCrEH0Ayl++1CKIsrvxhevw55SGQg7p7ptB
sC1taUjlKgryjE1ZJgEp1TmC5C5dfhvupxpOs8h9iFQpqdKkqvsNw5Xx0iwqOyjP
kvVDDvZ84PpRWoDURTmr2Vkov9RqdRYgCSUHcPZmy/XDCgpu/yYtKqgQuYl2RXCo
mIZ8c+SZSYr5RQPUyLZizuMQHB51gDbwwjgnsRRMGI3IkYyozdj5PIKEyIyDKTSZ
dqX8wi12CewVVrvSEtBzBUUnJV3alLkv0Oa9645ITmAtRkZniDJqV4+8VfleGRQ=
=8865
-----END PGP SIGNATURE-----

--fzZAfzrt3Jhvp+ma--

--===============8764545062248484117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8764545062248484117==--
