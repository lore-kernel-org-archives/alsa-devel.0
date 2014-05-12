From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: atmel-pcm-pdc: Remove broken
 suspend/resume code
Date: Mon, 12 May 2014 22:08:50 +0100
Message-ID: <20140512210850.GV12304@sirena.org.uk>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
 <1399361981-18518-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4433237917417958644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04EBE2650FA
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 23:09:05 +0200 (CEST)
In-Reply-To: <1399361981-18518-5-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org


--===============4433237917417958644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MMMKu5Vi3KxtaswF"
Content-Disposition: inline


--MMMKu5Vi3KxtaswF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 09:39:40AM +0200, Lars-Peter Clausen wrote:
> Suspend/resume support for the atmel-pcm-pdc driver was broken in commit
> f0fba2ad1 ("ASoC: multi-component - ASoC Multi-Component Support"). It
> essentially reverted the modifications done in commit 10cab262 ("ASoC: Change

Applied, thanks.

--MMMKu5Vi3KxtaswF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcThfAAoJELSic+t+oim9cHAP/15aQ6XIPJ2De7euOX389VVu
oq7uzbjmTj1mVXTMZcgca/FpoE2QURW2fIsXYrlf8WiGd9Jm/d2ce1khh3XfJFHS
IRilIY40GLSFxW3K1DeKVId/Fgcp7bd90+DpY4yNO74DnyX6Pi+0t4D/RBJWUInW
ww6BaLxycfXRuCj139W/SdHbk0IyCIRoIxLFM3VsL/mdi7CxZfYYagqJyMs9hNHV
XZa62ACmBlYffRLcaGIZZt+HlQdiGrwM4lowMVTyOB/LdfDZJ+1BaS+u7Am5hGGg
cMJzENnWg3gPaUs5aUZo2at42eKTrIzO7waWUMRbY7MNqnoho0US2XxFHQHBbqqq
YiYbCk0vlYL9rti/wKtmE0QnLfHaasw3Vlr5HbIkzW7X3yWmghd+k9gkPWRO2HrZ
l2nDgwXOOgRIKCs+aDwx9hTk7hv/map1/Rod31a586mpbxr2DBPvR1yoI8lrnduj
FcCSfpmqg37py5aC3jGmRkcJ1S9tXoZVO6mKlKHAa3BVUcea8rl7n7GM6H5oX265
ROQ3Ib/gCnoRSI2HOpBMAtZ+rZqOBC/PAI1vwkOtBcvLRIBp/ZqxuamacpCVBn3j
BQYHo7uP7AmJu9/Ov24sRwcCOPqmKA3OvL4iiz2dpqzSXBUISGrwcZf++sQL5oRz
oVFRgitCrovDPq1ZQ1L5
=GnOQ
-----END PGP SIGNATURE-----

--MMMKu5Vi3KxtaswF--

--===============4433237917417958644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4433237917417958644==--
