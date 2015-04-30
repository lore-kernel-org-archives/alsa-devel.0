From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Correct pm status
 check in suspend callback
Date: Thu, 30 Apr 2015 21:09:02 +0100
Message-ID: <20150430200902.GJ22845@sirena.org.uk>
References: <1430384261-5373-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2766927668637636091=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AACA6266208
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:09:10 +0200 (CEST)
In-Reply-To: <1430384261-5373-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2766927668637636091==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BlZLtSLbY2DC60zw"
Content-Disposition: inline


--BlZLtSLbY2DC60zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 11:57:41AM +0300, Peter Ujfalusi wrote:
> pm_runtime_enabled() will only tell if the pm runtime has been enabled for
> the device, which is done at probe time but will not tell the actual power
> state of the device.
> pm_runtime_active() provides this information.
> This patch fixes a kernel crash when doing suspend when McASP is not
> active.

Applied, thanks.

--BlZLtSLbY2DC60zw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQovdAAoJECTWi3JdVIfQahYH/2f0g66Z5ElzGbGu/25EV4w6
0rzG1jgB/0butw/UUepSmKKaYZ9ijrZ6CfQ1bEIm+1hYj75NqK0Fguvc2FGHVxhV
vYAO525J7ul94ltDxpz1L3bFwFImf+DXr/ea23lY2qrPnbRAxDn4pd1+8jZXzYNe
U319da+L2qy1Qbo9gvnyPZpVNRZbAZAyNgzkcDW6VqDBPieZCdoIk89Baw38G8eT
ZBY+cNPwxsyDboXRfPxE8ji9UmUK6k7L1qTPSw0ldU8Y/Ti83mwMSiP+CV0r25I4
/fu+PMGPmA2o8y+sEtq3o2fLATYwSImS1ngNcam8f1jU3hc0szF9faxf21BN3mc=
=NcYI
-----END PGP SIGNATURE-----

--BlZLtSLbY2DC60zw--

--===============2766927668637636091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2766927668637636091==--
