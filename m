From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: mc13783: Use
	module_platform_driver_probe()
Date: Mon, 6 Jan 2014 15:38:17 +0000
Message-ID: <20140106153817.GA31886@sirena.org.uk>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7483198993733853455=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 237982610CE
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 16:38:24 +0100 (CET)
In-Reply-To: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7483198993733853455==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z5G2R6hIjkQ11lIG"
Content-Disposition: inline


--Z5G2R6hIjkQ11lIG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 05, 2014 at 11:38:31AM +0400, Alexander Shiyan wrote:
> mc13783-codec is probed only by MC13XXX MFD core driver so
> use module_platform_driver_probe().

Applied, thanks.

--Z5G2R6hIjkQ11lIG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSys3mAAoJELSic+t+oim9mfEP/iZzNd7CEEBCYskdbO4Mxbtf
zc04dJSN04h0KyEc2CCNMfh3KCsUKtUOY7P6MPI8im6gAvIr7ApUCD9FfPVrNDkD
WXNW+l3uA3P0sKO+c20kf2aGO44rmTlc7l1/InR5La9f9MQyYZ2kQJAFLh21Q3Es
lBBe8ZZgZCRi5hfbg54dC82EHeUAIcJiOZ/z9UP+/wdLrgZYPRR/BDTOXStM00G5
jG888xHVXj2Dy5AeI0s6vsnozUx2b40Jd9HKQUOSklCQ6M2uNxyi4dGNR4O12Mmx
x/ZV1kmqgZAoNCebJjamLk7EyivxCP6Ug6LUZUXucfVhzgSbyyf6YuPUTriqb7cC
Lj3deW3Bt7k66Qz8zUET4/CUeaJG/ORiJWmxooJb1AWchchtRE83OBemfccbO0vC
lTCmehr6PSWpHrj4PaOC3iY/yhr7IjSJr0Jdla4lWd/BD3tnYvUIATM/39uyQpPh
Jmr6ddrYlDfEzGPueVEGAw8Rqk4kVFRbD3aUGvki6ytszcQi8rLrANubmIKAheFK
dLkNcGRtlk4k9fRzS8qlTVFe1LXMGorVXIDNFyquRI99dkSEOxyNvDvlQB89KU3H
8ta979ujB8Kju5qK5E/nvjLSk85OECpn7EfYNVy0JzimfpPnmVcrkaXBOuKMbP4u
+kRZrkTEGxCoWlmnel3a
=o047
-----END PGP SIGNATURE-----

--Z5G2R6hIjkQ11lIG--

--===============7483198993733853455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7483198993733853455==--
