From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
Date: Mon, 5 Aug 2013 12:27:33 +0100
Message-ID: <20130805112733.GY9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7983478836175425387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE3C2625D9
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 13:27:37 +0200 (CEST)
In-Reply-To: <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7983478836175425387==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Aq9rnu3JhJNSLma/"
Content-Disposition: inline


--Aq9rnu3JhJNSLma/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:31:04PM +0100, Russell King wrote:
> Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
> I2S inputs/outputs.

> +	{ "i2sdi",		NULL,	"Capture" },
> +	{ "Playback",		NULL,	"i2sdo" },

This doesn't look good - this is adding DAPM routes which should
correspond to the DAI link that's already been configured.  This isn't
something we should have to add to the machine driver, if the machine
driver already set up a dai_link then these things should already be
taken care of one way or another.  Either links like this get added or
the DAIs get kicked at runtime as part of the link startup.

--Aq9rnu3JhJNSLma/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/4whAAoJELSic+t+oim9pgsP/RMwnt8DPo7X+F47ibeUmThv
DgJ86NMTUk9KK7YkHcQACn8IdtTq969nsWmPeRZVRMLy4X9kJpXnIrm5irCDG110
9F3o8Sh66dlgk8chMg69rmdCgcDfsoEV2k5x4HlvHBChrtSB0PwFRSxeBdnn7VDx
TNcq0mC5oOlq9wfJusEyfzrhvXgStl5geZzt+QahUHEYeivk98KoUoCk1oTG990Y
8kh664jtyImaiZmT3Ki45QIPPxzE6Z7kPQr7rxCJPi/oWsbU+LDNqTnWoyw8mBKh
KtJViG7Im+pMqg231KCHOnl6ZwFb0Z0k3cPPDMV4OngAumGPoAlq1p+wb3udce42
FF713rp0cylQazS2VN+DHrjMUUFREdL4bkUXb8JfPp7jlZEdSY8ArhYwa6HjW2Iw
VSSUobp8/XtMzZJxhnWMz08+5rwy1ryzZPi1SywAaeTmEIsJPjAfm39WMfGspzPR
X7UzWJatFcoJ4Z6u4UQf/7nQ/Zi82KLyHN0K38UKSeYMkjJjzcjw6Az3wxklwGqZ
rq9gT2OrBuOi/kkVjVZZlXh4+n8LHegDKbCr9wdGTk/lcBODsMixvuPNQNHUNhwt
7hI6E9lTBX7OhXtJEV65AVrTI0UC5sUcXv8X7HIc4FPGbyFLO++HRHjsBZi1wWMf
EZdkUQyOZXf90NKx9lEn
=FUNY
-----END PGP SIGNATURE-----

--Aq9rnu3JhJNSLma/--

--===============7983478836175425387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7983478836175425387==--
