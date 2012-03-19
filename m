From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 19 Mar 2012 12:09:57 +0000
Message-ID: <20120319120956.GA3130@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
	<20120314134508.GL3133@opensource.wolfsonmicro.com>
	<4F6201C1.1040006@stericsson.com>
	<20120315152906.GN3138@opensource.wolfsonmicro.com>
	<4F633B92.7030401@stericsson.com>
	<20120317223141.GK3315@opensource.wolfsonmicro.com>
	<4F66E934.1060909@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3617189073376723757=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5E4A103A85
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 13:10:00 +0100 (CET)
In-Reply-To: <4F66E934.1060909@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3617189073376723757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 09:07:16AM +0100, Ola Lilja wrote:
> On 03/17/2012 11:31 PM, Mark Brown wrote:

> > > We need to break chains on very specific positions to be able to
> > > affect only the parts intended. We also have switches (e.g. loopback)
> > > that is not belonging to a specific pin but is a brigde-switch in the
> > > middle of two chains, thus I don't think we can use what you suggest.

> > But if you have a control that actually does something then surely there
> > should be some interaction with the chip when it is changed?

> No, we don't want the control to do anything with the chip before
> playback/capture starts, but rather just indicate that a specific path
> is active, and then when the stream starts the chain gets complete and
> the widgets then do all interaction with the chip in the order that
> our HW requires. There is no bit that we can set prior to the
> execution of the DAPM-chain, without introducing clicks.

In the case of things that go external pins then I'd really expect the
existing solution with pin switches to work, in other cases something
else may be needed but we need to understand what you're trying to do.
The issues with internal paths may need something but please be more
concrete about what the actual register controls are and why you're
doing such unusual things.  The fact that you're using isolated switches
and there's no mixers involved is really surprisng.

> > One of the nice things about open source code is that it's always
> > possible to extend the core if required.

> OK, so do you want us to make it possible to have NOPM for a
> playback/capture-switch? Can you confirm that this is OK and that it
> is possible to accomplish without destroying any mechanism in how it
> works today?

I'm saying that if you're doing things within your driver that go trough
contortions or break the userspace interfaces because the frameworks
didn't support things then you should be fixing the frameworks rather
than doing whatever in the driver.  This sort of thing seems to be at
the root of several of the problems I'm seeing here, it's similar to all
the stuff you're doing with regulators.

> So, what you want is another device/driver pair where our current
> acc.det.-driver adds a driver to the device we add in the ASoC-driver?

I can't parse what you're saying here, sorry.

> We are thinking of modifying so that we put the Android-vibra-functionality in
> userspace, and then it can use vibra through the controls we provide in the
> ASoC-driver.

That'd obviously remove any kernel level problems.

> Regarding the regulators, I was under the impression that everything
> outside the actual codec, we could put in the machine-driver (which I
> think looks pretty good).  This would make a clear distinction between
> all codec-register-handling and usage of those external frameworks
> (regulators and clocks). I have started to move the code location of

No.  That's exactly the sort of stuff we don't want to see.  The fact
that the device needs power to operate isn't something that's specific
to a particular board, it's a property of the silicon.

> regulators/clocks into the codec-file and this results
> in that the machine-driver is basically empty of functionality and the
> codec-file is growing even bigger. Is this really what we want?

Yes, of course!  You need to get away from the idea that the only board
your device will ever be used on is the reference board, things that are
generic to the device should be supported by the device driver for the
device.  If there's a device driver for the part we shouldn't be in the
situation where any new system using the device needs to replicate basic
functionality needed to get the device working.

> I'm also not sure if you have seen that we actually do control ALL regulators
> and clocks via DAPM. The main power-regulator is controlled through a

I've not suggested that.  Look at how other drivers manage their power.

> You are right that a large part of this code is there because it is needed by
> external requirements, but it does not mean that DAPM is not controlling the
> regulators and clocks, just that there is another interface that can also turn
> on/off the power.

I'm not seeing any code in the driver which manages the regulators...

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZyIDAAoJEBus8iNuMP3dBMQP/AqepQZDcbH1CDooO6n+MucV
Hpcn8mhTe/v+CsLfj3+UlJgbTjHu//e6WY3o59A07mqvcE+3l/cJJhdnsolrnmjE
VJOHsYqwTfOLog/6Tjo5h6jzajZdZnXNSqBMgzHT7A2QfV3bnDdmBYTxpwMkiSpn
pEcYA7rpTbq/keOQjNda7Z1WyqsWXCp/LpFGFiA8KHWh1Cuq/2GH1YJPuAp3N907
yqkn1HnGGQWsvxTwcGXujFv//rkMJlYiZPmCMtyutX5skYpJTzs8h7ImTaP9OELy
83eAjbcCaTekYnC1LUN5dbGvMORQg5SuxybmbmL9lvGUO8PjwfAFga1YkAELRdk0
46OZol1pCWCtO4clyEf0SQxbMeBlnuz5ffuXB9YV/soNRQadUlzvb3XD/BUfSxgl
9IviY8dYKtr5/VI/iClIyM4UZuzfxMhc+10h57dT1rWhZTF1dHh1MNFCMysDGk+F
1gSCIUzsptMcpzRiIaUK6fwcC2SmJNlQLYBKONcaOBSQHwPzzp3ghl3fatG59nHo
EBKOnij5ac9XQr6QCIwhJewiL0y28wxE7qu9XQQ8Kuo9+guCAc78pm7VoUKjqimM
E/LyisPBksqEgWvfMmqUs7iIkU8UIx8JP4u6IGcWErKGQhONy1knZqFR5XgP6m/6
SaPEYGVJSIGAOBAMX6zA
=dEaB
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

--===============3617189073376723757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3617189073376723757==--
