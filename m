From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Add master clock handling
Date: Thu, 22 May 2014 19:19:48 +0100
Message-ID: <20140522181948.GP12304@sirena.org.uk>
References: <1400750228-13750-1-git-send-email-tushar.behera@linaro.org>
 <1400750228-13750-2-git-send-email-tushar.behera@linaro.org>
 <537E1D0A.6020303@wwwdotorg.org>
 <20140522173403.GL12304@sirena.org.uk>
 <537E38FF.9000407@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RPs4rtJ4g1RMOHUG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <537E38FF.9000407-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, jerry.wong-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--RPs4rtJ4g1RMOHUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 11:50:55AM -0600, Stephen Warren wrote:

> I think we should nail down exactly what set_sysclk() means. Since it
> takes an explicit MCLK clock rate (rather than e.g. sample rate) right
> now, surely it's a notification of what the clock /is/, not a request
> for the CODEC to set up its input clock. If we expect the CODEC to go to

It really should be that from a device model/clock API point of view and
it certainly is with the patch proposed, the fact that it happens not to
have been is just a product of the poor clock support in Linux than
anything else.

> the clock driver and request an MCLK for itself (e.g. based on sample
> rate), surely that should happen from some function besides
> set_sysclk(), with different semantics e.g. hw_params().

I'm not sure where you see the CODEC going off and deciding the MCLK
rate itself here?  Essentially all that's happening here is that
set_sysclk() is behaving like the clock API does and setting its own
rate to what it was explicitly asked to set, including bouncing that
request up the chain.

The rounding could go if we wanted to be a bit stricter - if the machine
driver is doing a good job it should never change anything - but
otherwise I just can't see what you're concerned about.

> I'm not convinced that the CODEC can trigger its input clock changes in
> general. In Tegra, there needs to be centralized clock management, e.g.
> to prevent one audio stream using a 44.1KHz-based rate and another using
> a 48KHz-based rate. That's because the main audio PLL can't generate
> both sets of frequencies at once. This can't be done in individual CODEC
> drivers, since they shouldn't know about the Tegra restrictions. Doing
> it in the clock driver in response to the CODEC's request for a specific
> input clock, might work, but then the CODEC would have to call into the
> clk driver from e.g. hw_params() rather than set_sysclk(). If that's how
> it's supposed to work, then this patch is adding code in the wrong
> place. If set_sysclk() doesn't get removed from the CODEC API, then
> doing all this clock setup logic in the machine driver, as the
> tegra_wm89090.c machine driver does, seems to make the most sense for now.

What you're describing seems to make things worse not better for your
problem?  I'm sorry, I just can't follow what you're concerned about
here at all. =20

The current situation is that the CODEC just gets told what it should
run SYSCLK at, all the patch does really is factor out the code to call
clk_set_rate() on a programmable parent clock and look that clock up in
DT.  Both before and after the patch the CODEC driver takes no decisions
on the rate.  If we started doing things in hw_params() the CODEC driver
would have to start taking decisions since it would only get the sample
rate and so on provided.

--RPs4rtJ4g1RMOHUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfj/BAAoJELSic+t+oim9M0QP/2KUorIJwGQvrPQqbjnncM7o
oy5sifPDfRzWuZ+FKKG8yb7p9p3UQnEks7hnxfMY+YNaajEpRcE42yhx84ZHP2ge
ZMkI3iCNyT0drzPquNUB3d5+iXSeg7S5MpFw1jZUIrMxE40ktHWpjtaZZaEqIwxt
LtG8stHSw8JANF8bCD78QlAGPyV+hXOocvX2GGe8wRVGv/Fvz649TX9mtDG7JvxO
XTHb22ixxsE5h200lTdEYrD7TIOyueNFlfkApxouXaONGiPZ5V/UdqCXIQsvy7LZ
+2BEGo/y1e/crjiGb4gu3pr/AWONJwyZHmioytvBXrtyjAePh4rDSvJjMLEU7Y6S
skHS8GGjQneiWFZllxADwkCdI1M6NNwL/DlgXE5MhaS/4WtxhgQDn6PTnENLOm1F
cxMFkmtwzui3hwfPVXOAY7XgjGB9pIF5hyZIaIHsfLPUumcDQkY9rq6iO9Pqx/ij
0C+G8TrMTEFN46fhA4O5/aS5vRO4rUXEF7bMYWiIGlAWBUwUJnR4v7bZ9v9Oc8ep
GKc7KlPc7mdmEF0eGlB17hi4S0Mo1hLGF4uFemhoauDAluTMKWm6ZGhYurpJRYjJ
HDWznlbmCHNkwiJE8vEWA2kNLypzossHHvgkvaSplUlzdTsXqx2lbp6rMaE7INb2
OkXptd6bvrrNnsqu7J4I
=Uxz5
-----END PGP SIGNATURE-----

--RPs4rtJ4g1RMOHUG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
