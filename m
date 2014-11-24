From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 25/32] ASoC: wm8991: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:39:44 +0000
Message-ID: <20141124183944.GS7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-25-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6818404103810253802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53166265726
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:41:40 +0100 (CET)
In-Reply-To: <1416746269-4935-25-git-send-email-lars@metafoo.de>
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


--===============6818404103810253802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hc1Ad1NXUysMDyjB"
Content-Disposition: inline


--hc1Ad1NXUysMDyjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:41PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--hc1Ad1NXUysMDyjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3tvAAoJECTWi3JdVIfQEDkH/0ikXXHFsJC/xbT2c6KT2KrF
+X2bdXnyC7mEQNcaNXOy0z4ssdq/UOOWeHTfNmbbdaMPb4FsO7YEGyMLykurb5Js
O6FiB4OOy8qjjdSS9N4qHfk5mEyH59l3DXEk7A8p/5s0RsakpVu90JzPdaDo602W
Gvzc/hk0f2g4Q1O8gVq3RGYLF1hCdy8fkUPDP0F7XSyoPd+KFzU3+cMe5s2eO1aZ
iCRFRa2UIHDJ38fIxBlOaKAQWwXL9K4giZoTXxX+oourbJ1stDE/7SXc1D/KqXAw
/WU2weYnlEu7CmQM0T6PG7kbwudxDOIiQyP2jn8ci6pwNKXhIQ4Em0dcsZsxebE=
=MFqf
-----END PGP SIGNATURE-----

--hc1Ad1NXUysMDyjB--

--===============6818404103810253802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6818404103810253802==--
