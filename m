From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: dmic: Use channel map for
 configs with a single mic
Date: Fri, 5 Jan 2018 12:04:55 +0000
Message-ID: <20180105120455.GA9076@sirena.org.uk>
References: <20180104194848.198941-1-mka@chromium.org>
 <20180104195438.GA200397@google.com>
 <295ce358-c00e-74ce-50c1-1df32c2c6cf7@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4680387216041692221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BC36B2677F1
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 13:05:09 +0100 (CET)
In-Reply-To: <295ce358-c00e-74ce-50c1-1df32c2c6cf7@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, huang lin <hl@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Dylan Reid <dgreid@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4680387216041692221==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 11:45:43AM +0100, Arnaud Pouliquen wrote:

> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 num-channels =3D <1>;

> In your implementation seems not linked to hardware but software...

> DMIC driver description specifies the channels_max to 8 channels.
> I suppose that it is used for DMIC codecs that integrate filters and are
> connected to CPU DAI with I2S/PCM links. But it can be also used for
> DMIC connected to CPU DAI with a SPI link (in this case decimation
> filter in on Soc side).

The intention with the DMIC CODEC is that it's used when the CPU
directly has PDM inputs and the DMICs are just directly wired to it
(stereo is obviously the norm here but some SoCs may bunch things up
further for use with mic arrays).

> If we continue to support both use cases, specify the number of channels
> seems reasonable but this should be use to change the max channel
> constraint, not to declare a control.

Yes, that would seem the most obvious thing - it's how we handle things
like CPU DAIs that support very high channel counts when connected to
stereo CODECs for example.  It's not obvious why we'd use a channel map
here instead.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpPaeYACgkQJNaLcl1U
h9CoNwf+M4j9vaeXo+/z58OdIMwap1oV2G2/VqOsynaNnIt5CMYO4MCMeAkkwNfz
OuWIrXi8iSOuKSjlqx/gf7YYnxXPR2ndxehOe7NS6a/Bjzmwis5eA5dBCDrF1S6p
cQ8QTdQaIgq1KGAG6u276sb8TKDcL1MOkYYTTUHpky94lGbCBvJP4nxrMnMSG9LI
q6XkdWVjKzCbuXwk05fXFB1W0Gwyz1VQRSmFYzC6CTDc3bgqT76TgrgtCBkoyKFx
q7hFHzEE29Y53OFiiOFEE9DeY3ewIg4L4HVXOX4XotdAUCkNIe4srX/udEG+gPkl
zJJvCoHag89oKEvTqoOUl27UA4VqRA==
=MDpT
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============4680387216041692221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4680387216041692221==--
