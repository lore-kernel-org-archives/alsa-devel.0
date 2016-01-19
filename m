From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/6] video: hdmi: add helper function for N
	and CTS
Date: Tue, 19 Jan 2016 17:14:12 +0000
Message-ID: <20160119171412.GP6588@sirena.org.uk>
References: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
 <1453210836-16218-2-git-send-email-arnaud.pouliquen@st.com>
 <20160119165430.GN19062@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5584843794449673967=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CBD4A260588
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 18:14:29 +0100 (CET)
In-Reply-To: <20160119165430.GN19062@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5584843794449673967==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AZ5MDyCEa2UrJyYy"
Content-Disposition: inline


--AZ5MDyCEa2UrJyYy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 19, 2016 at 04:54:30PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 19, 2016 at 02:40:31PM +0100, Arnaud Pouliquen wrote:
> > From: Moise Gergaud <moise.gergaud@st.com>

> > Add helper function to compute HDMI CTS and N parameters
> > Implementation is based on HDMI 1.4b specification.

> You should note that these CTS/N parameters are for where the audio and
> video clocks are coherent: iow, they are derived from the same source.
> If they can drift (because they're generated from different sources)
> then a hardware implementation which automatically calculates CTS is
> needed.

> However, some of the values given in the HDMI specs for CTS are actually
> two values, because a single value does not specify the audio clock even
> with the N values given.  For these, the values returned will not give
> an accurate clock - this should also be noted.

> Next, does "pixel clock" make sense when you have pixel repetition?
> Would calling this "tdms_clock" be more accurate to the specification
> and less mis-leading to users?

It'd also be good to capture some of the above information from Russell
in the code so other people don't miss it when using the helpers.

--AZ5MDyCEa2UrJyYy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWnm7jAAoJECTWi3JdVIfQXzgH/R4g5/4j2jdwldtgdUSDZBjh
7vBZbL+vOR54sb3mnaDsD/yjUaWzdOmDiVBJMZywk+aKppYKL8OdFD70+Q7rbt2S
dDB6lwM5Q/u65CRSXvmM53gGcJK8jZzXS4DXc6ec1upWgHKEKMJxV8jMaxc7aIB7
C8+kup740/LE7uiHZp8GlhAwXt/6SFR8V4IUprI8JpqQV+5L+r9biLnEh5Z3/1mS
gk4LGSFWi1NukrKUAq7uQpvUgjdJEDLnQIWKMrjxeoohPicVv4Xgq71w5QBdZO5/
5mHvn5fwPi6ikMt7k3EOoyAEWtJ7EZQ8r41Kw5Z1l5hIGGcLe7gDHCLijyehqlY=
=Y77Y
-----END PGP SIGNATURE-----

--AZ5MDyCEa2UrJyYy--

--===============5584843794449673967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5584843794449673967==--
