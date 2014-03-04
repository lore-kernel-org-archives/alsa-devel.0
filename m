From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm{5102, 5110,
 8997}: Replace codec->control_data with arizona->regmap
Date: Tue, 4 Mar 2014 12:05:50 +0800
Message-ID: <20140304040550.GE2411@sirena.org.uk>
References: <1393677932-17336-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6027845512677126944=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D9F102656CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 05:06:07 +0100 (CET)
In-Reply-To: <1393677932-17336-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6027845512677126944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yXyGAOZGgonRe4uu"
Content-Disposition: inline


--yXyGAOZGgonRe4uu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 01:45:32PM +0100, Lars-Peter Clausen wrote:

> With the ongoing component-ization of the ASoC framework and the continuing
> migration to using regmap for IO the control_data field of the snd_soc_codec
> struct will eventually be removed. Prepare the wm5192, wm5110 and wm8997
> drivers for this by using arizona->regmap instead of accessing the CODEC's
> control_data field.

Applied, thanks.

--yXyGAOZGgonRe4uu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFVEbAAoJELSic+t+oim9ZDsP/iPI1MlPQWIfLhoZ7FTExmMg
6U1dvjnOQxLB/dD56pS9RlM0b6if425AUlMfPTzpSnz9wHwtIIXOOlhEegg9HMPd
XdoCUQ1Aj8xGL+sTP8Rxssy/mLylp0Tic8OguGynmNTPfTGTsJBjnkrE3UEJiG+b
oIWpecY9W8OppVfDFXt63C58G+4bsXeECFL5qLbsLfoSzmh2CM/8UzjSiUngUYO8
sZOkTlU6H4DHXLIz2UCcb6LySpU54KM8pwQIIjWeGZkqKNVIXMVTU9X8pkE+AXVV
DQxtOKrAHZoOzbwtXED9ionmXSM1Md08zyFdiT3Ryj+QeCHE2TXkI6m4SAPqVk9T
1O1mf41L7ClwwwFWFQcroTyniMhd2nr0JPCXSJQZV5KmOfcHhUPL3/Oi69ESlRa+
ctIfoKVogYrRVeWNEABF3mQmFaYh8ezM71tR7SI2g4Y9Vn84knlCkyByPAQq/ST7
0UU6d0X9CbV730E7ckbQr7tolI1uO9kfezDCFuV95HsPlApIHC7MFHaJJzoMvNRj
/o4339zZEUCPbS9QYpKCwHNOoB9d5Zt1sIC2qfn7q4NiCirfytiu2HAKRX8+V9PM
BF7cL9TRKVbIJN5WaJRKeVUJO66pEJ9kYc0AHJPs83jlmbi8RaFAoHH3BH7p6Ogc
Adn7Vi4ZPY/jVe78sdsz
=5pvu
-----END PGP SIGNATURE-----

--yXyGAOZGgonRe4uu--

--===============6027845512677126944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6027845512677126944==--
