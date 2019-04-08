From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: rt5677: allow multiple interrupt sources
Date: Mon, 8 Apr 2019 13:10:14 +0700
Message-ID: <20190408061014.GG2803@sirena.org.uk>
References: <20190401205519.34023-2-fletcherw@chromium.org>
 <20190405204257.87095-1-fletcherw@chromium.org>
 <20190405204257.87095-2-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190405204257.87095-2-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 05, 2019 at 02:42:55PM -0600, Fletcher Woodruff wrote:

> This patch allows headphone plug detect and mic present
> detect to be enabled at the same time. This patch implements
> an irq_chip with irq_domain directly instead of using
> regmap_irq, so that interrupt source line polarities can
> be flipped to support irq sharing.

This changelog still doesn't explain why there is a need to open code
this rather than having the irq_chip and irq_domain provided by
regmap-irq support whatever is missing here.  You said it "needs its own
irq regardless for hotword detection" but provided no information on why
this is.

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq5cMACgkQJNaLcl1U
h9Di0wf+NBjf+bFwqw4oq6RJZ5iGyPABszKGZis/h9oAn8BEh3w5HkteApE6b7vj
2/6OXo6qqVxeRfdC8heAQyGILTpvYuo+HaUKy+JqDqh98fCKBQ53LeE/9i63UewU
DlTI6RY0/cF2dvg6H5hsmp7AGnf4khVtpBh1UoiCKb90i/jZX7BDKmIIBbgVC9iN
pyT5MZvTIVENmidN49e8GnvoVqOvPPEfRDOKiDsEJ+oFHLG39V7K7vbFW/aU9x76
LuXfwIYk6vsBDsPaMl6P6YLBYCuYaONgYI3/XUSFAh5nI6NMeBmgTZQwiq7b3r2v
EFZRpLqZ6TJ7ajDLwJ7mHQWufl0AaA==
=Svc4
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
