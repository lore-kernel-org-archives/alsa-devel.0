From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Fri, 29 May 2015 16:18:06 +0100
Message-ID: <20150529151806.GO21577@sirena.org.uk>
References: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
 <1432906281-27698-7-git-send-email-jun.nie@linaro.org>
 <5568736E.5090801@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0359108086963992222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3486C266838
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 17:18:18 +0200 (CEST)
In-Reply-To: <5568736E.5090801@metafoo.de>
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
Cc: Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0359108086963992222==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GZNgVBfHx+h6FEHh"
Content-Disposition: inline


--GZNgVBfHx+h6FEHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 04:10:54PM +0200, Lars-Peter Clausen wrote:
> On 05/29/2015 03:31 PM, Jun Nie wrote:

> >Add zx296702 hdmi codec to enable SPDIF and I2S output
> >via HDMI. The SPDIF/I2S route is exclusive with current
> >software config and need specify which is valid in
> >defconfig.

> That's an issue, the hardware configuration should not depend on kernel
> configuration setting. This makes it impossible to run the same kernel on
> platforms with conflicting settings. It should be possible to configure this
> dynamically at boot time based on platform_data/devicetree, etc.

> But is this device real hardware anyway?

See previous discussions - the SoC has an internal HDMI encoder
connected to a S/PDIF IP which can also be brought out directly as that.
The solution suggested in the previous discussions was to represent the
HDMI IP as a CODEC and connect the S/PDIF IP up to it with a machine
driver, I've not looked at this patch yet though.

--GZNgVBfHx+h6FEHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaIMtAAoJECTWi3JdVIfQu9AIAINiJT3Gcb78Sl1dbjU0gMO4
0CMvPq60OoAQe2sVt4usTwNAolo5a4a4/x1+ye5R+u0EiksjyajOjcYdCTIBMcIn
2ArMhml7w0tzsCWwRFZ/xhPq4cDs4UBrx+GZaUFyckyOc70P8J58Gulqq9AK/C6t
KB87+HMp3g/8pKqeeKGhZxbwxuoS4QoK9hEEstW00RbPrw0My3TjS5QEHGuAdCeN
c9QrPOm543+r/ok4k4Op0nKWaV54F69lVV/Gyo2pEXV1neK+wriC5ffGXmryLmjM
RzXP+kqN5tAQisKCOCwKso8neoSzOGrhN8t6itYfeiyKRGzm7pFa0pRmsUT54Ok=
=76EN
-----END PGP SIGNATURE-----

--GZNgVBfHx+h6FEHh--

--===============0359108086963992222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0359108086963992222==--
