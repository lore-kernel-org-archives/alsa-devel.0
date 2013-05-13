From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs: move to use generic DMA helper
Date: Mon, 13 May 2013 09:18:46 +0400
Message-ID: <20130513051846.GC6836@sirena.org.uk>
References: <1368421836-7261-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7450530594610158746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 12ED4261ACC
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 07:18:51 +0200 (CEST)
In-Reply-To: <1368421836-7261-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7450530594610158746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2013 at 01:10:35PM +0800, Shawn Guo wrote:
> With mxs-dma converted to generic DMA bindings, let's move mxs-pcm to
> use it by removing flages SND_DMAENGINE_PCM_FLAG_NO_DT and
> SND_DMAENGINE_PCM_FLAG_COMPAT.  As the result, those mxs custom dma
> params code can be removed now.

This doesn't apply against current code.  Looks like a simple thing due
to pinctrl updates but please check all the dependencies are merged.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkHetAAoJELSic+t+oim9EJEP/0UEK+utTYSwMpB26EUxny5l
JPKRJKLkt4g0SLcP8gor2rpMTXujr19ZCei4HvL+WRrFn/3bq2s9ZoeOioAbkTQS
+/YvEAEuI1YozLEQg/GRCr2jw67nTchrSW6gjOBiLb2DaOdg6QYVIJI72ilryue7
+Xu6u4+x4EKL0RXPNobqEXKE4eGuHCjg/48IAH5vXIlXuR9BqmqAvZ3UXhrAsrDV
IbsezVwTo+ylwcsiv4BEtAv0yAPvVTgK+dw+Ar4+LavgMjaFkpV7i9klQ6Vzla5G
X7XzAttVgGAEkZAnm6OeRthYhPXbpa9+Xnij6te7Mn0LLwy0us5UPWuxl+gkF+ti
sT0dVFihazje7R2HThQvs5JPDGQ9povAr3ylx2K7KadwVRdnjfyRMIh2OFynUQRa
zaEDR8bVH4p48BAtk+a5nIY5UAeKQjnIcHJxpF4fjU8dHGwZyuoL6VjpSVo85kv+
1In1VsnWhhvzch31tlQUpBQRDUU6E7sCzAbMlET51BPOEvLfRtOeumt1dLPAx3TX
y0UBJXlC9mY4zReqMgTlS8hQsLojTgViWgDu5p3vDNn9X230dFR6SDRuPVl12C3O
A+xLsZthwqFwbgfM3MtSuQjinXjlyaUPRB1q6Z742lRh99dvlPQukVqqmrcKIIqB
oYLSrTP9ETo1cMID067E
=Uc/R
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

--===============7450530594610158746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7450530594610158746==--
