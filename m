From: Mark Brown <broonie@kernel.org>
Subject: Re: RT5640 jack detection
Date: Thu, 24 Sep 2015 14:29:38 -0700
Message-ID: <20150924212938.GG30445@sirena.org.uk>
References: <CAL9uMOHM3tbdKT7s4panz8zyYxu35F38GLUtu9DSmgrQr=Ciqg@mail.gmail.com>
 <1443025358.6977.71.camel@loki>
 <20150923163746.GR30445@sirena.org.uk>
 <CAL9uMOG2CgBU2yiKCq4iyt7L-Ms1e=vVqrAFV76G1Zvj3d3PXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5388338114936220751=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3EBF265ADB
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 23:30:18 +0200 (CEST)
In-Reply-To: <CAL9uMOG2CgBU2yiKCq4iyt7L-Ms1e=vVqrAFV76G1Zvj3d3PXA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org


--===============5388338114936220751==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yqX3wpb4QnjwKg06"
Content-Disposition: inline


--yqX3wpb4QnjwKg06
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2015 at 10:34:14PM +0200, Carlo Caione wrote:
> On Wed, Sep 23, 2015 at 6:37 PM, Mark Brown <broonie@kernel.org> wrote:

> > That can upset userspaces - it means you get things like trying to play
> > a notification tone, starting, realising that a headphone is there and
> > trying to switch on the headphone in the middle of the notification
> > being played back which doesn't tend to work out so well.

> > What I'd expect the driver to be doing here is enabling whatever it
> > needs to do detection enabled while detection is enabled.

> What I don't get here is what do you mean with "detection". Can we
> simply consider PA listening for jack change events a "detection"?

Detection is the act of detecting if a jack is physically present in the
socket.  This will normally happen all the time the system is running,
some userspaces rely on uevents to get notifications so the kernel can't
tell if anything is listening.

> > There's quite
> > a few examples of this in mainline - look for jack code that has DAPM
> > calls in it.

> Do you thing the rt5670.c could be a good example for that?

No, that doesn't appear to have any interlock with DAPM and is just
basic GPIO stuff.

> In my case the setup is different though. The GPIO is driven by the
> codec itself and it doesn't work when the codec BIAS is off. So the
> problem is that I cannot use the DAPM code since before that I need to
> find a way to detect the change in the GPIO status when I'm not
> actively using the codec.

To repeat:

| What I'd expect the driver to be doing here is enabling whatever it
| needs to do detection enabled while detection is enabled.  There's quite
| a few examples of this in mainline - look for jack code that has DAPM
| calls in it.

If you need to force things on during detection you should add code to
do that, for example enabling relevant DAPM widgets with _force_enable().

> I see two possible solutions for this problem: 1) as said before I can
> just avoid to turn the BIAS totally off, leaving the I2S clock active
> that allows the codec to drive the GPIO or 2) keep polling on the
> status of the GPIO enabling and then disabling the BIAS (or using the
> DAPM code) just for the time needed to read the GPIO status

Enabling things only when needed is of course optimal but you need
detection to work whenever detection is enabled.  It sounds like this is
not the case for your system.

--yqX3wpb4QnjwKg06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWBGs8AAoJECTWi3JdVIfQA2UH/RDeXsop7qRfmDZnldTccx7w
vXvCmLCe4T+550TrIcyBE7/UbMsAd8fUaYQpH2dEZfEzzaYc5mInGYeFY61zFmC3
IYHD1555XlAiQLw2sJUOUBzSj/Xjv12s5oH6Q+xg/P73in/v+JLq9PC7PMWFPpSL
H/nsmvunCvpCwYAHGlc5gKsAePfKV31pEzz1Knbll5mWeFInQo8sl5vG6H5agPzk
2O+rNCGXkRX4EytvxQVPSzkNMEY7MDQN0FSVnNA7Bg9/dRqzjqdajhNc/806Ucie
/SOYmkaywoN+35+dcngDheyuSe77GQ+gEEYxLzRCE1yyni1bNrkIIfHCGHWt0Qk=
=GCGl
-----END PGP SIGNATURE-----

--yqX3wpb4QnjwKg06--

--===============5388338114936220751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5388338114936220751==--
