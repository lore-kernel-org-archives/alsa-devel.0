From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: use a more
	common dma name
Date: Tue, 23 Apr 2013 11:35:00 +0100
Message-ID: <20130423103500.GE5019@opensource.wolfsonmicro.com>
References: <1366638525-27625-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5606961834980685498=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E03B262632
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2013 12:35:02 +0200 (CEST)
In-Reply-To: <1366638525-27625-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============5606961834980685498==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 22, 2013 at 09:48:45PM +0800, Shawn Guo wrote:
> The examples in Documentation/devicetree/bindings/dma/dma.txt recommends
> the name for dma channel doing both RX and TX to be "rx-tx".  This
> becomes a common pattern that has been adopted by platforms that
> converts to generic DMA bindings.  Let's follow this common pattern in
> generic-dmaengine-pcm.

Applied, thanks.

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdmPNAAoJELSic+t+oim9AxoP/RzN+QpuTS7OwPUedtAcTzLh
nAu2ypDQzmQemUDWYPehEeoL4lKWJCFvvpuFRThnWVXvOEH+B3PNRbtu0un9Jr96
pKEWz1gvVDryQ/EyL32VZQtq7GQSgcdiccvjqKOY2ANdb+AVF17C4SObGAcekhmW
q0hNRw7YTfEzWHtqKelRWrr9Q9GwUXFEMqkW7cZHeihoiTmMxza2jQDgVhxraLHC
myLaKiWAry957iTdzJeYLX+o++Xemp11/8YgmoDF96qssetPenpAcoQoqkkpIxTh
6DvIFWKvlv0M+QZl8vYGlGp4Pk8Vb5yo8mqXFAd1tONavjHwWC7coMkSaV/DQo2z
iEgqfIPwS2YJoTEIw0/GcuguJBPB8EoQfTYSqPurdhaCvw9eXOCU4VCV2oDGCxrM
LEfUi2VMaBgbQ+xWBndprDyFuUtsq82gRdljE9Yfzl9snxEu2j2wfRcSZGZg/W5K
Xygy4wO1qGDY+xiFf6tFv/9rEIL3Pnn4LkibtlVomjWSNpUtcZ6D7jfpRbZi4LPE
yI3YXMKAtYVgokTqwovOG+QOuAyvR90htWZLea10378H6AQAy22jfaPSJrILtROC
5BFnCNVTHhF8yppVmHFr8I+koSwOs76UUBs/F5HmsfbD/SK7MxGvGqHdsA5Slad0
VcEj6mWZAoRK93lIB4aZ
=nOkF
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--

--===============5606961834980685498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5606961834980685498==--
