From: =?UTF-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>
Subject: Bug#908938: [alsa-devel] Bug#908938: alsa-utils: amixer does not unmute pulseaudio
Date: Mon, 17 Sep 2018 21:35:32 +0200
Message-ID: <878t3z9at7.fsf%steelman@post.pl>
References: <87lg8194nz.fsf%steelman@post.pl> <20180917073732.jcdgihgwi7bvtvj3@toy.home.lxtec.de> <0f157593-9ff7-beb0-5477-a4a8c34ed81a@ladisch.de> <87lg8194nz.fsf%steelman@post.pl>
Reply-To: =?UTF-8?Q?=C5=81ukasz?= Stelmach <steelman@post.pl>, 908938@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.908938.B908938.15372129465957@bugs.debian.org>
In-Reply-To: <0f157593-9ff7-beb0-5477-a4a8c34ed81a@ladisch.de> (Clemens
	Ladisch's message of "Mon, 17 Sep 2018 11:07:37 +0200")
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, 908938@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Control: reassign -1 pulseaudio
Control: severity -1 minor

Clemens Ladisch <clemens@ladisch.de> writes:

> In theory, alsamixer and amixer should be able to access the same control=
s in the same way.
>
> Please show the output of "amixer scontrols".
> What is the output of the "toggle"/"unmute" commands without "-q"?

=2D-8<---------------cut here---------------start------------->8---
$ amixer -c 0 sset Master toggle
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 85 [67%] [-31.50dB] [off]
$ amixer -c 0 sset Master toggle
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 85 [67%] [-31.50dB] [on]
$ amixer -c 0 scontrols
Simple mixer control 'Master',0
Simple mixer control 'Headphone',0
Simple mixer control 'Speaker+LO',0
Simple mixer control 'PCM',0
Simple mixer control 'IEC958',0
Simple mixer control 'IEC958',1
Simple mixer control 'IEC958',2
Simple mixer control 'Beep',0
Simple mixer control 'Capture',0
Simple mixer control 'Auto-Mute Mode',0
Simple mixer control 'Digital',0
Simple mixer control 'Dock Mic',0
Simple mixer control 'Dock Mic Boost',0
Simple mixer control 'Headset Mic',0
Simple mixer control 'Headset Mic Boost',0
Simple mixer control 'Internal Mic Boost',0
Simple mixer control 'Loopback Mixing',0
=2D-8<---------------cut here---------------end--------------->8---

OK, -c0 means amixer is accessing the hardware instead of
PulseAudio. (Somehow I have assumed PA is selectable via -c, my
mistake.) Without -c the output is simpler.

=2D-8<---------------cut here---------------start------------->8---
$ amixer scontrols
Simple mixer control 'Master',0
Simple mixer control 'Capture',0
=2D-8<---------------cut here---------------end--------------->8---

This is PulseAudio. Indeed, when I run alsamixer -c0 and see the
hardware (previously I wasn't specifing -c0), the Master is unmuted
properly. However, Speker+LO (which is muted by the first toggle) is not
unmuted. I believe, this is a problem with PulseAudio rather than with
ALSA. Unmuting both Master and Speaker+LO hardware channels makes PA
unmute master.

amixer without -c mutes and unmutes PA as expected.

Thank you for helping to figure all this stuff out.
=2D-=20
By=C5=82o mi bardzo mi=C5=82o.                                  --- Rurku. =
--- ...
>=C5=81ukasz<                                --- To dobrze, =C5=BCe mnie s=
=C5=82uchasz.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEkPlMeih05HaDBMFPALaXbGOR03EFAlugAgZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDkw
Rjk0QzdBMjg3NEU0NzY4MzA0QzE0RjAwQjY5NzZDNjM5MUQzNzEACgkQALaXbGOR
03HF7gf7BnySyJ5I8bDMYc0Gl8eATujRrEAuhOLExscPIEOtHUDnCXPOFf/GC3kr
LS+qfJAtFX7QVzl8oDbOaAJGfqS+LxduIVJiqDhMYP6Sa2VtnBP8hvixLM6Ol1Sm
5+HTLAq612XCAeECj1txBoi4jIW62/IK/q5C1IDamVaODft8ThkaqJltFj4Df3I6
1oE578ESCF8u+Q2IsKCrBWY58OwWSOYAReUVl2n3RfjbQIpkBzpMytBmcL3f3ZN0
MBy1H2LDPdIezEtg2RpMblSXPFPmdjkBj6xHyMCGvMyOEMpykXuJhKvpdrBiEddE
FeV/2oMoSs9cLpLNi90AdsgTf3y/rw==
=PzgD
-----END PGP SIGNATURE-----
--=-=-=--
