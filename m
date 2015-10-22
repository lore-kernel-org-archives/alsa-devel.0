From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: soc-compress: add config item for
 soc-compress to make it compiled only when needed
Date: Thu, 22 Oct 2015 13:51:46 +0100
Message-ID: <20151022125146.GK8232@sirena.org.uk>
References: <1444750860-19355-1-git-send-email-yang.jie@intel.com>
 <20151014092051.GM8805@ck-lbox>
 <E7B1D079BA13FB44A978CC8F69C7D6A9229C6351@SHSMSX101.ccr.corp.intel.com>
 <20151014124659.GN8805@ck-lbox>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9087815715928974672=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E09E0266D17
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:33:44 +0200 (CEST)
In-Reply-To: <20151014124659.GN8805@ck-lbox>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9087815715928974672==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qo8f1a4rgWw9S/zY"
Content-Disposition: inline


--Qo8f1a4rgWw9S/zY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 01:46:59PM +0100, Charles Keepax wrote:
> On Wed, Oct 14, 2015 at 12:57:38PM +0000, Jie, Yang wrote:

> > Hi Charles, we used compress_dai bool before(in v2), but for that we need
> > add empty inline soc_compress_new(), Takashi suggest we use callback
> > func pointer here, it can be compress_new or any other creation here.
> > This is flexible and can be extended if any new stuff has to be handled.

> If everyone else is happy with it, then I don't mind. It
> obviously works, just felt a little odd to me.

Yes, it's not very nice but it does help finesse things.  :/

--Qo8f1a4rgWw9S/zY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKNvhAAoJECTWi3JdVIfQM4cIAIUeTRg+1W+QZHQWU2yXMeXT
i+ggNY7tSmSWj7dE87b6naN/80ctdHx1R6GKS0DICmUEP3vQsQ9hZ6Y0wB0tYlWJ
tm44rZbFuPkacJ9R9dcDIG30enhK+hbD9P0YjKTQfKThevQChBCps/OIgio56yif
I1ekM6xR8L7QoGBhKM7GChIvSuhjazky6rvf/eIu/jBpLE7ECb7Dn2dnZmgMjUcO
RGFztKSAwdSUxCRej92GF0RJUC9+HwD6OvLJuzAx17en/hASsXAKsKyn6bzuO5OI
FxACBhLDaD3DjsKb/fQ3g1VboMY6n9q4D4HBQFmFiSsZhNDGXDurDm6SmKDdsUA=
=k/Tu
-----END PGP SIGNATURE-----

--Qo8f1a4rgWw9S/zY--

--===============9087815715928974672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9087815715928974672==--
