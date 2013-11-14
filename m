From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/21] ASoC: davinci-mcasp: Correct am33xx
 snd_platform_data name
Date: Thu, 14 Nov 2013 11:55:18 +0000
Message-ID: <20131114115518.GK26614@sirena.org.uk>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
 <1384421737-4467-22-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5171633942879191968=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BA66126170E
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 12:55:21 +0100 (CET)
In-Reply-To: <1384421737-4467-22-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, Daniel Mack <zonque@gmail.com>, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5171633942879191968==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 11:35:37AM +0200, Peter Ujfalusi wrote:
> An earlier patch overlooked this when the compatible has been changed from
> omap2 -> am33x.
> Rename omap2_mcasp_pdata to am33xx_mcasp_pdata.

Applied, thanks.

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShLoiAAoJELSic+t+oim93gsP/0FSZ1sxgCUGte1dtFFbzzAq
9U30mI+Bco+R0r9ulhVF1TXgPCGJ/7My9pifp6cAhm1e3MFVirEiKrzdcGAe8Osa
6nwyrYwwZpSyv4hqbIndi7+SHtqsEY1j3YqeF3hs32+oJF5aQRcz+itWaToPKnqE
4OTJQahUysNKvUsu8mBNYKXpGp29JTk+n5FvZOjguYq3mMX+I+dXkjQWXf7bsmGr
MpMFgO0MTaw5DBRohsaLOnDH+wo2UJD0X+UvYVJvtWSc7KSosDlqzEq/X4SkWmsu
yKN+87IQs1zBteuI33kf0ielmEvW1elV6RubedFGsmvptVytOpRSaeMVoJoNWnVt
WMbvMWJC3rykJTXdY35WOsuAhzqB/P7TSxlq5ikdMyrTzKo04oq5K35MWkrlLtHG
QggudKwJbSX40n1Kc+Ou++/ZzmLw7N805XZnOWNyY4A3Hd6lJk//IzLmB8OvpVtS
gSXP9HCpY5RU6r7M/CsMewVCKUDnQWLIaOxcberkpn6iXE/f3BWAico0cq/93LdL
hMIkEV/v2GkU15BPMxjshOllWpdoLQZ6bKobpQsaQVO+wVstz0xzLy2mVwXohq69
anWzTgh+2ZL5fcjs4/MaPnDyOfOeGc7IN7IAIGQeag1uzmBc3255NbdPnPCMYM37
SNTv5v/OMLTA08TMrBeE
=YRLL
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--

--===============5171633942879191968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5171633942879191968==--
