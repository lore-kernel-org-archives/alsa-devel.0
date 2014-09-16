From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 03/10] ASoC: Intel: mrfld: add the gain
	controls
Date: Tue, 16 Sep 2014 12:00:21 -0700
Message-ID: <20140916190020.GB7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7344663922985986025=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA541261A7F
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 21:00:24 +0200 (CEST)
In-Reply-To: <1410255693-6958-4-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7344663922985986025==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O1+DDjaLRatPxzPT"
Content-Disposition: inline


--O1+DDjaLRatPxzPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 03:11:26PM +0530, Subhransu S. Prusty wrote:

> +	{ SST_GAIN_KCONTROL_INT(SST_CONTROL_NAME(xpname, xmname, xinstance, "rampduration"), \

> +	{ SST_GAIN_KCONTROL_BOOL(SST_CONTROL_NAME(xpname, xmname, xinstance, "mute"), \

> +	{ SST_GAIN_KCONTROL_TLV(SST_CONTROL_NAME(xpname, xmname, xinstance, "volume"), \

The macros in here look like they're all going to generate non-standard
control names - volume controls should be " Volume", booleans should be
" Switch" and I'd expect ramp delay to be written idiomatically as "
Ramp Delay".  This will confuse standard userspaces which rely on the
control names.

I've got a feeling this may be an issue with the previous patch as well.

--O1+DDjaLRatPxzPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGIjEAAoJECTWi3JdVIfQIzMH/1q0cBSomlJkFUoH3eDh5CbA
EK1U7q53SkEuM4SH8h9Wbe0Rk9uuZsJhkw0yUUs2okRIxLfPZkhqMAKGh62F3GPD
7cjOhGfSXc1ccaiA5/gJcOWIAWXfLCR+tqMLgu9WBiPfEAjy0zihcbTFQ7uGsqMb
tsVFhPpRwbeOD3E6cXWkqTUDP37UfJLj07NFLA0S3PpuhBkt8oR2e3TI5CSFTwZv
F3icUsW1wkpcie7QlUBaZFTE1uLLnEpXqtxPQSsqsV00B0N/xeRbLGX79lOTKGI3
ssPm337edxPXU8ZdJngaHk+n7vjJhiRiHp2IVzYHrlBcrwjSamdoy+AMP4ijSqo=
=ZER7
-----END PGP SIGNATURE-----

--O1+DDjaLRatPxzPT--

--===============7344663922985986025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7344663922985986025==--
