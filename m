From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 024/102] ASoC: wm8900: Fix the wrong number
	of enum items
Date: Thu, 20 Feb 2014 10:28:34 +0900
Message-ID: <20140220012834.GJ2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5015109680522006721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C3FA265694
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:26:51 +0100 (CET)
Received: from e0109-106-188-224-205.uqwimax.jp ([106.188.224.205]
 helo=finisterre)
 by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WGJLY-0005vM-Nc
 for alsa-devel@alsa-project.org; Thu, 20 Feb 2014 02:26:51 +0000
In-Reply-To: <1392723422-12689-9-git-send-email-tiwai@suse.de>
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


--===============5015109680522006721==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H/+f64s09DbLO2Th"
Content-Disposition: inline


--H/+f64s09DbLO2Th
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:59PM +0100, Takashi Iwai wrote:
> wm8900 codec driver has a few places wrongly defining the number of
> enum items.

Applied, thanks.

--H/+f64s09DbLO2Th
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVo/AAoJELSic+t+oim9ZYIP/RHzFx+vc8cwr+ycsiTHvI+Y
8DTBudxBDXOou+T2/w8WMkpGKHe1U7Y+TvGqy4YY79JOuLwTj71KWqjt6O3iJm8E
krI5MpJkqZbj0TjYg9EIonYzaz15jpNLUC3M/V+Q9fDLj0M+et1qlCazwOUoaJGE
25wG5nDH7ePq0el+tXlw9qo2yiHkuBZP/WGOgG5hmXVoRg/Uqv5PA5UQxVIGxd5D
dliZTT8RG3dFuJIsj3PmBOolMQZ1KHxx8wN8bAkNCKj+nQ51fwGXoR5HM5a0S/+P
f8a3t6DutytEZ+vVxCj6ljXyNzPbUqy20gRhMRB+PF9/smOxF1u82ecBvGmYYbr3
lVvtRqZMY10iV3Tyj7KeUw3Tn/E0H6wZc67TCkShTuh9or33jToyYOL+XWtEf6Cc
L++Gl2EMSECE7sxzTA6JataiR6MZArWu3s99yp2Q5wmWF8AkWlc4RFtsrTexs2Ns
u0wePFMwnlHpwGjRZ0ehWdZozZwI4cCr7wM88UhkRvnerJY8jSIeJ9dxQDwG0/5e
Q+rhyRkiYUXAe7O3ysoMWQhzZkIwmvBft9rPeQnCUr5C5vDY0883gLVLbMFZ+X7b
0/L6OPvECYdM59we6ZeHoxNXSQbiamOGt2liuRE4ixWPe/cbGE5gViHybX7wohWm
OyYf2lrI9yLv7JsAVC/w
=hZON
-----END PGP SIGNATURE-----

--H/+f64s09DbLO2Th--

--===============5015109680522006721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5015109680522006721==--
