From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix return value in
 snd_soc_dapm_new_control()
Date: Thu, 23 Aug 2012 15:43:11 +0100
Message-ID: <20120823144310.GE7995@opensource.wolfsonmicro.com>
References: <1345731163-15797-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2326909003323471236=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29829265CCD
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 16:43:12 +0200 (CEST)
In-Reply-To: <1345731163-15797-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============2326909003323471236==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OFnyqpmDgKFV0fx"
Content-Disposition: inline


--0OFnyqpmDgKFV0fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 23, 2012 at 03:12:43PM +0100, Dimitris Papastamos wrote:
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Which kernel is this against?  Both for-3.6 and for-3.7 already have
the code like this (according to git am).

--0OFnyqpmDgKFV0fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNkF4AAoJEFJkBDiqVpZ4x5IP/0VD8Ayg/Px0wMundjl3iBWg
rVIXQkRa48234aJN/3oG3p+jGBdmuZ9P3MrBIMD4ht+yFXmRqkFhNIvjTWbBz6rJ
/bXNZHFM7Ld9HWSIKWjoMbyM/uqguTbhHM6+oJ52GyW0BtI0ViKiFP+nVbKAP+Sp
yU7XKyHN4v56JFkgny7Av/iSDAYnDvOu6HWCgpD90U7/+NBicd4FpYC0zQEljEq0
dJScM8JTGkFYAKBB9x2oJFyoy5EOscugK+mjMpr0cekBLQFCtUDQiPgq8p4B42Ri
STM8ViPMtzHbohA95IvOVGKSuwKmbYI5h3C6AmNhAGw973P9ZmtewwVrQz2CnkAu
1QYP2zxHYjsrpDoEllBthN3R35TxrpvmGEKaYc+SLKpou5rvvusjZRrb+DpWxFRt
f1Q1gNkWEhGVddV2mvJyRM97dy+98b9M6kMLZb2MPa3hax0mNzOV6WG3crqWbX8s
XobvDjkDAG63fyBbioVdfoGR8Cw+mBuTFXW/+tIAI6UHOUozvc1MWZFK6Nv943S8
Q5U2VgwqypjtBAJwoufvTuFoHC4sGC2AbEXncOCVnpsvzXRdG05LJwmF6s+TfAu8
56IjdjPVFhe3Mz57HLkHpfYvrxtpILcwpjMJtixs19U24H4RDpRvBwaMes1td2K3
DH8NtWBRvWSLRaDpBrBI
=xWX2
-----END PGP SIGNATURE-----

--0OFnyqpmDgKFV0fx--

--===============2326909003323471236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2326909003323471236==--
