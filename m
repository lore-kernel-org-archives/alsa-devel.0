From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: allow multiple interrupt sources
Date: Thu, 4 Apr 2019 12:32:00 +0700
Message-ID: <20190404053200.GL5748@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190402050236.GV2059@sirena.org.uk>
 <CAN-6NYaO0bah_vFgTGrnU5_pUM95B+voDxsUR6K6o5wj5ZRD6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Jl+DbTnyraiZ/loT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN-6NYaO0bah_vFgTGrnU5_pUM95B+voDxsUR6K6o5wj5ZRD6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
List-Id: alsa-devel@alsa-project.org


--Jl+DbTnyraiZ/loT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 03:32:04PM -0600, Fletcher Woodruff wrote:
> On Mon, Apr 1, 2019 at 11:02 PM Mark Brown <broonie@kernel.org> wrote:

> > This looks unrelated to the polarity of the interupt?

> Yes this is separate. If a plug/unplug happens after regmap_read and
> before regmap_write, it will not be registered, so we loop to make
> sure that it's caught in a later iteration. I can clarify this in the
> patch notes.

Please submit one patch per change, each with a clear changelog, as
covered in SubmittingPatches.  This makes it much easier to review
things since it's easier to tell if the patch does what it was intended
to do.

--Jl+DbTnyraiZ/loT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylltAACgkQJNaLcl1U
h9AcpQgAhQoDgeHNiUlHeU0PJoxiogKu9AGs2BjWc1nxPz7wc8b+m1nXie49QDIW
4I146o6NR3lHRK/wYNKMAVYegAx2Zl6aq2jlzcOagg0DQW7AxYnZ2QZqv9q6iOZ7
LkjqeEKTE9xoncKyjYRyJQ52KAyeEh8c61AXzMUUWbKN4pOfXWYb7oX7DEI7Nk04
yt63rjdiDv+R9hNw4vyFt/gV/LyGWcHcHlfhQV0LCKVPwFX4328aZ/XA1lpFlX+6
9B/sj3megqEG2lRajQeUsEitb4M7RU8BpR0TYJfQPW9mW13+AD7FmLD0PeHgS0oh
ZuAmSf0Kmxp/zymL4h2dANsiAHE2DA==
=PlIW
-----END PGP SIGNATURE-----

--Jl+DbTnyraiZ/loT--
