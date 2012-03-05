From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Support new HDA codec
Date: Mon, 5 Mar 2012 12:16:18 +0000
Message-ID: <20120305121618.GF3224@opensource.wolfsonmicro.com>
References: <AB277FB27524F74C87ACAFF84F2767490D5205C4E2@NTMBOX.central.cirsa.com>
	<s5hehtkxma6.wl%tiwai@suse.de>
	<20120225115048.GD3167@opensource.wolfsonmicro.com>
	<s5hpqd23i5s.wl%tiwai@suse.de>
	<20120227135131.GD3191@opensource.wolfsonmicro.com>
	<AB277FB27524F74C87ACAFF84F2767490D56E514A4@NTMBOX.central.cirsa.com>
	<20120227140739.GG3191@opensource.wolfsonmicro.com>
	<AB277FB27524F74C87ACAFF84F2767490D56E514C0@NTMBOX.central.cirsa.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6470835987703281583=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22E6224151
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:16:20 +0100 (CET)
In-Reply-To: <AB277FB27524F74C87ACAFF84F2767490D56E514C0@NTMBOX.central.cirsa.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6470835987703281583==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2012 at 10:44:23AM +0100, Jorge Fernandez Monteagudo wrote:

> Attached it's the patch applied to alsa 1.0.23. A new patch_wolfson.c file
> is created. I would like to note that no Wolfson support was received to
> develop to this code, and this code is useful for us because we only need

Hrm, that's not strictly accurate - we didn't help with the code but I
know there's been some help (possibly via the distributor).

> the outputs differential and SPDIF. This code must be revisited in order to
> support the different inputs, the stereo normal output and the I/O.

Looking at the code it seems like most of this is things that I'd really
expect the generic driver to be able to cope with assuming a suitable
BIOS setup, but looking at the generic driver it seems like it might
need some enhancement to do so.  Things like the S/PIDF output should
really be able to Just Work.  Hrm.

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVK6LAAoJEBus8iNuMP3dbNUP/jRwAnuQXj6TOycdGZ0cmRQH
HeYt30rxywZonFDulR8eBWNugh4XMWmZjJtCa9aR7DYGZtRZ15xGlqhfOns2g57D
uZ+s4jxDwzyAA8+wzq2/NKoCD9DGy8dsw5LovxRHy9bu6u/9HS0QbYmVPDCzR7dO
9pDqwxQmD4pFG/xbhF57u/YAZlvQBWLC/DE/MqX3fFjzR4jNK4rh/ytCVJTqBvGK
lcxSj4O1fVlGuoS5x2hSoPuOgDPyLVc3dae+3z2I5UvBFtOY2XhswKWFC0wRrimu
92lKJQyqsei1mUr3AvnuKlxjL4DoXYfXJGIhgp+Bfp9thm3piitzRpiwMtbQEc5M
LJT518qg6bNF07adknLpEgHkQ3GIM0NccDSnO/wrn3qPRYACMoDfwm4dTNo1U5Tf
j7Xp7MmAaT3TDSa4L2tt3oCzJqa9oEfefkZbY9y2umYuv75gLtc3chcOyt/vyi5z
Xll8MqIdR7AEeOJxsR/3MQs5ToE3uG/cDCoixOByHOyxbUCEXQH/uKDBybPqRZvh
MzFjEymqZwwekVilbiHudmfrBlfOEHlKOvWvI2H4yJuqs042UN442tHUIhHUNTHB
XIfikxdZtxMs1oWEXTLLTVrxQuXZyHSCxcdjByLBWZ5U6hyecWmKf+GQB/ZHIc8M
1dNr/4BFfFtwvqUbhSq6
=/nWX
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--

--===============6470835987703281583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6470835987703281583==--
