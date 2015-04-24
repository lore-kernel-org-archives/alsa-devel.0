From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 6/7] ASoC: hda: Add support for SSP register
	settings
Date: Fri, 24 Apr 2015 18:55:32 +0100
Message-ID: <20150424175532.GD22845@sirena.org.uk>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
 <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2138857302725407095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A81E2605CE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:55:37 +0200 (CEST)
In-Reply-To: <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2138857302725407095==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3VAGlhU1mHlEoLqg"
Content-Disposition: inline


--3VAGlhU1mHlEoLqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 19, 2015 at 02:27:32AM +0530, Vinod Koul wrote:

> +	req_bclk = fs * slots * s_fmt;

We have a helper for this.

> +	dummy = 0;
> +	/* Find the lowest bit clock possible for particular configuration */
> +	do {
> +		req_bclk = ((s_fmt * fs * slots) + (fs * dummy));
> +		mod = HDA_SSP_MAX_FREQ_192 % req_bclk;
> +		divisor = HDA_SSP_MAX_FREQ_192 / req_bclk;
> +		if (!mod) {
> +			found = 1;
> +			break;
> +		}
> +		/* Dont add odd number of dummy bits, since I2S requires
> +		 * dummy bit after each slot/channel
> +		 */

It does?

> +		dummy += 2;
> +		if (dummy > (HDA_SSPSP2_FEP_MASK >> HDA_SSPSP2_FEP_SHIFT)) {
> +			dev_err(ctx->dev, "Dummy bit greater than what SSP can support\n");
> +			return -EINVAL;
> +		}
> +
> +	} while (divisor > 0);

Aside from the limits this all looks like it could be generic?

--3VAGlhU1mHlEoLqg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOoOUAAoJECTWi3JdVIfQNBwH/Ag6m1ZLAlZL1cSSPuOMK8pn
/RZCYVsmITuP8GPB3L3gVHUWWT7F5FlRWxZhxlQUz0xdo7jnpsZWMhkEoV/DyXhr
yu384w/8lrwcMJux0fGHTcmY+6w7LhsRZ3+QQrAwgxOHIx2QA0cPavf3X9t2m1XC
/GteEeHRTzz5v/lWyHrc+NcaCGbhzCBhVw4iisBY3ABJqrzwNIDa0ZrbudDRya81
VAQH9TdpLpbpwDbHvlFKYyxc5h2gQudvxgg+l3IjDC6DaqScUKtn3n64cy60AV06
5k/Xv0lxHpKoZxJ7aozYdraQ/9tkqX61954ORiKp2pLyImsYP4j/k20wnyB0Dl0=
=hjgz
-----END PGP SIGNATURE-----

--3VAGlhU1mHlEoLqg--

--===============2138857302725407095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2138857302725407095==--
