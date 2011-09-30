From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Thu, 29 Sep 2011 22:04:23 -0400
Message-ID: <20110930020423.GC2114@alittletooquiet.net>
References: <s5hsjnrr840.wl%tiwai@suse.de>
	<20110920190534.GF1223@alittletooquiet.net>
	<s5h39fqz3u7.wl%tiwai@suse.de>
	<20110921143510.GG1223@alittletooquiet.net>
	<s5hobyegdmk.wl%tiwai@suse.de>
	<20110921175552.GL1223@alittletooquiet.net>
	<s5h1uv2f8ib.wl%tiwai@suse.de>
	<20110927214531.GC32568@alittletooquiet.net>
	<s5hoby5cjsy.wl%tiwai@suse.de>
	<20110928211224.GB2114@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7753450899333143087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 639FE244CD
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 04:04:26 +0200 (CEST)
In-Reply-To: <20110928211224.GB2114@alittletooquiet.net>
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


--===============7753450899333143087==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Sep 28, 2011 at 05:12:24PM -0400, Forest Bond wrote:
> On Wed, Sep 28, 2011 at 07:33:49AM +0200, Takashi Iwai wrote:
> > At Tue, 27 Sep 2011 17:45:32 -0400, Forest Bond wrote:
> > > On Tue, Sep 27, 2011 at 02:57:16PM +0200, Takashi Iwai wrote:
> > > > At Wed, 21 Sep 2011 13:55:53 -0400, Forest Bond wrote:
> > > > > On Wed, Sep 21, 2011 at 04:43:15PM +0200, Takashi Iwai wrote:
> > > > > > At Wed, 21 Sep 2011 10:35:10 -0400, Forest Bond wrote:
> > > > > > > On Wed, Sep 21, 2011 at 10:39:44AM +0200, Takashi Iwai wrote:
> > > > > > > > At Tue, 20 Sep 2011 15:05:34 -0400, Forest Bond wrote:
> > > > > > > > > On Tue, Sep 20, 2011 at 09:22:23AM +0200, Takashi Iwai wr=
ote:
> > > > > > > > > > At Mon, 19 Sep 2011 19:14:13 -0400, Forest Bond wrote:
> > > > > > > > > > > On Fri, Sep 16, 2011 at 04:36:01PM -0400, Forest Bond=
 wrote:
> > > > > > > > > > > > I have two boards with a VT1708:
> > > > > > > > > > > >=20
> > > > > > > > > > > > * VIA EPIA EX15000G
> > > > > > > > > > > > * VIA VB8002
> > > > > > > > > > > >=20
> > > > > > > > > > > > I'm using VLC to play audio via PulseAudio to the a=
nalog outputs.  The VB8002
> > > > > > > > > > > > sounds great, but the EX15000G has random pops and =
clicks in the output.  Both
> > > > > > > > > > > > machines are running exactly the same configuration=
 (they are using the same
> > > > > > > > > > > > pre-built OS image).
> > > > > > > > > The crackling with PCM volume set to 0 persists with tsch=
ed=3D0.
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > > > Hrm, which PA version are you using?  I remember vaguely a =
buggy PA
> > > > > > > > SIMD operations in some old PA versions.
> > > > > > >=20
> > > > > > > 1:0.9.22+stable-queue-24-g67d18-0ubuntu3 from Ubuntu Lucid.
> > > > > > >=20
> > > > > > > > Also, when you mute the mixer (nor the PA's mixer), e.g. via
> > > > > > > > "alsamixer -c0", the noise goes away, right?
> > > > > > >=20
> > > > > > > I do not use the PA mixer.  The noise is present with ALSA's =
PCM control set to
> > > > > > > zero (-51dB).  If I move the PCM control up one tick (to -50.=
8dB) the noise goes
> > > > > > > away.
> > > > > >=20
> > > > > > OK, then it's an issue in the sound driver.
> > > > > > Could you give alsa-info.sh outputs both mute-with-noise and wi=
thout
> > > > > > noise for comparison?
> > > > >=20
> > > > > I guess we can ignore this one for now.  I do not have this probl=
em using a
> > > > > recent alsa-driver snapshot.  The PCM control does not go below -=
40.25dB with
> > > > > this version.  It's possible the new driver simply doesn't allow =
the control to
> > > > > be set to a problematic value.
> > > > >=20
> > > > > I will note, however, that the master control with the snapshot h=
as a minimum
> > > > > value of 0dB and a maximum of 6.75dB,
> > > >=20
> > > > That's odd.
> > > >=20
> > > > > and that the audio is barely audible at
> > > > > 0dB.  I have to crank the master control all the way up to get th=
e same volume
> > > > > as the old driver set to 0dB.  Maybe I can come up with a fix for=
 this.
> > > >=20
> > > > For debugging, I'd need anyway the alsa-info.sh output from the lat=
est
> > > > alsa-driver snapshot.
> > >=20
> > > Okay, here you go:
> > >=20
> > >   http://www.alsa-project.org/db/?f=3D8f3da35bd1b615d199f8e71df8b012f=
bdf5ff690
> >=20
> > This is the working device, right?
>=20
> No, this is the one with PA issues and the mixer levels issue I mentioned=
 above.
> I haven't tested the snapshot driver on the working board, so I don't kno=
w if it
> is also effected by the mixer levels issue.
>=20
> > > > Also, I'm working now on non-snooping mode support, and this might
> > > > help for fixing some problems like yours.  Could you try the patch
> > > > below (with the snapshot version)?
> > >=20
> > > Unfortunately, this doesn't seem to help.
> > >=20
> > > Given the similarities between the working and non-working boards, I =
was
> > > wondering if the BIOS is setting up the chips differently and that is=
 the
> > > immediate cause of the problems.  In particular:
> > >=20
> > > * There is no set_widgets_power_state function for this chip.  If the=
 BIOS
> > >   enables some power management function on one board but not the oth=
er and the
> > >   driver has no way to disable it, could that cause an issue like thi=
s one?
> >=20
> > No, as default the driver powers up all widgets and power down all
> > again at power-saving.  The VIA codec driver has an advanced
> > implementation to turn off a few unused widgets even in power-up.
> > And this feature is missing in VT1708.  So, it doesn't mean that the
> > driver has no power control.  It has.
>=20
> I see.
>=20
> > > * I see that the VB8002 has "N/A" listed for "Pin Default" for several
> > >   "Pin Complex" nodes where the EX15000G has "Jack".  Is it possible =
the
> > >   EX15000G has some nodes configured as AC_JACK_PORT_COMPLEX that sho=
uld be
> > >   configured as AC_JACK_PORT_NONE?
> >=20
> > I don't know.  You need to check whether the pins are really correctly
> > set up.  For example, most of jacks have the detection capability.
> > Then plug/unplug each jack and check the pin-detection e.g. with
> > hda-verb program.
>=20
> I probably should have said so earlier, but this board has RCA connectors=
 for
> most outputs.  I'm not sure that pin detection works for these?  In any c=
ase,
> the EX15000G and the VB8002 have the exact same the same physical connect=
ors.
>=20
> The only 1/8" connector is the front panel headphone jack.  I checked thi=
s pin
> with hda-verb, and it appears to be setup correctly.
>=20
> > > It should be clear that I do not have a very good understanding of th=
e HDA spec.
> > > I'm assuming the BIOS is responsible for configuring the chip as I've=
 described
> > > above.  Do any of those problems sound possible to you?  If so, are t=
here ways
> > > to work around them in the driver?
> >=20
> > Yes, pins can be easily overridden via sysfs or patch option.
> > See Documentation/sound/alsa/HD-Audio.txt.
>=20
> Okay, thanks for the info.
>=20
> I experimented more and have some additional information that might be
> interesting:
>=20
> 1. The clicks and pops sound like they are actually brief snippets of aud=
io that
>    are being played at the wrong time and mixed in with the correct audio.
>=20
> 2. With the old driver, when I mute some of the mixer controls the audio =
stream
>    becomes silent as expected but I still hear the snippets/clicks and po=
ps for
>    a few seconds.  This happens with the Master Front, Headphone, Front,
>    Surround, Center, LFE, and Side elements, although it only seems to ha=
ppen
>    with the Headphone element when I'm using the rear panel line out (RCA)
>    jacks.  I do not see this with the snapshot driver.
>   =20
> #2 in particular is puzzling to me, but maybe that is due to not understa=
nding
> the hardware well enough.

FYI, I tracked down the root cause of the clicks and pops and it's a PulseA=
udio
issue.  I'll follow up with the PA devs.  It's a pretty interesting problem=
, so
I'll probably Cc you if that's okay.

Please note that the mixer issue affecting the snapshot driver is still
outstanding.  I'm happy to test a fix if that's helpful.  It is not an urge=
nt
matter for me, though, as the older driver version works fine.

Thanks for all of your help!

-Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6FI6cACgkQRO4fQQdv5AxQfgCfV8MfVMaLnJf7jrOUvbSj+KrB
1SUAoIsfHpIbCYc4r4FgW/IvRIaxBCHw
=Tnry
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

--===============7753450899333143087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7753450899333143087==--
