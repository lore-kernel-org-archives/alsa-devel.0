From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/31] ASoC: max98088: Use WARN_ON()
	instead of BUG_ON()
Date: Wed, 6 Nov 2013 10:18:30 +0000
Message-ID: <20131106101830.GK11602@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3743614731097993741=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 05DDF261AEC
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:18:33 +0100 (CET)
In-Reply-To: <1383673218-18405-3-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3743614731097993741==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:39:49PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Use WARN_ON() and handle the error cases accordingly.

Applied, thanks.

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehdzAAoJELSic+t+oim9d2kP/3jQle2vopiwmsk5W3kIniqw
ic4xJkYudUam1emgqk3SAMvQtTU1kc/uxaV6Ro6+JdJ/FgVL1PB/LQGi5CRzW2KO
HO9CnphylMKMKTdPEPGSmp9tv2tsPQXVF4AqWqQIyJKD6rdtufM1pjRsRPl3RnDP
8NPaA4LIVxlZPwUPXes1+WL+WJkm9j+xpKZ1wPHacNNNzdCVeL2a7we11u8ffZ80
fMCllHXd8pgw7Uq4ZyPlvvzywdPmMAJ6DX68m7bk943Dbh7EcPzU/mwQfGcmcLB2
jodkIR+Vc/TinlOvaeBSqAPFdqN9Js2kKotYIr3/lNgtZHazRs5a7E3PGKSovfP4
FCBZpJp3Gc8kUJIZ+ns5uF5YEeuliLsCrJjyfLt1IrN3RN0MVJFEeCDSzTsBMwmk
7mMOAX9V6oJzcGcr1K63FefjKV8EUroYpMvlFTFsUxizSSEfpGdihSQEAjSeIphg
XksPBs+vtuM0S8p2NcQ3/pdp0/dNbE5jIuMViLFkKGan3uhlzSQiD4GN1mPRU3+A
RtB8erE1aqpPelRj8U3M08/hRj495MqqOODnmfJCSNu/8ZU4nMx2LihANCDfAuLu
9TOUOXxvX4LiaSPHWwKcAUrAWfwtYdOlNwDgRhN8OtH1LmsyQUocMRB+k/zmP7Lh
O9iIM8DticMFuPoYQKHZ
=qk5s
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--

--===============3743614731097993741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3743614731097993741==--
