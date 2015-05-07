From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add cache to speed up
	adding of routes
Date: Thu, 7 May 2015 14:16:10 +0100
Message-ID: <20150507131610.GY15510@sirena.org.uk>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <554B4ADF.3000801@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2818550119495826095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05B6A264F2D
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 15:16:25 +0200 (CEST)
In-Reply-To: <554B4ADF.3000801@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2818550119495826095==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/6iDJYGLS5Zr1Py"
Content-Disposition: inline


--N/6iDJYGLS5Zr1Py
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 01:22:07PM +0200, Lars-Peter Clausen wrote:

> That's crazy! ;)

> I wonder if it makes sense to come up with a more machine readable blob
> format that can be pre-compiled where we don't have to search the widget
> list each time a route is added. Instead of having it reference the widgets
> by name use a index that points into an array of widgets. That makes the
> lookup time O(1).

I'm a bit reluctant to complicate the build process, but like I said inn
my review there's definitely things we can do at runtime if people want
to look at this - build some data structure that indexes the names in a
way that allows us to look them up more quickly.  In general I'd expect
it to be negligable cost for small devices and a win for larger ones.

--N/6iDJYGLS5Zr1Py
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS2WZAAoJECTWi3JdVIfQ3YsH/2y6TL2Hg0kD+ypq3ndzoOdf
Uy58liFr8oGSqHNMl+iA5gXBlHMjhUW01DkX4eP6YnExZI30vEdAadgW9fykMGlb
rWedHJ8tbk0/RJYtcb5QmlgOtUQrdUarpg2/NzTjVDEGz49yFlVbGWs7zE88vfpe
9mgP4V5nnGVCnDvMnrCkwRB1DBWkN2oPiQKwmR4RpyE87+stezMgq9MppRTmj+NY
C0oEx8pWZ34SFrYu68tmF4EYMUpicNegpNk3IXQ1Ww3dVzMF/zXrlk8TMtfko0sJ
XVVGXtXPnZITFt5zYOrTrTCn1ZELy3sXJMl9ldzBMhE3DVjdP8cXvmgjCZ37M3Q=
=EJiZ
-----END PGP SIGNATURE-----

--N/6iDJYGLS5Zr1Py--

--===============2818550119495826095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2818550119495826095==--
