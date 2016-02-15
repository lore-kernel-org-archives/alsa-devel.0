From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 03/15] ASoC: hdac_hdmi: Enable DP1.2 and
 all converters/pins
Date: Mon, 15 Feb 2016 20:10:49 +0000
Message-ID: <20160215201049.GD18327@sirena.org.uk>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455243375-16067-4-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4538689856907219732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E877C260673
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:54:05 +0100 (CET)
In-Reply-To: <1455243375-16067-4-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4538689856907219732==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 12, 2016 at 07:46:03AM +0530, Subhransu S. Prusty wrote:

> +static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdac)
> +{
> +	unsigned int vendor_param;
> +
> +	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
> +				INTEL_GET_VENDOR_VERB, 0);
> +	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
> +		return;
> +
> +	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
> +	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
> +				INTEL_SET_VENDOR_VERB, vendor_param);
> +	if (vendor_param == -1)
> +		return;
> +}

So to enable the pins we do a read?  That seems...  innovative.  :/

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwjDHAAoJECTWi3JdVIfQ1aoH/3gCWlMqL9VH9qXa5mSn6ZZu
ARF4oqpGCX31CiEZbvyR75i2No6Tj/wX+3lHi0x7LzRTr0ygJ+1gdCmt3MBr3EqW
8qth/mIT9oUezm+8R5HOwSRBGYoIKMKcJpk6ZKPQXLnKxVzaqPUcH89cA6ejjRNy
1h4Hj6QXCBG0MVyw9ageZh25oOskcmssCQ35CG8ak1NaOHSx9mJq2R39uN16NTCi
0dINbHSCFPZ0bZglY87UX90IIEbEBl5oLb8DPWCtma68hJDoIRlN1itmdIftQoOD
2otoh05CI2tUZxOqrb0/fXg4fC3jfWfrdIo/PB633Ll27xuxgu8us+7l7RbSIhg=
=+EEL
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--

--===============4538689856907219732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4538689856907219732==--
