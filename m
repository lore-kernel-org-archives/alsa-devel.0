From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8994 playback delay
Date: Thu, 29 Mar 2012 11:50:16 +0100
Message-ID: <20120329105015.GA3668@opensource.wolfsonmicro.com>
References: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1332964426-8480-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<031201cd0d36$d9b78310$8d268930$@com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6530455805609594509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C9FE71043AB
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 12:50:18 +0200 (CEST)
In-Reply-To: <031201cd0d36$d9b78310$8d268930$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, sbkim01@gmail.com, sangsu4u.park@samsung.com, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6530455805609594509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2012 at 08:02:29AM +0900, Sangbeom Kim wrote:

> Currently, We are developing SMDK with Exynos5250 and  WM8994 on 3.3-rc6.
> We try to enable CONFIG_PM_RUNTIME and on/off control of power domain.
> But It has playback delay in the first playback.(3~4sec and 6/10times)

> In that time, Log maessage is=20
> 'wm8994-codec wm8994-codec: Timed out waiting for DC Servo 300'
> wait_for_dc_servo() function generate above message on sound/soc/codecs/w=
m_hubs.c

This issue usually indicates that the clocking has an issue - are you
following a similar pattern to that seen in the lowland machine driver
in mainline?  This is the best practice for WM8994 class parts, it
should minimise power consumption when idle.

> After removing wait_for_dc_servo for testing, playback delay is disappear=
ed.
> So, Could you please explain the  purporse of wait_for_dc_servo()?
> If wait_for_dc_servo() is removed, What kind of problem can be happened?

The DC servo is used to reduce pops on the headphone output.  If the DC
servo is not run the headphone outputs will produce audible artifacts
when headphone is enabled which are generally considered unacceptable by
users.  There's a more detailed explanation of the feature in the WM8994
datasheet but that's the high level.

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdD5gAAoJEBus8iNuMP3dQtIQAIYLobS8JonRqPjREjsbuQSk
MB0gNHVJZsfEWrGj3FtAUjrqLbiRo3T/sUA+ck9RsJShTa1y6kk7ztZsp2cnloos
quUXkZ1js5bmTWowturEw0iAJxWm86n5E720uC68qQ39bG7EiCpCqhOW/H+44jNl
pUhc+fj6KMyZPUzkpxOaVf2zfguc4I7w+cZy9RmD40oJydG5jY44pTbw8v8DarYQ
ERRi3jtJERoOAHkCewIR7NS00bupyGf+Pc7HIP9fxanFrEgj5t7wcXcIjAUABE06
ZBn0yiiPZTdcX2FkkvbuiVYLqAi1JiLfFxFSYmLYy/AE9H+HQqe7LOF3JVfOQOVo
XCpY+4BU4LLxnEJDrs34ucwWRQvyENDNPekKhXlWuoPzPaMyTcmDpWUbYsTnhmc8
8pYhdXBfzT/q/g2ku0bn6ErZWquWr1OjlqIRy125zoIu7C3CTe14Adv2hXOblUZu
4yeXCD0bxtvN3XtchgKU9d2+R+w/K5P+KIMXgtXNY51O37mkq8gBMQo9DD9s+lnr
DjtF/DFzYS9cVKvmY5BpUm3fENKvqeCtTxG7sMYJKIu2hFt3dn2jSQ+hpLLUqJt4
JkfPDnA04ijvEFghdfbgBA7j28rfSTBjmdt3v9TE+jsK3isWPTeU08MaBIKy3ScS
TLOYwpWa5Zp0skvfLG0o
=0JR+
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

--===============6530455805609594509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6530455805609594509==--
