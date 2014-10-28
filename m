From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: add xtensa xtfpga I2S interface and
 platform
Date: Tue, 28 Oct 2014 16:04:14 +0000
Message-ID: <20141028160414.GY18557@sirena.org.uk>
References: <1414436825-19416-1-git-send-email-jcmvbkbc@gmail.com>
 <544FBD20.5000604@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bLzFIlwpOfW+4Y/z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <544FBD20.5000604-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--bLzFIlwpOfW+4Y/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 04:58:24PM +0100, Lars-Peter Clausen wrote:
> On 10/27/2014 08:07 PM, Max Filippov wrote:

> >+	if (tx_active) {
> >+		if (i2s->tx_fifo_high < 256)
> >+			xtfpga_i2s_refill_fifo(i2s);
> >+		else
> >+			tasklet_hi_schedule(&i2s->refill_fifo);

> Maybe use threaded IRQs instead of IRQ + tasklet.

Is that going to play nicely with the fact that the interrupt can be
shared and the desire to (AFAICT) do NAPI style stuff with the interrupt
disabled for long periods?

--bLzFIlwpOfW+4Y/z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT759AAoJECTWi3JdVIfQB8EH+gPB7Aw0ccJppeaG9EnsnvlA
AP7CSMwz+XSZPgHeYFJEZt1/adzlrGF3rmjT5EFZHx7Sc8OtKBmrntQT850iw/iZ
6ju53/DKyzXspepZgs6wv1X1VueMC05F5kMMlO2EW79H/GSX1CpJL/wWQ/RXI/A/
1X13J9oOOEkiMxoD3a9BCb2VqXS0M+160wkCqLKerbiqoSQSG6/62DrztYI0UY1B
0bk6cSpiLQmGBOlapor2dJY0JntTuTG7Lwgt4NemAFhyW9OiwgXBrk7i2NXu4mLk
mj483xwwzbG5RTDCfPy6n4BmzQRKDCmPVWNTAFAIBLvi9zCCmIrfWUUKCJ6NveY=
=RcMg
-----END PGP SIGNATURE-----

--bLzFIlwpOfW+4Y/z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
