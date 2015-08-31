From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Make SND_SOC_STI_SAS depend on
	RESET_CONTROLLER
Date: Mon, 31 Aug 2015 09:59:42 +0100
Message-ID: <20150831085942.GH12027@sirena.org.uk>
References: <1440982353.8335.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2849375612979475797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C890F26063F
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 12:24:46 +0200 (CEST)
In-Reply-To: <1440982353.8335.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2849375612979475797==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CIYYUxfZfIgkhRLs"
Content-Disposition: inline


--CIYYUxfZfIgkhRLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 08:52:33AM +0800, Axel Lin wrote:
> (devm_)reset_control_get function is available only when RESET_CONTROLLER
> is set. Make SND_SOC_STI_SAS depend on RESET_CONTROLLER to fix build error
> if !RESET_CONTROLLER.

Ugh, no.  This is not good - the reset controller API should be stubbing
itself out like other service APIs so that generic code can work with it
without lots of ifdefs.  It's a similar situation to regulators and GPIOs.

--CIYYUxfZfIgkhRLs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5Bd9AAoJECTWi3JdVIfQjQEH/3A3ww+WuHHAM5P1uUWTvgso
YTeTy44twf9pzkx2SOB4WzQTARB1Xi7Z6somRUp0ir3D/EOsIVqHkTStaWA0Rcdt
orChcottKxC+fnIAA09u3uSrhtI3AeZ37AFz3g596uiFg+aPN5Gx6oSfZAzQmhva
lGs5e83WlTR4/3ZfmLBiKOQNkeFt+lkmiO6n+ww/0O3VXDovP6RVLh5rhGVJfUTc
HnWh2R/PM5yr7gV8Nd4F1bXyIOQOFImIr1ljralwhdoQqVbBzDiodjO+ahtfMxM8
EaR0RvsAOgxAEN8APCcTsSFtO6BChs3ocHrmFNTxfDU0Pp3Zeu0RZQlrexl1IyI=
=LNxh
-----END PGP SIGNATURE-----

--CIYYUxfZfIgkhRLs--

--===============2849375612979475797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2849375612979475797==--
