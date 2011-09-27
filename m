From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Tue, 27 Sep 2011 17:45:32 -0400
Message-ID: <20110927214531.GC32568@alittletooquiet.net>
References: <20110916203601.GD8309@alittletooquiet.net>
	<20110919231413.GD1223@alittletooquiet.net>
	<s5hsjnrr840.wl%tiwai@suse.de>
	<20110920190534.GF1223@alittletooquiet.net>
	<s5h39fqz3u7.wl%tiwai@suse.de>
	<20110921143510.GG1223@alittletooquiet.net>
	<s5hobyegdmk.wl%tiwai@suse.de>
	<20110921175552.GL1223@alittletooquiet.net>
	<s5h1uv2f8ib.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0048034944844177153=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 31D03103977
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 23:45:35 +0200 (CEST)
In-Reply-To: <s5h1uv2f8ib.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0048034944844177153==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, Sep 27, 2011 at 02:57:16PM +0200, Takashi Iwai wrote:
> At Wed, 21 Sep 2011 13:55:53 -0400, Forest Bond wrote:
> > On Wed, Sep 21, 2011 at 04:43:15PM +0200, Takashi Iwai wrote:
> > > At Wed, 21 Sep 2011 10:35:10 -0400, Forest Bond wrote:
> > > > On Wed, Sep 21, 2011 at 10:39:44AM +0200, Takashi Iwai wrote:
> > > > > At Tue, 20 Sep 2011 15:05:34 -0400, Forest Bond wrote:
> > > > > > On Tue, Sep 20, 2011 at 09:22:23AM +0200, Takashi Iwai wrote:
> > > > > > > At Mon, 19 Sep 2011 19:14:13 -0400, Forest Bond wrote:
> > > > > > > > On Fri, Sep 16, 2011 at 04:36:01PM -0400, Forest Bond wrote:
> > > > > > > > > I have two boards with a VT1708:
> > > > > > > > >=20
> > > > > > > > > * VIA EPIA EX15000G
> > > > > > > > > * VIA VB8002
> > > > > > > > >=20
> > > > > > > > > I'm using VLC to play audio via PulseAudio to the analog =
outputs.  The VB8002
> > > > > > > > > sounds great, but the EX15000G has random pops and clicks=
 in the output.  Both
> > > > > > > > > machines are running exactly the same configuration (they=
 are using the same
> > > > > > > > > pre-built OS image).
> > > > > > The crackling with PCM volume set to 0 persists with tsched=3D0.
> >=20
> > [...]
> >=20
> > > > > Hrm, which PA version are you using?  I remember vaguely a buggy =
PA
> > > > > SIMD operations in some old PA versions.
> > > >=20
> > > > 1:0.9.22+stable-queue-24-g67d18-0ubuntu3 from Ubuntu Lucid.
> > > >=20
> > > > > Also, when you mute the mixer (nor the PA's mixer), e.g. via
> > > > > "alsamixer -c0", the noise goes away, right?
> > > >=20
> > > > I do not use the PA mixer.  The noise is present with ALSA's PCM co=
ntrol set to
> > > > zero (-51dB).  If I move the PCM control up one tick (to -50.8dB) t=
he noise goes
> > > > away.
> > >=20
> > > OK, then it's an issue in the sound driver.
> > > Could you give alsa-info.sh outputs both mute-with-noise and without
> > > noise for comparison?
> >=20
> > I guess we can ignore this one for now.  I do not have this problem usi=
ng a
> > recent alsa-driver snapshot.  The PCM control does not go below -40.25d=
B with
> > this version.  It's possible the new driver simply doesn't allow the co=
ntrol to
> > be set to a problematic value.
> >=20
> > I will note, however, that the master control with the snapshot has a m=
inimum
> > value of 0dB and a maximum of 6.75dB,
>=20
> That's odd.
>=20
> > and that the audio is barely audible at
> > 0dB.  I have to crank the master control all the way up to get the same=
 volume
> > as the old driver set to 0dB.  Maybe I can come up with a fix for this.
>=20
> For debugging, I'd need anyway the alsa-info.sh output from the latest
> alsa-driver snapshot.

Okay, here you go:

  http://www.alsa-project.org/db/?f=3D8f3da35bd1b615d199f8e71df8b012fbdf5ff=
690

> Also, I'm working now on non-snooping mode support, and this might
> help for fixing some problems like yours.  Could you try the patch
> below (with the snapshot version)?

Unfortunately, this doesn't seem to help.

Given the similarities between the working and non-working boards, I was
wondering if the BIOS is setting up the chips differently and that is the
immediate cause of the problems.  In particular:

* There is no set_widgets_power_state function for this chip.  If the BIOS
  enables some power management function on one board but not the other and=
 the
  driver has no way to disable it, could that cause an issue like this one?

* I see that the VB8002 has "N/A" listed for "Pin Default" for several
  "Pin Complex" nodes where the EX15000G has "Jack".  Is it possible the
  EX15000G has some nodes configured as AC_JACK_PORT_COMPLEX that should be
  configured as AC_JACK_PORT_NONE?

It should be clear that I do not have a very good understanding of the HDA =
spec.
I'm assuming the BIOS is responsible for configuring the chip as I've descr=
ibed
above.  Do any of those problems sound possible to you?  If so, are there w=
ays
to work around them in the driver?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6CQ/sACgkQRO4fQQdv5Az1WACfTqey0eYwIv6BlUvvyP1Gg1CJ
kMwAoNnthMIa7mk1kSBbHtYSf+JtSVS+
=J41S
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

--===============0048034944844177153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0048034944844177153==--
