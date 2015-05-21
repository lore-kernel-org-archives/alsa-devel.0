From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [REGRESSION] 4.1-rc4: Sound muted after boot
Date: Thu, 21 May 2015 11:08:36 +0200
Message-ID: <2273195.tahhRQoM4G@merkaba>
References: <1902192.Ae1uPbIBnJ@merkaba> <s5hfv6q5zbr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfv6q5zbr.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 21. Mai 2015, 06:28:24 schrieb Takashi Iwai:
> At Wed, 20 May 2015 16:31:55 +0200,
>=20
> Martin Steigerwald wrote:
> > Hello!
> >=20
> > On ThinkPad T520 (Intel Sandybridge) with 4.14-rc4 + two BTRFS patc=
hes
> > and one Intel P-State debug patch I have no sound output on interna=
l
> > Intel HD audio codec.
> >=20
> > According to ThinkPad T520 LED with striked-through speaker the lou=
d
> > speaker is in disabled state. Also KDE=C2=B4s Phonon says a soundca=
rd is
> > missing. In alsa-mixer I see nothing as MM for muted. If I press th=
e
> > key next to the LED I get a notification on the desktop that loud
> > speaker has been enabled / disabled, but the LED still is on for it
> > being disabled.

One clarification: Phonon still seems to see a sound card=E2=80=A6 but =
it reports a=20
change to the list of soundcards.

And another observation: The speaker disable LED is switched on KDE/Pla=
sma=20
4.14.2 session startup, I just rebooted to 4.1-rc4 after I gathered deb=
ug=20
output of 4.0.1, and there on boot the speaker disable LED was off duri=
ng=20
boot.

So there seems Phonon is confused about some difference in ALSA between=
 these=20
two kernel versions and probably doesn=C2=B4t fully find the sound card=
 or mutes=20
it, but on the other hand I can=C2=B4t see it in alsa-mixer as muted.

And alsa-mixer still finds the internal sound.

Also this does not happen for external USB JBL Pebbles speakers (excell=
ent=20
ones!) at home, sound just works with 4.1-rc4 with these.

I am now on 4.1-rc4 again so could try to dig out more what KDE Phonon =
sees=20
as a difference. In trainings breaks. Now need to continue with the cou=
rse I=20
hold.

Phonon runs without PulseAudio here, cause PulseAudio creates additiona=
l=20
issues with sound. Okay, this is the message I get:

KDE hat festgestellt, dass eines oder mehrere interne Ger=C3=A4te entfe=
rnt=20
wurden.
Soll KDE die Informationen zu diesen Ger=C3=A4ten dauerhaft l=C3=B6sche=
n?
Dies ist die Liste der Ger=C3=A4te, die entfernt werden k=C3=B6nnen:
Aufnahme: HDA Intel PCH (CX20590 Analog)
Wiedergabe: HDA Intel PCH (CX20590 Analog)

Which means: KDE has found that one or more internal devices were remov=
ed.

So it seems KDE really does not find the sound card anymore, while alsa=
-mixer=20
finds it, yet, also aplay does not produce any sound.

But then I still have a "HDA Intel PCH (CX20590 Analog)" in systemsetti=
ngs=20
for Phonon. There is one greyed out and another one which is not greyed=
 out,=20
but does not produce any sound on clicking the test button either.

> > I do not hear anything in Amarok or with aplay. alsa-mixer sound vo=
lumes
> > are 100 for master and PCM. I also tried with disabling "Auto-Mute
> > Mod", but still no sound.
> >=20
> > When I reboot and in BIOS or GRUB press the key then the LED toggle=
s
> > state.
> >=20
> > When I reboot into Linux 4.0.1 sound is working fine and loud speak=
er
> > disabled LED is toggled off, so I bet this is a regression 4.1-rc4
> > compared to 4.0.1.
>=20
> Please run alsa-info.sh at both working and non-working cases (with
> old and new kernels), and attach the outputs. Run the script with
> --no-upload option.

I sent a separate mail with these already.

> Also, such a problem is rather the device permissions problem.
> Check the device permissions of /dev/snd/* files (also check getfacl
> /dev/snd/*, too).

--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
