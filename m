From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: VT1708 clicks & pops
Date: Wed, 28 Sep 2011 17:12:24 -0400
Message-ID: <20110928211224.GB2114@alittletooquiet.net>
References: <20110919231413.GD1223@alittletooquiet.net>
	<s5hsjnrr840.wl%tiwai@suse.de>
	<20110920190534.GF1223@alittletooquiet.net>
	<s5h39fqz3u7.wl%tiwai@suse.de>
	<20110921143510.GG1223@alittletooquiet.net>
	<s5hobyegdmk.wl%tiwai@suse.de>
	<20110921175552.GL1223@alittletooquiet.net>
	<s5h1uv2f8ib.wl%tiwai@suse.de>
	<20110927214531.GC32568@alittletooquiet.net>
	<s5hoby5cjsy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2773956623044085249=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 90829103820
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 23:12:27 +0200 (CEST)
In-Reply-To: <s5hoby5cjsy.wl%tiwai@suse.de>
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


--===============2773956623044085249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Sep 28, 2011 at 07:33:49AM +0200, Takashi Iwai wrote:
> At Tue, 27 Sep 2011 17:45:32 -0400, Forest Bond wrote:
> > On Tue, Sep 27, 2011 at 02:57:16PM +0200, Takashi Iwai wrote:
> > > At Wed, 21 Sep 2011 13:55:53 -0400, Forest Bond wrote:
> > > > On Wed, Sep 21, 2011 at 04:43:15PM +0200, Takashi Iwai wrote:
> > > > > At Wed, 21 Sep 2011 10:35:10 -0400, Forest Bond wrote:
> > > > > > On Wed, Sep 21, 2011 at 10:39:44AM +0200, Takashi Iwai wrote:
> > > > > > > At Tue, 20 Sep 2011 15:05:34 -0400, Forest Bond wrote:
> > > > > > > > On Tue, Sep 20, 2011 at 09:22:23AM +0200, Takashi Iwai wrot=
e:
> > > > > > > > > At Mon, 19 Sep 2011 19:14:13 -0400, Forest Bond wrote:
> > > > > > > > > > On Fri, Sep 16, 2011 at 04:36:01PM -0400, Forest Bond w=
rote:
> > > > > > > > > > > I have two boards with a VT1708:
> > > > > > > > > > >=20
> > > > > > > > > > > * VIA EPIA EX15000G
> > > > > > > > > > > * VIA VB8002
> > > > > > > > > > >=20
> > > > > > > > > > > I'm using VLC to play audio via PulseAudio to the ana=
log outputs.  The VB8002
> > > > > > > > > > > sounds great, but the EX15000G has random pops and cl=
icks in the output.  Both
> > > > > > > > > > > machines are running exactly the same configuration (=
they are using the same
> > > > > > > > > > > pre-built OS image).
> > > > > > > > The crackling with PCM volume set to 0 persists with tsched=
=3D0.
> > > >=20
> > > > [...]
> > > >=20
> > > > > > > Hrm, which PA version are you using?  I remember vaguely a bu=
ggy PA
> > > > > > > SIMD operations in some old PA versions.
> > > > > >=20
> > > > > > 1:0.9.22+stable-queue-24-g67d18-0ubuntu3 from Ubuntu Lucid.
> > > > > >=20
> > > > > > > Also, when you mute the mixer (nor the PA's mixer), e.g. via
> > > > > > > "alsamixer -c0", the noise goes away, right?
> > > > > >=20
> > > > > > I do not use the PA mixer.  The noise is present with ALSA's PC=
M control set to
> > > > > > zero (-51dB).  If I move the PCM control up one tick (to -50.8d=
B) the noise goes
> > > > > > away.
> > > > >=20
> > > > > OK, then it's an issue in the sound driver.
> > > > > Could you give alsa-info.sh outputs both mute-with-noise and with=
out
> > > > > noise for comparison?
> > > >=20
> > > > I guess we can ignore this one for now.  I do not have this problem=
 using a
> > > > recent alsa-driver snapshot.  The PCM control does not go below -40=
=2E25dB with
> > > > this version.  It's possible the new driver simply doesn't allow th=
e control to
> > > > be set to a problematic value.
> > > >=20
> > > > I will note, however, that the master control with the snapshot has=
 a minimum
> > > > value of 0dB and a maximum of 6.75dB,
> > >=20
> > > That's odd.
> > >=20
> > > > and that the audio is barely audible at
> > > > 0dB.  I have to crank the master control all the way up to get the =
same volume
> > > > as the old driver set to 0dB.  Maybe I can come up with a fix for t=
his.
> > >=20
> > > For debugging, I'd need anyway the alsa-info.sh output from the latest
> > > alsa-driver snapshot.
> >=20
> > Okay, here you go:
> >=20
> >   http://www.alsa-project.org/db/?f=3D8f3da35bd1b615d199f8e71df8b012fbd=
f5ff690
>=20
> This is the working device, right?

No, this is the one with PA issues and the mixer levels issue I mentioned a=
bove.
I haven't tested the snapshot driver on the working board, so I don't know =
if it
is also effected by the mixer levels issue.

> > > Also, I'm working now on non-snooping mode support, and this might
> > > help for fixing some problems like yours.  Could you try the patch
> > > below (with the snapshot version)?
> >=20
> > Unfortunately, this doesn't seem to help.
> >=20
> > Given the similarities between the working and non-working boards, I was
> > wondering if the BIOS is setting up the chips differently and that is t=
he
> > immediate cause of the problems.  In particular:
> >=20
> > * There is no set_widgets_power_state function for this chip.  If the B=
IOS
> >   enables some power management function on one board but not the other=
 and the
> >   driver has no way to disable it, could that cause an issue like this =
one?
>=20
> No, as default the driver powers up all widgets and power down all
> again at power-saving.  The VIA codec driver has an advanced
> implementation to turn off a few unused widgets even in power-up.
> And this feature is missing in VT1708.  So, it doesn't mean that the
> driver has no power control.  It has.

I see.

> > * I see that the VB8002 has "N/A" listed for "Pin Default" for several
> >   "Pin Complex" nodes where the EX15000G has "Jack".  Is it possible the
> >   EX15000G has some nodes configured as AC_JACK_PORT_COMPLEX that shoul=
d be
> >   configured as AC_JACK_PORT_NONE?
>=20
> I don't know.  You need to check whether the pins are really correctly
> set up.  For example, most of jacks have the detection capability.
> Then plug/unplug each jack and check the pin-detection e.g. with
> hda-verb program.

I probably should have said so earlier, but this board has RCA connectors f=
or
most outputs.  I'm not sure that pin detection works for these?  In any cas=
e,
the EX15000G and the VB8002 have the exact same the same physical connector=
s.

The only 1/8" connector is the front panel headphone jack.  I checked this =
pin
with hda-verb, and it appears to be setup correctly.

> > It should be clear that I do not have a very good understanding of the =
HDA spec.
> > I'm assuming the BIOS is responsible for configuring the chip as I've d=
escribed
> > above.  Do any of those problems sound possible to you?  If so, are the=
re ways
> > to work around them in the driver?
>=20
> Yes, pins can be easily overridden via sysfs or patch option.
> See Documentation/sound/alsa/HD-Audio.txt.

Okay, thanks for the info.

I experimented more and have some additional information that might be
interesting:

1. The clicks and pops sound like they are actually brief snippets of audio=
 that
   are being played at the wrong time and mixed in with the correct audio.

2. With the old driver, when I mute some of the mixer controls the audio st=
ream
   becomes silent as expected but I still hear the snippets/clicks and pops=
 for
   a few seconds.  This happens with the Master Front, Headphone, Front,
   Surround, Center, LFE, and Side elements, although it only seems to happ=
en
   with the Headphone element when I'm using the rear panel line out (RCA)
   jacks.  I do not see this with the snapshot driver.
  =20
#2 in particular is puzzling to me, but maybe that is due to not understand=
ing
the hardware well enough.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6DjbgACgkQRO4fQQdv5AxhvACgrvF4nqfm/i9LEdhsaYBLoBip
mY0An3wsVVfKywnj2iDXoTscSavGqouy
=E1nD
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

--===============2773956623044085249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2773956623044085249==--
