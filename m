From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add headset detection
	function
Date: Mon, 8 Jul 2013 14:31:12 +0100
Message-ID: <20130708133112.GE27646@sirena.org.uk>
References: <1373265189-24917-1-git-send-email-bardliao@realtek.com>
 <20130708112644.GR27646@sirena.org.uk>
 <1121E117AD4ECE49880A389A396215BB8A897A3E83@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7545834351667789238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ED108265461
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 15:31:29 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB8A897A3E83@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7545834351667789238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hMqxZgAHHKe5m0zX"
Content-Disposition: inline


--hMqxZgAHHKe5m0zX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2013 at 09:12:06PM +0800, Bard Liao wrote:

> > > Add headset detection function to rt5640 codec driver.

> > No, use the standard soc-jack framework for reporting accessories.

> Do you mean call snd_soc_jack_report in rt5640_headset_detect to report the jack type?

Yes, with an appropriate way of setting up the jack.  Look at how other
drivers do this.

--hMqxZgAHHKe5m0zX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2r8dAAoJELSic+t+oim98QYP/j/5K4BcLWrIBHopXyNk/jFH
Cut+K42yb51R5cuyWb1cRisFXKeR71TKfYYqXKuXZNmqPzbhbVnlru0S5udDH7Uj
sk/7gNsiv+Pfs8UIIJ4iMsE2OwZewm4mJ/80tdwmuxteuCqWJGPS4dsTJlhDyRvZ
3/KsdfxqrfQgUYb7fHfl+N90ZS3pEh8pPm5rK50F9a2UTV9kZETPerpAmTZw74UP
dQf165HaOigf+rkofllqSwVvdTQ5l0aHABlBzMdskEfFR8qq/RT4Xeu+WztJ3Fnb
HTjo1MxlATU2ySfHgPtlVgq8TQMwcK/bIkkdKFDgRpFBZ2p36Qj43awSui+jRKOy
zqeRhMTbqACmCFR35nuQrFrq7f2vnoDUuwUKIn5yvN5YIU4/F0EmAqBZ4lAFepzD
98fTE06BuOa62KnU/tlmrTkSx+3VblEsbZVdipsJ1gCvoIi1qxXtA10Qs2zVxOl7
g7C0iBwxXP/yEPPFkzqzucbglO4m9hQLscbZJ7N7dCbejubta5r4SY7+6yLEYhO3
NSU4+pBFZRxdc/dgA2KytSrKE8YjTjrKmepGNv1SdwTyp9stlsVekMa/I8NpnLdw
WvJjqjm14Lii/CAWbtTRk8FfWNkoWXjFufiNHHPAqNg49gBUi2Lh4OEA+ED8kjJ/
tLyV4kSeLDeMT6A24l8z
=dB/X
-----END PGP SIGNATURE-----

--hMqxZgAHHKe5m0zX--

--===============7545834351667789238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7545834351667789238==--
