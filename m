From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-pcm: No need to set constraint
	at open time
Date: Tue, 5 Feb 2013 13:55:16 +0000
Message-ID: <20130205135516.GZ4720@opensource.wolfsonmicro.com>
References: <1360068219-32156-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1002350551691557562=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 911042615D7
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 14:55:18 +0100 (CET)
In-Reply-To: <1360068219-32156-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1002350551691557562==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+vcRm3WFmV0Q/ShD"
Content-Disposition: inline


--+vcRm3WFmV0Q/ShD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 05, 2013 at 01:43:39PM +0100, Peter Ujfalusi wrote:
> The same constraint is going to be set in the snd_dmaengine_pcm_open()
> function, so there is no need to set it here as well.

Applied, thanks.

--+vcRm3WFmV0Q/ShD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREQ89AAoJELSic+t+oim9MLYQAIpngSe/ZnfhGqNzhFCul4It
yaY2xum9pV7CKDyq9sjpjPzP/sNXh2ygmJkP4CFlM9cSOXv+6CQS1wjnuDPzbUgM
q/c57GGDQS3Ht7hZA1ZW4Dbe6FcV+aP8uc1SSWi/Av4O4Xq8p/2pH++cXzk8oQwt
akb/wNYFBkJs3nkSUt1xNFeXPAfX3AE7Pqs4TixIYysYZoEGBkIEYl7g7Jlg1uyh
sydh1TFNqXlyBFuP9BWvfnI3OK4wdA2UKuhCKTuz4NiYfsDUg66iWbr1la73oWQW
ROiV4tFR59gOrrpWAFcnxF/prvW5/2j80VBp1rHDemXI6zJZltm1DUEgS8uRZcau
tcajpy2Xe7KyOJcZodQDgO1/xS2VR9iNeKSLKM8AC7LlzdpVdomDoi9lZWdEX7xw
1iIdAnAf2Pm33s1FFb62KRvuE6rLVCPOsCtOgywhBGqCHeN0oNhhmHE7mYhV2sKQ
VnyEJNpn2CQMdNALNS5VhsRxSTFM8+26ArMDUfna4mBrpTEZRCf2SjLClM5/NA+u
CEl5e9ZWeEui0gzsdePlj/H3x+meikFYLymp8kdwLHEvyHjkexjfoDGsTYpKqiQj
/LUD9kct9RF5QRFM2uXS8KpUEk7wqyb+jYE8CXzc0hB2GJoLIInT5p0RmVEc+MYV
24K1nwSIYn+R4BhfAIvT
=QZEX
-----END PGP SIGNATURE-----

--+vcRm3WFmV0Q/ShD--

--===============1002350551691557562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1002350551691557562==--
