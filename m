From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5663: Fix error handling of
	regulator_set_load
Date: Fri, 16 Nov 2018 19:18:28 -0800
Message-ID: <20181117031828.GZ2089@sirena.org.uk>
References: <20181116092856.47815-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6477873611016480354=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 436A52679F4
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2018 04:18:37 +0100 (CET)
In-Reply-To: <20181116092856.47815-1-cychiang@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, dgreid@chromium.org, linux-kernel@vger.kernel.org, tzungbi@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============6477873611016480354==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gsAOdWNCzgDntp8s"
Content-Disposition: inline


--gsAOdWNCzgDntp8s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2018 at 05:28:56PM +0800, Cheng-Yi Chiang wrote:
> The default implementation of regulator_set_load returns
> REGULATOR_MODE_NORMAL, which is positive.

The stub does indeed do that however that just looks like a bug - the
actual implementation returns 0 on success and the other users don't
seem to expect to get a mode value back.

> rt5663_i2c_probe should only do error handling when return value of
> regulator_set_load is negative.
> In this case, rt5663_i2c_probe should return error.

However that's also true so the patch is valid.

--gsAOdWNCzgDntp8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvviIQACgkQJNaLcl1U
h9BF8Qf/QHncvy21Ygh5WxTV59yvLFIGXBCAio35pWeeQzTdoC7vGJrrst3lA+Ja
23I/AGM8vLl8So9HH1k94IZdq3LuSg9j1u1+AavXwB14Ifyx6oLHrFDuc01+3DhN
v1Jg3v8MDc6LVdTpxEOBO3Jq+75d4PC5zmkmKLcJLQRy1LU3zPhkY2ItT63/KMhi
cSzp0qlg9nF45HiheKbzekFZRw5gq1+9CwJBjanRIsKvokgC+59kssDdyGLVzbWQ
R7aBOEaTEvr1quTET1zZuNtLtq6iRGL3eBXEKsyxzc8nIZmTWdkSX1kBcxW6Xsv+
lFX4RXiLPb/lelT5fFJjGryzep6DsQ==
=O3dQ
-----END PGP SIGNATURE-----

--gsAOdWNCzgDntp8s--

--===============6477873611016480354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6477873611016480354==--
