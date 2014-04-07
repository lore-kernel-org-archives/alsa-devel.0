From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da732x: Print correct major id
Date: Mon, 7 Apr 2014 12:58:07 +0100
Message-ID: <20140407115807.GD14763@sirena.org.uk>
References: <1396526192.12814.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3218942392133626847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0798A2615C0
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 13:58:28 +0200 (CEST)
In-Reply-To: <1396526192.12814.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Michal Hajduk <michal.hajduk@diasemi.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============3218942392133626847==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDa9Kr4PlLWO/T7L"
Content-Disposition: inline


--IDa9Kr4PlLWO/T7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2014 at 07:56:32PM +0800, Axel Lin wrote:
> DA732X_ID_MAJOR_MASK is 0xF0, so the major id is
> (reg & DA732X_ID_MAJOR_MASK) >> 4.

Applied, thanks.

--IDa9Kr4PlLWO/T7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQpLLAAoJELSic+t+oim9xTMP+wQaw51sV/vhjZxqSfaoZeHq
fXBLfrxoGZz7BgjfGB79KEbMqnCiGN4KHsTbQSNQEOZlmmnrFiyQhMMXP8JunWWb
/DyIcod+AkINLdSmcAs2RFrILAAqQoRmd5FuFnvb2qSDC8621C+gEbY/AAWDZ0is
D6CrKGqTom8AvZLVmZ/MpDMB/4ubk/IUfmJJq3ArOe08ChmgS/zaG+6OSRKRWdMw
V/0WXsT5nKgq5fBv1atvb2/D98sOCy+r2dWFg2q6I7Yddttn38NyL8FZim3Azuv+
zQNieRokEpq5wCDmzZW50wvqeknz1UcdUtiHnfk4SfYBLhoQ8nSd5mWtHchcrK23
HQKVU+WgdUk3Xyrg//HveqLCKS5f+7pJacZZOErRZPzmcjCZ+o8kJYCseHKOqHTE
aZzYt12fPj9AGFZCcKSTYlTJW3JyRa+0St+MT6HPL2QoQKSYhjVwwiUlO0sgm3wQ
DJAEJL9IWxgftYSaP3Q332SBx0p3NUUL39QqRAA88aM0oOHr0FLO5pwjrxlnYupx
bhIRvmCRCxgBYmp6Ijvwv3F9xNBwkOdAsxFNUXRdWOYxFr2h7QcitQ3f4CS6QoPp
4iNrBZG6IHmxorDYKe+wypqsSQarDamdPjiwSOLu+jiBXQAPN1cOtcfo5xVRwPr7
43NC17lTNkkkxgawp5jx
=wiUL
-----END PGP SIGNATURE-----

--IDa9Kr4PlLWO/T7L--

--===============3218942392133626847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3218942392133626847==--
