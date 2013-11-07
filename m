From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 13/31] ASoC: wm_adsp: Fix BUG_ON() and
	WARN_ON() usages
Date: Thu, 7 Nov 2013 11:38:45 +0000
Message-ID: <20131107113845.GW2493@sirena.org.uk>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-14-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2635237704198908767=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AE641261722
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 12:38:49 +0100 (CET)
In-Reply-To: <1383673218-18405-14-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2635237704198908767==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+FNB8hLr74QeaOK6"
Content-Disposition: inline


--+FNB8hLr74QeaOK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 06:40:00PM +0100, Takashi Iwai wrote:
> BUG_ON() is rather useless for debugging as it leads to panic().
> Also, the driver triggers BUG_ON() in the caller side, which can be
> reduced easily by putting an assert in the callee side.

Applied, thanks.

--+FNB8hLr74QeaOK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe3vCAAoJELSic+t+oim9J1AP/1xEBJ04XlaJrF/t7IKANfcC
KOrnWVo3V78Tb4hUMLPMBbtsMoAvH4m63hll1qFomm2xLIReK7/NU0yiGeLuXmJx
fAgxUcnNsx+I+G+mocAnqlgxw9Cw0ApfWxtDy/4112Obb3ZNmm6JIkCKvhGyOrbj
D2lkegoF6StO0yMX42nbLs5Zb+PhDn1wt1ir4VZl3F2oo5w0zXadPZ1XJRi9LPMk
fM7ID8kJ08tGFLipY8B7td8fzwSCv7nZ/SJaNzTlNpweou33pLe1qqnpeO9DBruO
zFljvakBitVY7UKG3SvKwxkP6LqN4yy6lS9UnIsoAkCNkhAm2yrF6XklhsIsHwqS
zT32oaf4iGSDEPozTo+ehBm+H0/yOSsEM1QJs+G2/Mba61BPOjg6JaJvJ1P3zUdT
RoCnFmlMK0uv1R0gJFe8JIwIJHeKq9eSx9qT72alyLOOWBnV4RPfCgiGPsaKeENy
rU9vVvy2um6AES4JVVAwFmnpvWpknc72LDWn+QNxGomOIsKxZ6u4GodL+orUYvEg
JwxaoYdAb/T+gL4ErgNnPl33EPhSpJO8IUNDXc6gY8bYX+NEIyeYl+QR4iYz7eMb
PSOAize0EbDHAbDmk6WYjreY6gsZ1GOT3orqP1SCS/cfRNZwYEDt3WFoLzcxtAYT
SWD5wjLZNmhs2ZunP3Qx
=ndXv
-----END PGP SIGNATURE-----

--+FNB8hLr74QeaOK6--

--===============2635237704198908767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2635237704198908767==--
