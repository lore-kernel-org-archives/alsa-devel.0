From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 15:10:20 +0100
Message-ID: <20120329141019.GQ3668@opensource.wolfsonmicro.com>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329071700.GA18127@zzm-ubuntu>
	<20120329105831.GC3668@opensource.wolfsonmicro.com>
	<20120329140420.GD19506@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6390482597061534309=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5A47C104452
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 16:10:22 +0200 (CEST)
In-Reply-To: <20120329140420.GD19506@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6390482597061534309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kPJUzav3owWaKxsz"
Content-Disposition: inline


--kPJUzav3owWaKxsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2012 at 10:04:23PM +0800, Shawn Guo wrote:
> On Thu, Mar 29, 2012 at 11:58:32AM +0100, Mark Brown wrote:

> > No, the bias should be a supply for the microphone - ensuring that this
> > happens is the whole point of the patch I sent the other day.

> The "MIC" above is confusing.  I guess the following that I have in
> machine driver might be a little clearer.

>         {"Mic Bias", NULL, "Mic Jack"},
>         {"MIC_IN", NULL, "Mic Bias"},

This should be something like:

	{ "Mic Jack", NULL, "Mic Bias" },
	{ "MIC_IN", NULL, "Mic Bias" },

(with the conversion of Mic Bias to a supply widget) which has the bonus
of being a whole lot easier to understand.

> And I need to present it in device tree though.

Use the generic stuff that Stephen put into the core for reading machine
driver routing maps out of the device tree (unless there's some problem
with it, but it should work).

--kPJUzav3owWaKxsz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdGzOAAoJEBus8iNuMP3djH8P/RbZnKpti6PZPGkZMCDRr7WH
LikgmMXdro/nU8GjxYtIIxifJ+MPOwKFDNbC8y+thsOj/a9y0bde8aL8O2nyUUaH
Avu02UjhzdxPhHyQFfsopAgehhsjAUzICgjtCIblJoqQckpYfIKFFjoz6X8lFnHC
Juc6s5LBZHqVnBYP7z6H7JcgW7oR+J2AD3BCEGfhF2NzSttUVSa1zgxUjJs+ADsJ
3rsgDcbvEHRsaFzBMvEyK6+TG67jICDU1xZ71xRQarIosiw5Paq6GE/le+9p9hcr
yCiSUWLnE5zrsJYLNR/Y6XCV9OSEJzROT1lrbbZB0dvELL/ZARBDNGvdzp28p4LW
hJv13HIlaz6cYcAY9KJGdFyBhujDupSGPpX+iMazeneDfajZTymsww4isYyu+2ne
L8aZ/EwrYLWigKi9l5lPDvsI9nWQd2EnPEtDf/kK6JGMmlJPQNnGEtN2v3ge6RG/
e30PhTdK+wkl7UZF8KvTzsuPZ+Xg6wl8P7U+MSbjq0G82Y8nF4BbVtXLB3gRgYKm
wVA7IXT2C408rjetDdUijO/sM5FNjPi/QdKMnyAIEDrsH7pHKpu6f6ocFKyPYzFL
SPPZQNA0FoUsKoGDNsImDHTCcYdiYqCNNIhRVi+imIlksjaOwQ+X7PnnjjlC8j9t
ioVowGwlYvLdd13o+OgZ
=h5SU
-----END PGP SIGNATURE-----

--kPJUzav3owWaKxsz--

--===============6390482597061534309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6390482597061534309==--
