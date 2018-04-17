From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: stm32: sai: add support of
	iec958 controls
Date: Tue, 17 Apr 2018 12:17:33 +0100
Message-ID: <20180417111733.GG8973@sirena.org.uk>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8618951527798267387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 356FE2675CF
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 13:17:46 +0200 (CEST)
In-Reply-To: <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier MOYSAN <olivier.moysan@st.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "jsarha@ti.com" <jsarha@ti.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org


--===============8618951527798267387==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:

> I guess the blocking patch in this patchset is the patch "add IEC958=20
> channel status control helper". This patch has been reviewed several=20
> times, but did not get a ack so far.
> If you think these helpers will not be merged, I will reintegrate the=20
> corresponding code in stm driver.
> Please let me know, if I need to prepare a v2 without helpers, or if we=
=20
> can go further in the review of iec helpers patch ?

I don't mind either way but you're right here, I'm waiting for Takashi
to review the first patch.  I'd probably be OK with it just integrated
into the driver if we have to go that way though.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrV18wACgkQJNaLcl1U
h9BhwAf+K6KCxAJQ456jenbORVhomVdfTbV3KBBzJ6310IiR0Q2XU1ZwQVnWFRMU
H8RL0UKXcBN/d5vRHV2yETlmn57YR6C6Y+9mC+TAnX13jQpEMIpY1eQrJtlGl52y
V2jFR2JQsxoZULHSq79w+Hv7yC3nMMUvhz6Rtaz+3neQY7iIzJoIFkRkLKcudEnU
TzELW+CnwbqmtkQeIIAN2qdwL5EOZbHY3pSK6r5tiHd5A+CSkBLghyqgDGqbfXGI
Z/81b738xd69CHuZW7WJpmaMffwyrkw4RJotgB24Mmv0KWSVBYE3JzAqt4ymnRnd
oe8jOo3Xh1dcDYlAPIXu/oEWfYUvIg==
=gzqA
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--

--===============8618951527798267387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8618951527798267387==--
