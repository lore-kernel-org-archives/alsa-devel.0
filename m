From: Ivica Bukvic <ico@fuse.net>
Subject: Alsa intel8x0 driver on Inspiron8200 and Kmix do not work
Date: Mon, 24 Feb 2003 21:16:51 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302242116.51060.ico@fuse.net>
Reply-To: ico@fuse.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

Here's the problem I have (or I've been having for a long time now).

I've successfuly installed the alsa's driver and the sound works ok. But,=
=20
every time I open Kmix (since I am using KDE as my primary desktop) I can=
=20
adjust all the levels, but the only available audio inputs are Main, Line=
,=20
CD, Line1, PhoneIn, and Video (whatever those are).

Microphone for some reason cannot be selected. Same is with aumix

However, when I use alsamixer I can select the microphone as an input.

Furthermore, because of this anything that goes through artsd (kde's soun=
d=20
server) cannot be inputed from the microphone.

So, I am just wondering where the problem lies, is it the config for the=20
intel8x0 driver (I have CS4205 chip inside my laptop) or is it the KDE to=
=20
blame.

Below, I am including the /etc/asound.state, /etc/modules.conf, and  amix=
er:
(I have alsa configured so that my 1st card is CS4205, 2nd is HDSP (which=
 may=20
or may not be present), and 3rd is Midisport 2x2 (which may or may not be=
=20
present).

(please let me know if you need any other info from me)
Any help on this issue is greatly appreciated!


/etc/asound.state:
state.card0 {
=09control.1 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Master Playback Switch'
=09=09value false
=09}
=09control.2 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Master Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.3 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Master Mono Playback Switch'
=09=09value false
=09}
=09control.4 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Master Mono Playback Volume'
=09=09value 0
=09}
=09control.5 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Tone Control - Bass'
=09=09value 0
=09}
=09control.6 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Tone Control - Treble'
=09=09value 0
=09}
=09control.7 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PC Speaker Playback Switch'
=09=09value false
=09}
=09control.8 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'PC Speaker Playback Volume'
=09=09value 0
=09}
=09control.9 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Phone Playback Switch'
=09=09value false
=09}
=09control.10 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Phone Playback Volume'
=09=09value 0
=09}
=09control.11 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Playback Switch'
=09=09value false
=09}
=09control.12 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Mic Playback Volume'
=09=09value 0
=09}
=09control.13 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Boost (+20dB)'
=09=09value false
=09}
=09control.14 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Line Playback Switch'
=09=09value false
=09}
=09control.15 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Line Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.16 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'CD Playback Switch'
=09=09value false
=09}
=09control.17 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'CD Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.18 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Video Playback Switch'
=09=09value false
=09}
=09control.19 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Video Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.20 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Aux Playback Switch'
=09=09value false
=09}
=09control.21 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Aux Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.22 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PCM Playback Switch'
=09=09value false
=09}
=09control.23 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'PCM Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.24 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic
=09=09comment.item.1 CD
=09=09comment.item.2 Video
=09=09comment.item.3 Aux
=09=09comment.item.4 Line
=09=09comment.item.5 Mix
=09=09comment.item.6 'Mix Mono'
=09=09comment.item.7 Phone
=09=09iface MIXER
=09=09name 'Capture Source'
=09=09value.0 Mic
=09=09value.1 Mic
=09}
=09control.25 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Capture Switch'
=09=09value true
=09}
=09control.26 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Capture Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.27 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Capture Switch'
=09=09value true
=09}
=09control.28 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Mic Capture Volume'
=09=09value 0
=09}
=09control.29 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 'pre 3D'
=09=09comment.item.1 'post 3D'
=09=09iface MIXER
=09=09name 'PCM Out Path & Mute'
=09=09value 'pre 3D'
=09}
=09control.30 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Simulated Stereo Enhancement'
=09=09value false
=09}
=09control.31 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name '3D Control - Switch'
=09=09value false
=09}
=09control.32 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Loudness (bass boost)'
=09=09value false
=09}
=09control.33 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mix
=09=09comment.item.1 Mic
=09=09iface MIXER
=09=09name 'Mono Output Select'
=09=09value Mix
=09}
=09control.34 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic1
=09=09comment.item.1 Mic2
=09=09iface MIXER
=09=09name 'Mic Select'
=09=09value Mic1
=09}
=09control.35 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name '3D Control - Center'
=09=09value 0
=09}
=09control.36 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name '3D Control - Depth'
=09=09value 0
=09}
=09control.37 {
=09=09comment.access read
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Con Mask'
=09=09value=20
'0fff000f0000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
=09}
=09control.38 {
=09=09comment.access read
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Pro Mask'
=09=09value=20
cf00000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000
=09}
=09control.39 {
=09=09comment.access 'read write'
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Default'
=09=09value=20
'008200020000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
=09}
=09control.40 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'IEC958 Playback Switch'
=09=09value false
=09}
=09control.41 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'External Amplifier Power Down'
=09=09value false
=09}
=09control.42 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.43 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Mic Playback Volume'
=09=09index 1
=09=09value 0
=09}
=09control.44 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Boost (+20dB)'
=09=09index 1
=09=09value false
=09}
=09control.45 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Line Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.46 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Line Playback Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
=09control.47 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'CD Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.48 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'CD Playback Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
=09control.49 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PCM Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.50 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'PCM Playback Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
=09control.51 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic
=09=09comment.item.1 CD
=09=09comment.item.2 Video
=09=09comment.item.3 Aux
=09=09comment.item.4 Line
=09=09comment.item.5 Mix
=09=09comment.item.6 'Mix Mono'
=09=09comment.item.7 Phone
=09=09iface MIXER
=09=09name 'Capture Source'
=09=09index 1
=09=09value.0 Mic
=09=09value.1 Mic
=09}
=09control.52 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Capture Switch'
=09=09index 1
=09=09value true
=09}
=09control.53 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Capture Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
}
state.card1 {
=09control.1 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Master Playback Switch'
=09=09value true
=09}
=09control.2 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Master Playback Volume'
=09=09value.0 5
=09=09value.1 5
=09}
=09control.3 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Master Mono Playback Switch'
=09=09value false
=09}
=09control.4 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Master Mono Playback Volume'
=09=09value 0
=09}
=09control.5 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Tone Control - Bass'
=09=09value 10
=09}
=09control.6 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Tone Control - Treble'
=09=09value 10
=09}
=09control.7 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PC Speaker Playback Switch'
=09=09value true
=09}
=09control.8 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'PC Speaker Playback Volume'
=09=09value 9
=09}
=09control.9 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Phone Playback Switch'
=09=09value false
=09}
=09control.10 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Phone Playback Volume'
=09=09value 0
=09}
=09control.11 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Playback Switch'
=09=09value false
=09}
=09control.12 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Mic Playback Volume'
=09=09value 0
=09}
=09control.13 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Boost (+20dB)'
=09=09value false
=09}
=09control.14 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Line Playback Switch'
=09=09value false
=09}
=09control.15 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Line Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.16 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'CD Playback Switch'
=09=09value true
=09}
=09control.17 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'CD Playback Volume'
=09=09value.0 27
=09=09value.1 27
=09}
=09control.18 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Video Playback Switch'
=09=09value false
=09}
=09control.19 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Video Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.20 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Aux Playback Switch'
=09=09value false
=09}
=09control.21 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Aux Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.22 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PCM Playback Switch'
=09=09value true
=09}
=09control.23 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'PCM Playback Volume'
=09=09value.0 29
=09=09value.1 29
=09}
=09control.24 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic
=09=09comment.item.1 CD
=09=09comment.item.2 Video
=09=09comment.item.3 Aux
=09=09comment.item.4 Line
=09=09comment.item.5 Mix
=09=09comment.item.6 'Mix Mono'
=09=09comment.item.7 Phone
=09=09iface MIXER
=09=09name 'Capture Source'
=09=09value.0 Mix
=09=09value.1 Mix
=09}
=09control.25 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Capture Switch'
=09=09value true
=09}
=09control.26 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Capture Volume'
=09=09value.0 12
=09=09value.1 12
=09}
=09control.27 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Capture Switch'
=09=09value true
=09}
=09control.28 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Mic Capture Volume'
=09=09value 0
=09}
=09control.29 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 'pre 3D'
=09=09comment.item.1 'post 3D'
=09=09iface MIXER
=09=09name 'PCM Out Path & Mute'
=09=09value 'pre 3D'
=09}
=09control.30 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Simulated Stereo Enhancement'
=09=09value false
=09}
=09control.31 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name '3D Control - Switch'
=09=09value false
=09}
=09control.32 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Loudness (bass boost)'
=09=09value false
=09}
=09control.33 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mix
=09=09comment.item.1 Mic
=09=09iface MIXER
=09=09name 'Mono Output Select'
=09=09value Mix
=09}
=09control.34 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic1
=09=09comment.item.1 Mic2
=09=09iface MIXER
=09=09name 'Mic Select'
=09=09value Mic1
=09}
=09control.35 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name '3D Control - Center'
=09=09value 0
=09}
=09control.36 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name '3D Control - Depth'
=09=09value 0
=09}
=09control.37 {
=09=09comment.access read
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Con Mask'
=09=09value=20
'0fff000f0000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
=09}
=09control.38 {
=09=09comment.access read
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Pro Mask'
=09=09value=20
cf00000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000
=09}
=09control.39 {
=09=09comment.access 'read write'
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Default'
=09=09value=20
'008200020000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
=09}
=09control.40 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'IEC958 Playback Switch'
=09=09value false
=09}
=09control.41 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'External Amplifier Power Down'
=09=09value false
=09}
=09control.42 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.43 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Mic Playback Volume'
=09=09index 1
=09=09value 0
=09}
=09control.44 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Boost (+20dB)'
=09=09index 1
=09=09value false
=09}
=09control.45 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Line Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.46 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Line Playback Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
=09control.47 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'CD Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.48 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'CD Playback Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
=09control.49 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PCM Playback Switch'
=09=09index 1
=09=09value true
=09}
=09control.50 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'PCM Playback Volume'
=09=09index 1
=09=09value.0 20
=09=09value.1 20
=09}
=09control.51 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic
=09=09comment.item.1 CD
=09=09comment.item.2 Video
=09=09comment.item.3 Aux
=09=09comment.item.4 Line
=09=09comment.item.5 Mix
=09=09comment.item.6 'Mix Mono'
=09=09comment.item.7 Phone
=09=09iface MIXER
=09=09name 'Capture Source'
=09=09index 1
=09=09value.0 Mic
=09=09value.1 Mic
=09}
=09control.52 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Capture Switch'
=09=09index 1
=09=09value true
=09}
=09control.53 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Capture Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
}
state.82801CAICH3 {
=09control.1 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Master Playback Switch'
=09=09value true
=09}
=09control.2 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Master Playback Volume'
=09=09value.0 6
=09=09value.1 6
=09}
=09control.3 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Master Mono Playback Switch'
=09=09value false
=09}
=09control.4 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Master Mono Playback Volume'
=09=09value 0
=09}
=09control.5 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Tone Control - Bass'
=09=09value 8
=09}
=09control.6 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Tone Control - Treble'
=09=09value 8
=09}
=09control.7 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PC Speaker Playback Switch'
=09=09value true
=09}
=09control.8 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'PC Speaker Playback Volume'
=09=09value 10
=09}
=09control.9 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Phone Playback Switch'
=09=09value false
=09}
=09control.10 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Phone Playback Volume'
=09=09value 0
=09}
=09control.11 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Playback Switch'
=09=09value false
=09}
=09control.12 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Mic Playback Volume'
=09=09value 0
=09}
=09control.13 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Boost (+20dB)'
=09=09value false
=09}
=09control.14 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Line Playback Switch'
=09=09value false
=09}
=09control.15 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Line Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.16 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'CD Playback Switch'
=09=09value true
=09}
=09control.17 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'CD Playback Volume'
=09=09value.0 24
=09=09value.1 24
=09}
=09control.18 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Video Playback Switch'
=09=09value false
=09}
=09control.19 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Video Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.20 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Aux Playback Switch'
=09=09value false
=09}
=09control.21 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Aux Playback Volume'
=09=09value.0 0
=09=09value.1 0
=09}
=09control.22 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PCM Playback Switch'
=09=09value true
=09}
=09control.23 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'PCM Playback Volume'
=09=09value.0 24
=09=09value.1 24
=09}
=09control.24 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic
=09=09comment.item.1 CD
=09=09comment.item.2 Video
=09=09comment.item.3 Aux
=09=09comment.item.4 Line
=09=09comment.item.5 Mix
=09=09comment.item.6 'Mix Mono'
=09=09comment.item.7 Phone
=09=09iface MIXER
=09=09name 'Capture Source'
=09=09value.0 Mix
=09=09value.1 Mix
=09}
=09control.25 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Capture Switch'
=09=09value true
=09}
=09control.26 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Capture Volume'
=09=09value.0 13
=09=09value.1 13
=09}
=09control.27 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Capture Switch'
=09=09value true
=09}
=09control.28 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Mic Capture Volume'
=09=09value 0
=09}
=09control.29 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 'pre 3D'
=09=09comment.item.1 'post 3D'
=09=09iface MIXER
=09=09name 'PCM Out Path & Mute'
=09=09value 'pre 3D'
=09}
=09control.30 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Simulated Stereo Enhancement'
=09=09value false
=09}
=09control.31 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name '3D Control - Switch'
=09=09value false
=09}
=09control.32 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Loudness (bass boost)'
=09=09value false
=09}
=09control.33 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mix
=09=09comment.item.1 Mic
=09=09iface MIXER
=09=09name 'Mono Output Select'
=09=09value Mix
=09}
=09control.34 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic1
=09=09comment.item.1 Mic2
=09=09iface MIXER
=09=09name 'Mic Select'
=09=09value Mic1
=09}
=09control.35 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name '3D Control - Center'
=09=09value 0
=09}
=09control.36 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name '3D Control - Depth'
=09=09value 0
=09}
=09control.37 {
=09=09comment.access read
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Con Mask'
=09=09value=20
'0fff000f0000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
=09}
=09control.38 {
=09=09comment.access read
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Pro Mask'
=09=09value=20
cf00000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000
=09}
=09control.39 {
=09=09comment.access 'read write'
=09=09comment.type IEC958
=09=09iface MIXER
=09=09name 'IEC958 Playback Default'
=09=09value=20
'008200020000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000'
=09}
=09control.40 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'IEC958 Playback Switch'
=09=09value false
=09}
=09control.41 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 3'
=09=09iface MIXER
=09=09name 'IEC958 Playback AC97-SPSA'
=09=09value 0
=09}
=09control.42 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'External Amplifier Power Down'
=09=09value false
=09}
=09control.43 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.44 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Mic Playback Volume'
=09=09index 1
=09=09value 0
=09}
=09control.45 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Mic Boost (+20dB)'
=09=09index 1
=09=09value false
=09}
=09control.46 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Line Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.47 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'Line Playback Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
=09control.48 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'CD Playback Switch'
=09=09index 1
=09=09value false
=09}
=09control.49 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'CD Playback Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
=09control.50 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'PCM Playback Switch'
=09=09index 1
=09=09value true
=09}
=09control.51 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 31'
=09=09iface MIXER
=09=09name 'PCM Playback Volume'
=09=09index 1
=09=09value.0 23
=09=09value.1 23
=09}
=09control.52 {
=09=09comment.access 'read write'
=09=09comment.type ENUMERATED
=09=09comment.item.0 Mic
=09=09comment.item.1 CD
=09=09comment.item.2 Video
=09=09comment.item.3 Aux
=09=09comment.item.4 Line
=09=09comment.item.5 Mix
=09=09comment.item.6 'Mix Mono'
=09=09comment.item.7 Phone
=09=09iface MIXER
=09=09name 'Capture Source'
=09=09index 1
=09=09value.0 Mic
=09=09value.1 Mic
=09}
=09control.53 {
=09=09comment.access 'read write'
=09=09comment.type BOOLEAN
=09=09iface MIXER
=09=09name 'Capture Switch'
=09=09index 1
=09=09value true
=09}
=09control.54 {
=09=09comment.access 'read write'
=09=09comment.type INTEGER
=09=09comment.range '0 - 15'
=09=09iface MIXER
=09=09name 'Capture Volume'
=09=09index 1
=09=09value.0 0
=09=09value.1 0
=09}
}
state.2x2 {
}

/etc/modules.conf:
#load hdsp mem before everything else
options snd-hammerfall-mem snd_enable=3D1
options snd-hdsp snd_line_outs_monitor=3D1

alias net-pf-4 ipx
alias autofs autofs4
probeall scsi_hostadapter ide-scsi
alias eth0 3c59x
#alias sound-slot-0 i810_audio
alias ieee1394-controller ohci1394
alias /dev/nvidia*   NVdriver

# ALSA portion
alias char-major-116 snd
alias char-major-14 soundcore
alias snd-card-0 snd-intel8x0
alias snd-card-1 snd-hdsp
alias snd-card-2 snd-usb-midi
options snd major=3D116 cards_limit=3D4 device_mode=3D0666 device_gid=3D0=
 device_uid=3D0
options snd-usb-midi vid=3D0x763 pid=3D0x1001 index=3D1

# OSS/Free portion
# CS4205
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
#alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
#alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

#HDSP
alias sound-slot-1 snd-card-1
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-1 snd-seq-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss

#MIDISPORT
alias sound-service-2-1 snd-seq-oss
alias sound-service-2-8 snd-seq-oss

probeall usb-interface usb-uhci


amixer:
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 6 [19%] [on]=20
  Front Right: Playback 6 [19%] [on]=20
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 8 [53%]=20
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 8 [53%]=20
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]=20
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]=20
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 24 [77%] [on]=20
  Front Right: Playback 24 [77%] [on]=20
Simple mixer control 'PCM Out Path & Mute',0
  Capabilities:
  Mono:=20
Simple mixer control 'PCM',1
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 23 [74%] [on]=20
  Front Right: Playback 23 [74%] [on]=20
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined=20
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Line',1
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined=20
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined=20
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 24 [77%] [on] Capture [off]=20
  Front Right: Playback 24 [77%] [on] Capture [off]=20
Simple mixer control 'CD',1
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined=20
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined cvolume pswitch pswitch-joined csw=
itch=20
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31 Capture 0 - 15
  Mono: Playback 0 [0%] [off]=20
  Front Left: Capture 0 [0%] [off]=20
  Front Right: Capture 0 [0%] [off]=20
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Mic Boost (+20dB)',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono:=20
Simple mixer control 'Mic',1
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch=20
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 15=20
  Mono: Playback 0 [0%] [off]=20
  Front Left: Capture [on]=20
  Front Right: Capture [on]=20
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined=20
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Video',1
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch=20
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Mono: Playback 0 [0%] [off]=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Phone',1
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 0 [0%]=20
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15=20
  Mono: Playback 10 [67%] [on]=20
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined=20
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right=20
  Capture channels: Front Left - Front Right=20
  Limits: Playback 0 - 31=20
  Front Left: Playback 0 [0%] [off] Capture [off]=20
  Front Right: Playback 0 [0%] [off] Capture [off]=20
Simple mixer control 'Aux',1
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Mono Output Select',0
  Capabilities:
  Mono:=20
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right=20
  Limits: Capture 0 - 15
  Front Left: Capture 13 [87%] [on]=20
  Front Right: Capture 13 [87%] [on]=20
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right=20
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [on]=20
  Front Right: Capture 0 [0%] [on]=20
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [on]=20
  Front Right: Capture [on]=20
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Mix',1
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'Mix Mono',1
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right=20
  Front Left: Capture [off]=20
  Front Right: Capture [off]=20
Simple mixer control 'External Amplifier Power Down',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Loudness (bass boost)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20
Simple mixer control 'Simulated Stereo Enhancement',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]=20


Again, thanks for your help! (apologies for a lengthy e-mail)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
