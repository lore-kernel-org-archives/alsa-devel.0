From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [REGRESSION] 4.1-rc4: Sound muted after boot
Date: Thu, 21 May 2015 13:23:54 +0200
Message-ID: <5064269.CSrZTixCiO@merkaba>
References: <1902192.Ae1uPbIBnJ@merkaba> <2833904.edl5C89hXc@merkaba> <s5htwv6gs65.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htwv6gs65.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 21. Mai 2015, 12:07:30 schrieb Takashi Iwai:
> At Thu, 21 May 2015 11:52:08 +0200,
>=20
> Martin Steigerwald wrote:
> > Am Donnerstag, 21. Mai 2015, 11:16:24 schrieb Takashi Iwai:
> > > At Thu, 21 May 2015 10:53:46 +0200,
> > >=20
> > > Martin Steigerwald wrote:
> > > > Am Donnerstag, 21. Mai 2015, 06:28:24 schrieb Takashi Iwai:
> > > > > At Wed, 20 May 2015 16:31:55 +0200,
> > > > >=20
> > > > > Martin Steigerwald wrote:
> > > > > > Hello!
> > > > > >=20
> > > > > > On ThinkPad T520 (Intel Sandybridge) with 4.14-rc4 + two BT=
RFS
> > > > > > patches
> > > > > > and one Intel P-State debug patch I have no sound output on
> > > > > > internal
> > > > > > Intel HD audio codec.
> > > > > >=20
> > > > > > According to ThinkPad T520 LED with striked-through speaker=
 the
> > > > > > loud
> > > > > > speaker is in disabled state. Also KDE=B4s Phonon says a so=
undcard
> > > > > > is
> > > > > > missing. In alsa-mixer I see nothing as MM for muted. If I =
press
> > > > > > the
> > > > > > key next to the LED I get a notification on the desktop tha=
t
> > > > > > loud
> > > > > > speaker has been enabled / disabled, but the LED still is o=
n for
> > > > > > it
> > > > > > being disabled.
> > > > > >=20
> > > > > > I do not hear anything in Amarok or with aplay. alsa-mixer =
sound
> > > > > > volumes
> > > > > > are 100 for master and PCM. I also tried with disabling
> > > > > > "Auto-Mute
> > > > > > Mod", but still no sound.
> > > > > >=20
> > > > > > When I reboot and in BIOS or GRUB press the key then the LE=
D
> > > > > > toggles
> > > > > > state.
> > > > > >=20
> > > > > > When I reboot into Linux 4.0.1 sound is working fine and lo=
ud
> > > > > > speaker
> > > > > > disabled LED is toggled off, so I bet this is a regression
> > > > > > 4.1-rc4
> > > > > > compared to 4.0.1.
> > > > >=20
> > > > > Please run alsa-info.sh at both working and non-working cases
> > > > > (with
> > > > > old and new kernels), and attach the outputs. Run the script =
with
> > > > > --no-upload option.
> > > >=20
> > > > All attached.
> > > >=20
> > > > I also have full dmesg outputs available in case it is needed.
> > > >=20
> > > > > Also, such a problem is rather the device permissions problem=
=2E
> > > > > Check the device permissions of /dev/snd/* files (also check
> > > > > getfacl
> > > > > /dev/snd/*, too).
> > > >=20
> > > > If its a permissions problem, why does it happen with 4.1-rc4, =
but
> > > > not
> > > > with 4.0.1 oder any earlier kernels?
> > >=20
> > > I wanted to mean it's rather "often" a permission problem.  Not
> > > necessarily your case, but still worth to check.
> > >=20
> > > The mute LED behavior change is because of the new control added
> > > recently.  You seem to have changed the value to "On" while the
> > > default should be "Follow Master".  This explains the difference =
of
> > > behavior from 4.0.  It's no regression but manual misconfiguratio=
n by
> > > user.  In this mode, LED has no connection with the sound output =
at
> > > all.
> >=20
> > I didn=B4t change ALSA configuration on upgrade from 4.0 to 4.1. Ca=
n it be
> > it picked "On" as default?
>=20
> It shouldn't.  The default is "follow master".
> Might it be changed by kmix or such...?

I don=B4t know, but in my KMix setup the Mute-LED Mode is not within th=
e=20
displayed channels, but on available channels, so I didn=B4t see this.
=20
> > > Other than that, no different is seen in the hardware level.  The
> > > codec registers show all same values.  That is, from the driver P=
OV,
> > > the sound should work.  (Though, you set "Disabled" to "Auto-Mute
> > > Mode" control which looks rather weird.)
> > >=20
> > > So, revert "Mute-LED Mode" control to "Follow Master".  It can be=
 done
> > > via alsamixer, amixer or whatever.  Then check whether the sound
> > > works again.  Check also from the headphone, too.
> >=20
> > That works. Thank you. Headphone I will check later.
>=20
> Interesting.  Could you confirm that changing "Mute-LED Mode" really
> mutes the output, not only changing the LED?  This control was
> supposed to behave independently from the sound output.

When I set it back to "On" again output is muted. On setting "Off" or "=
=46ollow=20
master" I can hear sound.

Thanks,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
