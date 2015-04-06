From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
Date: Mon, 6 Apr 2015 17:19:39 +0100
Message-ID: <20150406161939.GJ6023@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-3-git-send-email-sbranden@broadcom.com>
 <20150331064209.GD2869@sirena.org.uk>
 <551D8EB6.1050004@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6xTM0kUsJcaNctaW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <551D8EB6.1050004-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazao <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, abrestic-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bryeung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pwestin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--6xTM0kUsJcaNctaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2015 at 11:47:18AM -0700, Lori Hikichi wrote:
> On 15-03-30 11:42 PM, Mark Brown wrote:

> >>+config SND_SOC_CYGNUS
> >>+	tristate "SoC platform audio for Broadcom Cygnus chips"
> >>+	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
> >>+	default ARCH_BCM_CYGNUS

> Okay.

You don't need to reply to every single comment, the general assumption
will be that if there's no other followup all review comments will be
addressed.  It's better to just reply to things where there's something
more detailed to say, if you explicitly reply to everything then that
makes it easier for actual replies to be missed since there's a lot of
there's a lot of the mail that's just going to be skipped through.

> >>+static void ringbuf_inc(void __iomem *audio_io, bool is_playback,
> >>+			const struct ringbuf_regs *p_rbuf)

> >So it looks like we're getting an interrupt per period and we have to
> >manually advance to the next one?

> Yes.

OK, so that seems fragile - what happens if we're slightly late
processing an interrupt or miss one entirely?  Most hardware has some
way to read back the current position which tends to be more reliable,
is that not an option here?

--6xTM0kUsJcaNctaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIrIaAAoJECTWi3JdVIfQiAYH+wVe4O1UcpvFO9F0GnMCsFnF
wJAziQ23f2t2CPa70+UbIMHo5a+EBrAYVWu+GbMPTkFeDwEiWC6baE2nVH9YK7Se
O8zHqXBRdDvqiRgdRd/VJ3o8K/8uCtHV7Lj7Bi0g8A+vEpl8kBNOyGgvMHH4LDmS
QwnkFF+2LmItLyP0IzcnpaQEWhqNx7EvEF3hfz+vLVF8t1Fc/m1/rGyxGWQ0oAwY
BxnypCyvZJMRroMQMt85BSsr4n37J0Q8GKh9dnXAmYzbmmCDdZo8Mw2l2TDxVO5D
PZkRw2f0OecdU1OqSO+F/jNJl8lU1PapcaARfb1NNADqLCyRlEz42Phior7P5Lc=
=Ayjf
-----END PGP SIGNATURE-----

--6xTM0kUsJcaNctaW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
