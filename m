From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: dmic: Add optional wakeup delay
Date: Fri, 16 Feb 2018 11:28:01 +0000
Message-ID: <20180216112801.GA5886@sirena.org.uk>
References: <20180216022416.208265-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180216022416.208265-1-mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2018 at 06:24:16PM -0800, Matthias Kaehlcke wrote:
> On some systems a delay is needed after switching on the clocks, to allow
> the output to stabilize and avoid a popping noise at the beginning of
> the recording. Add the optional device tree property 'wakeup-delay-ms'

This doesn't apply against current code, please check and resend.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqGwEEACgkQJNaLcl1U
h9AhxAf+OMp8YPVcDHKlQ9hvGMp+Wo5/kt05Z40IG95300cIdm2LWq4nbvpkTbsH
FyI/cqShtZ/6dX+xoJtp2VPu+SHoGEQkrS07bCPHCMFaAWSlf4MEMi9Xt0KwWRSv
UtVaheEedTwRL+VlLFWXGy7/6GhPM33TFxk09cmOXNBD0a46AxEwynkbpJlwqtac
R4dWBo5rV4r5T8J8EWvPBy52e+ClsDJRgQDnvr6wvmkTPiH0xlQO8LMWF9wPUg8y
LJD9JXlWEC6mfSQ6c7TndyX0g0/inQ36/nus5Dawhbcq9d/hBALeSPzIg7PBt4PX
rnVsyymY7JDWcnl4pz97uyVbOTfFUw==
=DPeM
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
