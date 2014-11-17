From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Avoid attempt to free
 buffers that might still be in use
Date: Mon, 17 Nov 2014 14:22:29 +0000
Message-ID: <20141117142229.GC2722@sirena.org.uk>
References: <1416221301-27819-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4787612596759769070=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10B48262600
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 15:22:44 +0100 (CET)
In-Reply-To: <1416221301-27819-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4787612596759769070==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kncZREqT6Wt3NQEl"
Content-Disposition: inline


--kncZREqT6Wt3NQEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 10:48:21AM +0000, Charles Keepax wrote:
> We should not free any buffers associated with writing out coefficients
> to the DSP until all the async writes have completed. This patch updates
> the out of memory path when allocating a new buffer to include a call to
> regmap_async_complete.

Applied, thanks.

--kncZREqT6Wt3NQEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUagSkAAoJECTWi3JdVIfQLEYH/00Wn2G2Nu1mQC+chac3l8RE
k6FOarcyPRFpx2Bfj7khzgal9pgu6ec0yPaKrz4zuG8Kl0sbDAxwnATmOU2tcPMS
ERlPz13UvsChYBPkkYDjKO9jzGTGG2esPuvIolwIUraMZ7ZMfNmK/cUsZ/IAwCvU
wATdKWkX/rbfbB509niF9A4L4o7/3Y1K2q9xFd+4/4ezWPpYxCCBz3xhoz+lHzti
XfOa6J3TMredh5fcX/juZc03T9BW0dJMI3gepzCv8kksf3n/KZdfL4CpLlIZJ2/W
SMogH26tTmGhclsAlQqCTqA547fDV/CoRbza2zpNhGGl7SamRS41sXLVeYwoLCU=
=dP/H
-----END PGP SIGNATURE-----

--kncZREqT6Wt3NQEl--

--===============4787612596759769070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4787612596759769070==--
