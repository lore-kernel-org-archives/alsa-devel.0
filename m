From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 010/102] ASoC: ssm2518: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:57:07 +0900
Message-ID: <20140220015707.GY2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-8-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687839949467047635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 09A50265646
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:57:19 +0100 (CET)
In-Reply-To: <1392723148-12597-8-git-send-email-tiwai@suse.de>
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


--===============0687839949467047635==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Giar8Gekte2S5Alg"
Content-Disposition: inline


--Giar8Gekte2S5Alg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:22PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--Giar8Gekte2S5Alg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWDwAAoJELSic+t+oim9QtsQAIVRNMzaRwCn3msWr5zYuWMW
ti0fSta5jMgNU48JDsa9JGF1gBxUeZ7vd+0Mkg74MXuZQAY/o3OQD0epTkfwdsVe
CfTqW6eVmgQ2yY2rn6ESs3d1UtsaHfrFIP3Tz68byoewfu4mKSwNWs58NDKuDQUR
0GtFl1lFHLD4AqLACh2TcOinxjM9DSFbbssUpgcelQgbqGQbJ8Zthl0i5x9WWcby
yKJTJ6je76+fVdBl+D67fyybThDSzlGWd/Nq2avSfOWQxE7oBfBgltfDb55gd7cP
zu7mQ9i2X7ca722XehJuDv1xDAqIY/zJ6yPHtVIEjf325idpQCjt4ESfsPeCQ8jF
5FAOsw2TSMg8+QJsqPmNQpu+CpskTyF3Ue05nnLSVEYeV8BtBmhhz/Eq6hxtjkuE
1cM+PDGnkLvFHeLp6iag0bwZwQDXwDswQ/YGW8oYV0p90WHoZ2mEKlptGHoZL2gV
L3MlmkDR6JK5Uy69s2/VE42f70jjMONFoUYb0ZLwpCC1JSkStpqkZNzcVBPcqcZO
P5B+byfT0P/uzZFE1pXY6afuYImAbUZCv5lmM2kdAUbmQN0Pd4tiF1x+hbD0KF4E
3546jCpwstZx02Ks9lRhIpvW2vuY0DTRhEObLkDylCfVFWbuVidIbuBQ492IL3yw
dR96mZbDD+l30VERks6e
=5vwD
-----END PGP SIGNATURE-----

--Giar8Gekte2S5Alg--

--===============0687839949467047635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0687839949467047635==--
