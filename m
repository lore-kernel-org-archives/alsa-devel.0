From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: rt5645: Add the HW EQ for the
 customized speaker output of Google Celes
Date: Wed, 21 Oct 2015 11:34:04 +0100
Message-ID: <20151021103404.GK32054@sirena.org.uk>
References: <1444803300-31699-1-git-send-email-oder_chiou@realtek.com>
 <20151016151618.GQ14956@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694F9DE17@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4385177956417978254=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B5196260622
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 12:34:11 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694F9DE17@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gary_lin <gary_lin@realtek.com>, John Lin <john.lin@realtek.com>, "woojoo.lee@samsung.com" <woojoo.lee@samsung.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4385177956417978254==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vlBIoVqBuM4vJEpx"
Content-Disposition: inline


--vlBIoVqBuM4vJEpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2015 at 06:34:52AM +0000, Oder Chiou wrote:
> > The userspace interface is now what I'd expec tbut I'm still quite
> > confused by this.  Why is this not a normal bytes control?  There's
> > something going on with private data here but I'm not sure what it's
> > supposed to do over writing to the device - a changelog might've
> > helped...

> We want to set the register table to the following struct byte-by-byte.
> struct rt5645_eq_param_s {
> 	unsigned short reg;
> 	unsigned short val;
> };
> Due to the length and target registers of the table are variant, we allocate
> the maximum size of register settings to store the data, and they should be
> controlled by DAPM for following the sequence, so the settings will be
> applied to the hardware in the speaker event of DAPM.

This *really* needed to be called out in the changelog.  Why are we
specifying the parameters in this format rather than just letting people
set the coefficients like other drivers do?  This is extremely unusual
and basically lets userspace write anything they like anywhere in the
device as part of the coefficients which doesn't seem like a good idea.
Look at how other drivers do bytes controls.

> > Why is the hweq setting part of platform data (and why is the platform
> > data for a specific system being set as part of this patch)?  This is
> > just a setting that can be set, there's nothing system specific about it
> > and it's not like we're even passing in a system specific tuning here.

> In the default, we want to disable the HW EQ function, and it is only enabled
> by the customers' request, so we set it in the platform data. The parameters
> of the HW EQ only can be passed by ALSA binary control.

This doesn't make much sense in an open system like Linux - the user can
always change the code to enable this, it's just getting in the way of
providing the configurability to force them to change their DT or kernel
and if they need to provide the settings from userspace anyway the
switch in the kernel isn't really doing anything.

--vlBIoVqBuM4vJEpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJ2ocAAoJECTWi3JdVIfQBWYH/1qvsmlQDXvmvnp2n+IrfVJK
5FSq9B6Nl4pr82oOHblcz1L+XYUHhHJ4uZSUTVQBSfw42sM1p6Ra/Nmp6u1U0XJB
nbyOWcRh7oo6Hi7JZmAxkwQ1l1mYmRtUm8pgwgvcLI+3u/xRApF5F8xW/orzqDQU
GHsL2X7mpR4bqu6wpdSgRZ5DPrkuFQ0Nsik0Fwsx49claQuvSDD4a0eEUc3SoqSn
kejCbdvgmp1K1Lpwys4Qjq1EyKv3TjMuFOVYfTaAOwwwcoux/y1jEjf4HmWE8Xus
f5GXjr6QaUHnSDe/+SWOPXLkCwmb9V4taVvogl9Y/l8OciovG/qtsW97+wxhDbc=
=Q+bO
-----END PGP SIGNATURE-----

--vlBIoVqBuM4vJEpx--

--===============4385177956417978254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4385177956417978254==--
