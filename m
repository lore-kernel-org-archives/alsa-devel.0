From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5514: expose Hotword Model
	control
Date: Fri, 25 Aug 2017 19:59:44 +0100
Message-ID: <20170825185944.j7forf7ene72t23n@sirena.org.uk>
References: <20170825170947.32241-1-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0186281138137012628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E33B6267885
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 20:59:45 +0200 (CEST)
In-Reply-To: <20170825170947.32241-1-hychao@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0186281138137012628==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2evie4gvqow43ypc"
Content-Disposition: inline


--2evie4gvqow43ypc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 26, 2017 at 01:09:47AM +0800, Hsin-Yu Chao wrote:
> This change exposes mixer control 'Hotword Model' for switching
> hotword model in runtime. This new function requires updated
> firmware to load hotword model at address 0x4ff80000.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--2evie4gvqow43ypc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmgc58ACgkQJNaLcl1U
h9B52wf/RRXrvLVCv+87MDGct7FpZk7oUpV0OVaAahuU86+PQ0UekqG3IAwcBq1Y
OyOkIhRxP62Jsgy+BihZskBfMjXvvn+fFemNywIMRnR+BZ9NmrzJpZWa/fsfKsea
Jx2TKdA2fYCrIjMCJKBLA2u4bvCWuP/cOHV+ZGpTJg7PSqq3ZGNonFDc0UgLHZqc
g0thNhakXJp4S8Kw3wiMysb1j+V4pV819Lm7jaCnEKrkSYf6OuqvL10Yo3STqZQW
FCatHybWIyftH0hYOIdXm1gS8KHy5Ar7SWaUm3QA9TcFf5LUIvN9QgjogFiLz9S7
joGC8uMshmBtfzljWjNbyUymCLr9pQ==
=SjU/
-----END PGP SIGNATURE-----

--2evie4gvqow43ypc--

--===============0186281138137012628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0186281138137012628==--
