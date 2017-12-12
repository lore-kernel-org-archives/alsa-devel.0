From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] ASoC: codecs: tas5720: add TAS5722 specific volume
 control
Date: Tue, 12 Dec 2017 12:01:21 +0000
Message-ID: <20171212120121.GH16323@sirena.org.uk>
References: <20171211190157.12371-1-afd@ti.com>
 <20171211190157.12371-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171211190157.12371-3-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2017 at 01:01:56PM -0600, Andrew F. Davis wrote:

> The TAS5722 supports modifying volume in 0.25dB steps (as opposed to 0.5dB
> steps on the TAS5720). Introduce a custom mixer control that allows taking
> advantage of this finer output volume granularity.

Don't do this, it's just making things more complicated.  Instead do
what other drivers do and register different sets of controls depending
on which part you're working with.  The normal thing is to have a big
table for all the shared controls that are the same on all variants then
register additional tables during probe with those that vary for the
individul devices.

>  static const struct snd_kcontrol_new tas5720_snd_controls[] = {
>  	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
> -		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, dac_tlv),
> +		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, tas5720_dac_tlv),
> +	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
> +		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),

As ever all volume controls should end in Volume (like the immediately
adjacent control does).

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlovxRAACgkQJNaLcl1U
h9A+9gf/TW9OpE3YpXKvZJCM8rhEGkaTT8A5WF7sxUyN61s/nRMFHk0jKjltWcSs
JeIOsqa2BPxPX97QkwXvdxRM3LZf1sfQVhtmsLvfDpa41EyP2Pcn71lK43ZnmeDh
iPiy8sy/wGZ/1eEG0LWsVH9oH0hcmger4zDLSUYKUUVb4dMXy2r3ZNywSpimXxSd
G+B1hNzbrnOPsI8H0uLyDkJ8JFQAqQcm8G8mJEEknM2gko6qM23lRvSApxhufWKD
h9X3ZDleo0dQmmmX7R0dxdYGeq/28DT1Gz7UNWvx+MHmEhH66neQuxkj2w4CrYDL
RfENqmwLnkrEVsOLirs2HrBwdoV/uQ==
=1cTK
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
