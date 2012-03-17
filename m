From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Sat, 17 Mar 2012 20:31:03 +0000
Message-ID: <20120317203102.GA3315@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
	<4F63105E.3080705@linux.intel.com>
	<20120316192231.GI3158@opensource.wolfsonmicro.com>
	<CA+7tXigaxPdkBGfciWgJx2PnZHPKftgWdXxYREOBYUiXW7aA=g@mail.gmail.com>
	<20120317114856.GN3158@opensource.wolfsonmicro.com>
	<CA+7tXiheVO6FAypZU-yRuT=Cg3iPAgHeQOmVpZ_zJF_T5JdORw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0287248464164008253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9AE94103EFC
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 21:31:07 +0100 (CET)
In-Reply-To: <CA+7tXiheVO6FAypZU-yRuT=Cg3iPAgHeQOmVpZ_zJF_T5JdORw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>, Ramesh Babu <ramesh.babu@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0287248464164008253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 17, 2012 at 03:49:06PM -0400, Trent Piepho wrote:
> On Sat, Mar 17, 2012 at 7:48 AM, Mark Brown
> > On Fri, Mar 16, 2012 at 06:01:44PM -0400, Trent Piepho wrote:

> > > Since the constraint is based on the current configuration of another
> > > DAI, the two DAIs need some way to query each other's parameters. =A0=
The

> > Since they're both provided by the same driver this is trivial.

> It's not that trivial with the sub-streams in question aren't in the
> same instance of the driver, e.g. playback and record.=A0 Say you had

It's very easy to go back from the DAI to the CODEC, there's a direct
pointer.

> two WM8988 codecs, how does one codec get a handle to the other?

Such a constraint would be machine imposed, not CODEC imposed - the case
the Intel guys were talking about was a constraint between the two
interfaces on a single CODEC.  There's no way the driver for one CODEC
should be doing anything about another CODEC.

> There's no global list of codecs in the driver, so you have to add
> something like that.=A0Or change the device tree binding to give the

You're talking about a totally different use case here, there's way more
issues than just the constraints getting multiple CODECs on the same
link to play nicely. =20

> slave codec a phandle to the master codec.

No, that wouldn't be sensible - this should all be handled at the DAI
level.  Adding explicit code in individual CODEC drivers for this would
be an awful lot of duplication.

> Does PulseAudio handle it if hw_params fails?  From what I've seen,
> most applications just fail if hw_params fails.

I've no idea what PulseAudio does; I suppose someone who's interested
could look at the code.  Most applications do just fail, like I say it's
exceptionally rare to hit any of thist stuff.

> are in state >=3D SETUP, verify that the hw_params are still valid and
> if not, update the constraints and return an error.  But it is not
> until line 455 that the substream has actually finished getting the

So long as the driver takes care that only one of multiple concurrent
hw_params() calls manages to successfully return we should be fine, once
the hw_params() call has returned we're committed to flagging success.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZPQ4AAoJEBus8iNuMP3dmHoP/05gKcIuhW4ntM2X3oDYQEq2
IxNlScBsKGddHTN46BzuwQUR1yQq/npomCSJ4pGLDQ3bA0oQB7U++yqMAn6vfQt6
tD5ydFhFJH9S2DzkHJcTR4NeHQ2YbWKWbieMtW/Rc7SAR/PO8iIgxPbbb+C66Nde
VOD3h51+c4vYnT4LmJC+IUD2TZ4uJaZX9ubTh5wob84F2vTasuz99eLKYYzs6g2J
hMMrUujDPr+Czlr4U+riMaErzUo5X1pGAwCoPmK+fNzodFuvGB5hQygEdSD97MaY
r5um62OTTlPpW6xWYfHjNGjJezm5vfj+31f7s2plUOyvDFKiLQcWkyh87XKLF8+1
3Sn8w/BPnyPWNcWTMgOnS7TMSt4sX8Xj3wwPIi73bFYy8CfLDUsKWYvEvuUT5C6u
Zpx6k4u3BoR+RGcWoy6YMNGXlz7T1V+78gHkDv8Ssc1seksvufjv9hOfSfAX3OUg
6QsqlRqV2yX8joPtdPbnX4OmbRtpkY1jaIhOtZI7Zc5J7r+7Upi9P+VLTRLiwiE0
WqQiyod4n2bJhEPdd0qKMUQd7kz4Nk1evy3xvYnkIF9XwwvwUNW12F8KdA8SzQ6K
Bw306j6hhZTdzfgmadV2mQ9K2IByX4fJEuLN6eaONGGCvFhrnzu04mE2MxRSN5li
ZZWSrRJDITreO0L+QLSj
=yKGK
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

--===============0287248464164008253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0287248464164008253==--
