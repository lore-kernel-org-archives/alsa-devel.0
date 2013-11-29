From: Mark Brown <broonie@kernel.org>
Subject: Re: Using devm_snd_soc_register_card() causes problem
 with imx-sgtl5000
Date: Fri, 29 Nov 2013 16:06:01 +0000
Message-ID: <20131129160601.GF27568@sirena.org.uk>
References: <20131129140153.GA10843@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4333222589842427900=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 81EB0261676
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 17:06:04 +0100 (CET)
In-Reply-To: <20131129140153.GA10843@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============4333222589842427900==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aZaBog0ly0buBYah"
Content-Disposition: inline


--aZaBog0ly0buBYah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 10:01:55PM +0800, Shawn Guo wrote:
> I'm trying to test Lars' devm_snd_dmaengine_pcm_register patches with
> imx-sgtl5000 machine driver, but running into the rmmod problem below
> on v3.13-rc1.  Reverting commit 01984a4 (ASoC: imx-sgtl5000:
> Use devm_snd_soc_register_card) seems to fix the problem for me.
> Any hint on what's going wrong here?

No, not really.  Is it managing to do something like double unregister/

--aZaBog0ly0buBYah
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmLtmAAoJELSic+t+oim9RqkP/27CB0JXcJBM3mp615FJQ3Hf
+1cyxFo9+H+ozIUq115gwPZc8UX9Ub0RBC5AMaI9xPKReTfN/XsWeHTA8YZW5kMu
ZGuHu6fZ7/8HSIeimDwdaeRdwtJrteVoW6R1aRCtC4Z3ArLOEFDlUf7gyeF27e0c
p3UKt40S/JQeAKYFAU86H8NL6F0/4dRPpwyieUcWxOS9e3T27oOqzJRqDqqqPw4a
KFDtbcXWFsSUbTu8sShyzXYzsxfy345RW9F5wxcV9wjuaGFXoMAt03/Tl5TpOMPK
tcQWeDIR+wVmL5ROPyUuU5R/ZaNeT5+wLV2rBQ+7EA9y7amgpmKCfsO+qAQFk9a/
DoXbzyJJsrzze1D8yaNbwUE/BWSmS2enlrnTLJ63C5Mwy9RtI9rDeBmZBP3ttu0C
9mJtd7yWNH1g1z0pV9nhEQvFkME4ni7as+xCpTSPiiOcwXA6Z9ZdgfDySQ8YDqqP
1CMhS90oxo5/EeLezjV+5T1XsP+wW5p05z6xR2CO3dR40lp63Z02Yi85rF8W8f7p
i2C3bx7QjHJSSn/hlPNQBtGTafMvM+In2TNSQN0gVZY9ylWnqeCkEHC1Lil+BVhX
0nDVBi+Cue0lFMIuHngrkZbKV4JshOOqVS3ix2vzoCAHJvOfSjUK9ePpJg8EV4OB
UTaxUd98sMlVBISF6c8b
=lya+
-----END PGP SIGNATURE-----

--aZaBog0ly0buBYah--

--===============4333222589842427900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4333222589842427900==--
