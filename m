From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Codec debugfs init to use
	dev_warn()
Date: Wed, 15 Feb 2012 07:59:27 -0800
Message-ID: <20120215155926.GC2996@opensource.wolfsonmicro.com>
References: <1329318937-14488-1-git-send-email-lrg@ti.com>
	<1329318937-14488-4-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7710920694426810635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9014D103EC0
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:59:30 +0100 (CET)
In-Reply-To: <1329318937-14488-4-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7710920694426810635==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2012 at 03:15:37PM +0000, Liam Girdwood wrote:
> Update the codec debugfs initialisation to use dev_warn() instead of
> printk(KERN_WARNING).

Applied, thanks.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO9ZYAAoJEBus8iNuMP3dtRAP/0WbRrEOaCX/8UTorNNjnDM5
jrzue7SUI96MpSoNErgCnQ5lTgzgCoEq3n52lt3RpV/tMHthApD/KfC7nSQlUQ7z
zulcWBjvCCwP/KLK8N/HCsmyXXhmDHHwZuWQWUXkWOuBF/pf1rbF1hkUHMdzzcSm
V13Hj0BbvCWW0AUXR1IZZRLm/R/WXHT4hrITqvwQPt1F5zaAvXUtsyeljp4Stf+6
OfYPcsAokx5LY8qOq1wKpgY7OIkfa+yL+ToWREHKWwQWzLqCBy+wtPcjyi4zkUiv
M/8UMiEXniFtUURM6q4IJsBJFSTHp2U2cgUuIPWUpsH/RKhHKC3uZjOD8tEo4ewA
M3LCNvwZXgTxWM2K+Oc80wnwtqIJ1yhIEqQRNi+yf6WY3fMKSm4wECi2UuNClTyx
DjllY1O5iLuV/1Ofv377MrMFcDhHvWafvlHfrbKpoccegcojk5FPl1dX7TLKTROF
k04St3EVvDAuBhTTbrb7CA79T3k8Go9b94HkEci0/qeI2n2L6SBnZrD7qZwbKGEC
5H7Wl5Y+qSrXv0Hn498VmowuxJfxMpzny312cVTC3IPROf7qZXqi9zhHl7yY9oWJ
TPKfDCF3k2SYXSwA6udH8yN9ijJ6Ye0sdgSaGwAYf77ywt45kqOmKy+9hBcjr3Zw
BBZ/zX41DITFcShetsTZ
=7oLi
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--

--===============7710920694426810635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7710920694426810635==--
