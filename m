From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Sat, 17 Mar 2012 22:31:42 +0000
Message-ID: <20120317223141.GK3315@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
	<20120314134508.GL3133@opensource.wolfsonmicro.com>
	<4F6201C1.1040006@stericsson.com>
	<20120315152906.GN3138@opensource.wolfsonmicro.com>
	<4F633B92.7030401@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8085542206638370319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A866E103F61
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 23:31:47 +0100 (CET)
In-Reply-To: <4F633B92.7030401@stericsson.com>
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


--===============8085542206638370319==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9a9Vq1BJdYBEXpLG"
Content-Disposition: inline


--9a9Vq1BJdYBEXpLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 02:09:38PM +0100, Ola Lilja wrote:
> On 03/15/2012 04:29 PM, Mark Brown wrote:

Please fix the word wrapping in your mail client...

> > If the hardware has no control the idiomatic thing would be to have a
> > pin switch in the machine driver.

> We need to break chains on very specific positions to be able to
> affect only the parts intended. We also have switches (e.g. loopback)
> that is not belonging to a specific pin but is a brigde-switch in the
> middle of two chains, thus I don't think we can use what you suggest.

But if you have a control that actually does something then surely there
should be some interaction with the chip when it is changed?

> The only solution I've found is to use the enum_virt, but if there is
> a possibility to have a switch_virt I would be able to use that.

One of the nice things about open source code is that it's always
possible to extend the core if required.

> Yes, if it were only regulator (and clock) that was needed in our extra
> reference-counted power-functions, it would be fine. But vibra needs to b=
e able
> to turn on the power of the audio-part of AB8500 (our codec) before it ca=
n use
> the vibra-functionality. I could move our the reg/clock and assume that t=
he
> vibra-driver does this itself and only have the codec-power-register shar=
ed
> between the external interface and the DAPM.

As I said previously there's other drivers with the same setup which
manage to integrate fairly easily without breaking the device model - do
what they do with something like an MFD or just embed a trivial input
driver in the CODEC for the vibra if it's small enough.

> (and earlier) to be in sync with mainline-kernel. However, if we get this=
 driver
> mainlined we can use all input to push harder for our next generation of
> platforms. This driver is for a project that has nearly finished its exec=
ution,
> but we would like to mainline this first before we go ahead with new driv=
ers.

Equally well, if it gets mainline without actually meeting mainline
standards that's sending the wrong message :)=20

I'd suggest at least adding regulator support into the CODEC driver so
it's managing its own power when required, there's no reason for
anything external to be doing that.  I expect if you bring things into
line with the device model the code will end up being a lot smaller and
clearer and this won't be needed, it feels like a large part of why
you're having to open code all this stuff is that other bits of the code
stepped outside the frameworks.

--9a9Vq1BJdYBEXpLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZRC5AAoJEBus8iNuMP3dlQQP/2qpinJu4Y8DmNntTzTXpQOT
9mb4wUMkqNYTpeZdheAiWYq8LkmCAI13OcDAynqmqpIb9k42Q9QCmqtpsLvLU5P/
IAPsD+yiZ6DKMHZ5uONygzVfs4ArkJRMSkQb49sE69gY6JS+GNSy9C8bKRfAkWOg
Y+91uR2Lzni4yEpdQ5eCJxU5a7grYRaaiz0an3OZw26rpi2xR+axlTvOpYc+USnn
gCyzRZ32TzDqsTovSKVpit6UyayyB/D0hs2COMHkzBZsQIrfwDASFSBZINvD3/fv
ot6aFLOAjWGGqMTsD9gIsma3gR2bDzPE1CdudQl1LtheSbZIGiwPeHIBKIFRhHFZ
Mtf19y5c+k96TFmuKVPZ5I0B4iyCCR6hPzJLhlAZtgwL1rU2VPmJWRSScSHF6KXc
NzSyJaQvklntVqlTtt9SqpkuReMIvbln7TRBZwIZ/iaETCsBH5jI115/yuvcPyaW
1rR7Yr8TkiJArZLjdfWckvvwY/v447QBUWHLp8oR4eO/Qylky5wgbdeN8Ormv8PZ
fchKUEd0TYsUa5h3f4axA0pmhSwZqMA+TVhlLsRDzNEJ17GA6oLAj5UxzH47ej2c
WhyLGTScCgbgawNBrm2ujhojkaqmbxTFzpfyYYT5q9fZiGCAmpbTygClmaJJnmSE
c+lhgUBZE6ZCq4EKuHur
=zmyj
-----END PGP SIGNATURE-----

--9a9Vq1BJdYBEXpLG--

--===============8085542206638370319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8085542206638370319==--
