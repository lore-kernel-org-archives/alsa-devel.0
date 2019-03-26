From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2 v4] ALSA: pcm: anonymous dup
	implementation
Date: Tue, 26 Mar 2019 14:09:28 +0000
Message-ID: <20190326140928.GC10898@sirena.org.uk>
References: <20190204093910.23878-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2252311206360288235=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CA82F80760
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 15:09:31 +0100 (CET)
In-Reply-To: <20190204093910.23878-1-perex@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Zach Riggle <riggle@google.com>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2252311206360288235==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 10:39:08AM +0100, Jaroslav Kysela wrote:
> This patchset contains the anonymous dup implementation with permissions
> checking for the ALSA's PCM interface in kernel to enable the restricted
> DMA sound buffer sharing for the restricted tasks.

Is there any news on merging this during the current development cycle,
or anything else needed to move this forwards?

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyaMpcACgkQJNaLcl1U
h9ATwgf/UntkaE0Lfaq80iEy8dMUJUb8f90TSetk/ENDnyduPBgV5yLzKQytTUVx
IhG3xxGDyfmYr3kfhfwP1+BX2I1arNIOdYzjsFoc1lwYRHr9ofgfrJhdeleV36ch
tNQ22K7XOd01NTQlltJmYoW6OlgHH12SvQEO1WVz+vhW2LSvTj8ilaFYC0Ys3K9N
a5W1RCC2rbYUjY9oxtoAK+HjB8NAecn4tYXiFOnxP6+1z90yUN8CSWEakFNDVPvt
ZecscvLiJMDhe0NoaKCrPh/NYTC9Tp/fizNOSm2fuNSaQpF7B/CXebcwA/FF5kZX
zKWLVQ6A01ugBNzfSIKDLsJ+QRV0Iw==
=7OU5
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

--===============2252311206360288235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2252311206360288235==--
