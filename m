From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Use devm_clk_get()
Date: Thu, 26 Apr 2012 12:43:32 +0100
Message-ID: <20120426114331.GH3207@opensource.wolfsonmicro.com>
References: <1335414802-4972-1-git-send-email-festevam@gmail.com>
	<20120426092506.GB3207@opensource.wolfsonmicro.com>
	<CAOMZO5DeSs3QnL2NuZm1ZKBOQY=Dt9qBuvpp=QSd7b4Mg2ouMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1287608309292808945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9688710BA6A
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 13:43:34 +0200 (CEST)
In-Reply-To: <CAOMZO5DeSs3QnL2NuZm1ZKBOQY=Dt9qBuvpp=QSd7b4Mg2ouMQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1287608309292808945==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2012 at 08:35:03AM -0300, Fabio Estevam wrote:
> On Thu, Apr 26, 2012 at 6:25 AM, Mark Brown

> > This is fine but devm_clk_get() is only in Russell's tree so it'll need
> > to wait for after the merge window - can you please resend then?

> devm_clk_get() is in linux-next. Isn't this ok?

No.  If I apply it to for-3.5 then for-3.5 won't build.  It needs to be
merged into the branch where the patch gets applied.

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmTTRAAoJEBus8iNuMP3doSYP/iRjJN90CJI3sATi5JNlZ/Ep
8bTUFWX/iS4S5uLJ/LBChE8zx9j46Vt3qgehJuLg9VwL+LPwPoPKMD8OVRn3nTQO
R+J0xN6enHgul86mqRPjhr17RWpIyLFUqKNdozOjuIBdDBLmVQFwnzHYqMTpYAzg
n/eE2HRbU9KDMRonCC57Q1Ab40W2L4pkmjy/Bzckebymig9dZvWZCh6dfc3U/Niv
DRCENe2/eyFW5Yprkc59Lt2n7YWj2FqVLOURXObT0lJvMInOy7i7xm/H9uMJF5kF
xWq5aNvWH5gWxvpafbo3M5UcvO19KQidwtujfCOEi+3mJQFxedbr2Ul/oXf2BFQ3
r4yjv1KRF0wQ21SoE/9p6U2zeOQKNgnooffBZhlmGqZLjTNYUJNLXrh3/1I6fLyr
ZxKjQ/2hEGyK8SMQxC/hCsfc0HyAeKiJPwVLRZk2sQWXlI7QZrUmD5q2RClMCdJm
l98td4Sn6XwPiXZhzgpsGhQkWYAZH7Nq1CcUqYYMVHE9t01JZyMJTYSHSsvnkb7l
TpNDzD4F1r3M14TRXYiAQaeFq0/yWxqX5Ofsmw/2Lb8NfFfgvghraEESUQJDiDNP
9Rp+WFH+CU0+CLwSbWBLx+jJBsgckOUgMlhokw+ShLEyKl/uDYJhyrg13W60Dt1m
UKZp9aqOGzNPLoy/4EL6
=fSJM
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--

--===============1287608309292808945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1287608309292808945==--
