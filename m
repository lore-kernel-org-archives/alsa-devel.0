From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Prevent the pop sound of
 the headphone while rebooting or shutdowning
Date: Thu, 27 Aug 2015 20:17:22 +0100
Message-ID: <20150827191722.GK5313@sirena.org.uk>
References: <1440659691-1835-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9079441421693689135=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7815260592
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 21:17:28 +0200 (CEST)
In-Reply-To: <1440659691-1835-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============9079441421693689135==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nhAUiXSLan16V5i8"
Content-Disposition: inline


--nhAUiXSLan16V5i8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2015 at 03:14:51PM +0800, Oder Chiou wrote:
> Add i2c shutdown function to prevent the pop sound of the headphone while
> the system is rebooting or shutdowning. It de-initials the jack detection
> function, and it cannot be turned off in _BIAS_OFF. If we don't de-initial
> it, the pop sound will be heard in the situation of powering off. And
> replace the related register settings from magic number to meaningful
> defined name.

A comment in the changelog is useful but I was really looking for one in
the code here so people don't need to dive into the logs to understand
what's going on.

--nhAUiXSLan16V5i8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV32JBAAoJECTWi3JdVIfQLEEH/AkyzOPTbxB1F+ya7XaFcmhM
999DyiLYIB1Tw2bOC2dxUB/ZzDocZeYxayASoqEnkr8DudJsdvWhODfjUSVvZLRi
GN/CGHc4Zg6MnGUBONfq7sNZhNjsKVlVESL99SmW1qGwig9HKIHmj6I/cH5y7MU+
b4VBG2Jg49JWKVb/mfUHuJYxjDlwu2M1imKwdQZkB6QBoo1fbs3WF715ogtU3fn/
kZWCX8IUoJbFyCstJLHwXgNhMDfNqU/E+4U5dzuXW/vf7egWq2EfvWeiGkjS6YfP
+m2MTVOV9+3zi/uux80ZjN9gZJTquflW9EziGmhFRBIpTXbuQUgA41Q5IW8ru0k=
=mNf/
-----END PGP SIGNATURE-----

--nhAUiXSLan16V5i8--

--===============9079441421693689135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9079441421693689135==--
