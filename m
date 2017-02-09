From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/3] ASoC: zx-i2s: Add the info of pclk
 to the binding document for zx2967 family
Date: Thu, 9 Feb 2017 16:46:45 +0000
Message-ID: <20170209164645.ztvockrd6jxpybwt@sirena.org.uk>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
 <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8291900429910483052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF7B526680F
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 17:47:14 +0100 (CET)
In-Reply-To: <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, xie.baoyou@zte.com.cn, mathieu.poirier@linaro.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, shawn.guo@linaro.org, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8291900429910483052==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yjha4dq3tcbnz6ty"
Content-Disposition: inline


--yjha4dq3tcbnz6ty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2017 at 11:12:57AM +0800, Baoyou Xie wrote:

> - - compatible : Must be "zte,zx296702-i2s"
> + - compatible : Must be one of:
> +	"zte,zx296718-i2s", "zte,zx296702-i2s"
> +	"zte,zx296702-i2s"

You've added the new compatible twice here?

--yjha4dq3tcbnz6ty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlicnPQACgkQJNaLcl1U
h9BQUwf9HQ0uWD5sKqWGdLs+K9rGxgRqp8LRGfHOL4Z8xomixnmyGJ4jXoe1Onzt
wyPuldTpT2j3dyswUN31M46vLT5p3NgZBiW3vIEMprDDv4n/NTM6nRMXhvNoCt09
+0gN13p0ndUUve6+br1dnW+KmULE9FtEQbWojcwMNFH1o+ofVXoyHsWn/qAgLWrN
iMXEh19got4kspm1eezacV3YdLgVSzeVi9e56YYt8dyRbpxflAK9uFKduIC6NPuI
Iq+3BwPSb2HmNIcH/6Hceca5FGyqPkWltMT/ej3WOO/ZGVZcQdkPAzZFVUvv5QRQ
Nmm1BYGLC7RMSfvFmzQAodEjXVuWsg==
=+uIv
-----END PGP SIGNATURE-----

--yjha4dq3tcbnz6ty--

--===============8291900429910483052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8291900429910483052==--
