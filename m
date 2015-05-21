From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [REGRESSION] 4.1-rc4: Sound muted after boot
Date: Thu, 21 May 2015 11:52:08 +0200
Message-ID: <2833904.edl5C89hXc@merkaba>
References: <1902192.Ae1uPbIBnJ@merkaba> <1688502.MOfemOJOb1@merkaba> <s5h382qi93r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h382qi93r.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 21. Mai 2015, 11:16:24 schrieb Takashi Iwai:
> At Thu, 21 May 2015 10:53:46 +0200,
>=20
> Martin Steigerwald wrote:
> > Am Donnerstag, 21. Mai 2015, 06:28:24 schrieb Takashi Iwai:
> > > At Wed, 20 May 2015 16:31:55 +0200,
> > >=20
> > > Martin Steigerwald wrote:
> > > > Hello!
> > > >=20
> > > > On ThinkPad T520 (Intel Sandybridge) with 4.14-rc4 + two BTRFS
> > > > patches
> > > > and one Intel P-State debug patch I have no sound output on int=
ernal
> > > > Intel HD audio codec.
> > > >=20
> > > > According to ThinkPad T520 LED with striked-through speaker the=
 loud
> > > > speaker is in disabled state. Also KDE=B4s Phonon says a soundc=
ard is
> > > > missing. In alsa-mixer I see nothing as MM for muted. If I pres=
s the
> > > > key next to the LED I get a notification on the desktop that lo=
ud
> > > > speaker has been enabled / disabled, but the LED still is on fo=
r it
> > > > being disabled.
> > > >=20
> > > > I do not hear anything in Amarok or with aplay. alsa-mixer soun=
d
> > > > volumes
> > > > are 100 for master and PCM. I also tried with disabling "Auto-M=
ute
> > > > Mod", but still no sound.
> > > >=20
> > > > When I reboot and in BIOS or GRUB press the key then the LED to=
ggles
> > > > state.
> > > >=20
> > > > When I reboot into Linux 4.0.1 sound is working fine and loud
> > > > speaker
> > > > disabled LED is toggled off, so I bet this is a regression 4.1-=
rc4
> > > > compared to 4.0.1.
> > >=20
> > > Please run alsa-info.sh at both working and non-working cases (wi=
th
> > > old and new kernels), and attach the outputs. Run the script with
> > > --no-upload option.
> >=20
> > All attached.
> >=20
> > I also have full dmesg outputs available in case it is needed.
> >=20
> > > Also, such a problem is rather the device permissions problem.
> > > Check the device permissions of /dev/snd/* files (also check getf=
acl
> > > /dev/snd/*, too).
> >=20
> > If its a permissions problem, why does it happen with 4.1-rc4, but =
not
> > with 4.0.1 oder any earlier kernels?
>=20
> I wanted to mean it's rather "often" a permission problem.  Not
> necessarily your case, but still worth to check.
>=20
> The mute LED behavior change is because of the new control added
> recently.  You seem to have changed the value to "On" while the
> default should be "Follow Master".  This explains the difference of
> behavior from 4.0.  It's no regression but manual misconfiguration by
> user.  In this mode, LED has no connection with the sound output at
> all.

I didn=B4t change ALSA configuration on upgrade from 4.0 to 4.1. Can it=
 be it=20
picked "On" as default? Cause I certainly didn=B4t touch this. Unless i=
t could=20
have been changed on earlier kernels as well. Well then it could be, ca=
use=20
there have been times I tried to set stuff in ALSA for various reasons,=
 but=20
quite some time ago.

I only changed "Auto-Mute Mod" to "disabled" as I tried to debug the mu=
ting=20
issue, but other than that I didn=B4t change=20

> Other than that, no different is seen in the hardware level.  The
> codec registers show all same values.  That is, from the driver POV,
> the sound should work.  (Though, you set "Disabled" to "Auto-Mute
> Mode" control which looks rather weird.)
>=20
> So, revert "Mute-LED Mode" control to "Follow Master".  It can be don=
e
> via alsamixer, amixer or whatever.  Then check whether the sound
> works again.  Check also from the headphone, too.

That works. Thank you. Headphone I will check later.

Ciao,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
