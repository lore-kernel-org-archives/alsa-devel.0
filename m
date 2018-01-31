From: Charles Mulder <keyboardcolab@gmail.com>
Subject: Pls help to interpret diagnostic output
Date: Wed, 31 Jan 2018 07:21:22 +0000
Message-ID: <CALVpPLGbWFk5Wap4aNPSk5A5ipAEp3VvFEun_ZKFgh4gjZsKYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7226763645558481923=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/alsa-user>,
 <mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
 <mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============7226763645558481923==
Content-Type: multipart/alternative; boundary="f403045da1762a690f05640d5435"

--f403045da1762a690f05640d5435
Content-Type: text/plain; charset="UTF-8"

Hi.

I have an Audient iD14, which is a USB class compliant audio interface. The
sound output is very loud on the right and super soft on the left. I am
running Lubuntu 16.04 with ALSA only. No PulseAudio.

I have run some diagnostic commands. Would appreciate help interpreting the
output.

I'm trying to understand the problem, so I can find a solution.

*cat /proc/asound/cards *
 0 [iD14 ]: USB-Audio - Audient iD14
    Audient Audient iD14 at usb-0000:00:1d.0-1.3, high speed

*cat /proc/asound/card0/usbmixer*
USB Mixer: usb_id=0x27080002, ctrlif=0, ctlerr=0
Card: Audient Audient iD14 at usb-0000:00:1d.0-1.3, high speed
  Unit: 11
    Control: name="Phase Inverter Control", index=0
    Info: id=11, control=13, cmask=0x3ff, channels=10, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 11
    Control: name="Input Gain Control", index=0
    Info: id=11, control=11, cmask=0x3ff, channels=10, type="S16"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 12
    Control: name="Speaker Playback Volume", index=0
    Info: id=12, control=2, cmask=0xf, channels=4, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 40
    Control: name="Audient Clock Selector", index=0
    Info: id=40, control=1, cmask=0x0, channels=1, type="U8"
    Volume: min=1, max=3, dBmin=0, dBmax=0
  Unit: 41
    Control: name="Audient Internal Clock Validity", index=0
    Info: id=41, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 42
    Control: name="Audient S/PDIF Clock Validity", index=0
    Info: id=42, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 43
    Control: name="Audient ADAT Clock Validity", index=0
    Info: id=43, control=2, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 60
    Control: name="Audient iD14  Volume", index=3
    Info: id=60, control=4, cmask=0xf, channels=4, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 60
    Control: name="Audient iD14  Volume", index=2
    Info: id=60, control=3, cmask=0xf, channels=4, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 60
    Control: name="Audient iD14  Volume", index=1
    Info: id=60, control=2, cmask=0xf, channels=4, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0
  Unit: 60
    Control: name="Audient iD14  Volume", index=0
    Info: id=60, control=1, cmask=0xf, channels=4, type="S16"
    Volume: min=-32512, max=0, dBmin=-12700, dBmax=0

*cat /proc/asound/card0/pcm0p/info*
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

*aplay -l*
**** List of PLAYBACK Hardware Devices ****
card 0: iD14 [Audient iD14], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

*aplay -L*
null
    Discard all samples (playback) or generate zero samples (capture)
pulse
    PulseAudio Sound Server
default:CARD=iD14
    Audient iD14, USB Audio
    Default Audio Device
sysdefault:CARD=iD14
    Audient iD14, USB Audio
    Default Audio Device
front:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    Front speakers
surround21:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    2.1 Surround output to Front and Subwoofer speakers
surround40:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    4.0 Surround output to Front and Rear speakers
surround41:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    IEC958 (S/PDIF) Digital Audio Output
dmix:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    Direct sample mixing device
dsnoop:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    Direct sample snooping device
hw:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    Direct hardware device without any conversions
plughw:CARD=iD14,DEV=0
    Audient iD14, USB Audio
    Hardware device with all software conversions

*aplay -vv ~/Downloads/burn.wav *
Playing WAVE '/home/cm/Downloads/burn.wav' : Float 32 bit Little Endian,
Rate 48000 Hz, Stereo
Plug PCM: Linear Integer <-> Linear Float conversion PCM (S32_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Slave: Route conversion PCM (sformat=S32_LE)
  Transformation table:
    0 <- 0
    1 <- 1
    2 <- none
    3 <- none
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 4
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Hardware PCM card 0 'Audient iD14' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 4
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : ENABLE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4611686018427387904
  silence_threshold: 0
  silence_size : 4611686018427387904
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0

*./alsacap*
*** Scanning for playback devices ***
Card 0, ID `iD14', name `Audient iD14'
  Device 0, ID `USB Audio', name `USB Audio', 1 subdevices (1 available)
    4 channels, sampling rate 44100..96000 Hz
    Sample formats: S16_LE, S32_LE
      Subdevice 0, name `subdevice #0'
-- 
Charles Mulder
Software Engineer/Musician
mobile: +27 83 653 3698
phone: +27 27 948 2592
skype: charliemurder

--f403045da1762a690f05640d5435
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi.<br><br></div><div>I have an Audient iD1=
4, which is a USB class compliant audio interface. The sound output is very=
 loud on the right and super soft on the left. I am running Lubuntu 16.04 w=
ith ALSA only. No PulseAudio. </div><div><br></div><div>I have run some dia=
gnostic commands. Would appreciate help interpreting the output. <br><br></=
div><div>I&#39;m trying to understand the problem, so I can find a solution=
.<br></div><div><br><b>cat /proc/asound/cards </b><br><span style=3D"font-f=
amily:monospace">=C2=A00 [iD14 ]: USB-Audio - Audient iD14<br>=C2=A0=C2=A0=
=C2=A0 Audient Audient iD14 at usb-0000:00:1d.0-1.3, high speed<br><br></sp=
an></div><div><b>cat /proc/asound/card0/usbmixer</b><span style=3D"font-fam=
ily:monospace"><br>USB Mixer: usb_id=3D0x27080002, ctrlif=3D0, ctlerr=3D0<b=
r>Card: Audient Audient iD14 at usb-0000:00:1d.0-1.3, high speed<br>=C2=A0 =
Unit: 11<br>=C2=A0=C2=A0=C2=A0 Control: name=3D&quot;Phase Inverter Control=
&quot;, index=3D0<br>=C2=A0=C2=A0=C2=A0 Info: id=3D11, control=3D13, cmask=
=3D0x3ff, channels=3D10, type=3D&quot;BOOLEAN&quot;<br>=C2=A0=C2=A0=C2=A0 V=
olume: min=3D0, max=3D1, dBmin=3D0, dBmax=3D0<br>=C2=A0 Unit: 11<br>=C2=A0=
=C2=A0=C2=A0 Control: name=3D&quot;Input Gain Control&quot;, index=3D0<br>=
=C2=A0=C2=A0=C2=A0 Info: id=3D11, control=3D11, cmask=3D0x3ff, channels=3D1=
0, type=3D&quot;S16&quot;<br>=C2=A0=C2=A0=C2=A0 Volume: min=3D0, max=3D1, d=
Bmin=3D0, dBmax=3D0<br>=C2=A0 Unit: 12<br>=C2=A0=C2=A0=C2=A0 Control: name=
=3D&quot;Speaker Playback Volume&quot;, index=3D0<br>=C2=A0=C2=A0=C2=A0 Inf=
o: id=3D12, control=3D2, cmask=3D0xf, channels=3D4, type=3D&quot;S16&quot;<=
br>=C2=A0=C2=A0=C2=A0 Volume: min=3D-32512, max=3D0, dBmin=3D-12700, dBmax=
=3D0<br>=C2=A0 Unit: 40<br>=C2=A0=C2=A0=C2=A0 Control: name=3D&quot;Audient=
 Clock Selector&quot;, index=3D0<br>=C2=A0=C2=A0=C2=A0 Info: id=3D40, contr=
ol=3D1, cmask=3D0x0, channels=3D1, type=3D&quot;U8&quot;<br>=C2=A0=C2=A0=C2=
=A0 Volume: min=3D1, max=3D3, dBmin=3D0, dBmax=3D0<br>=C2=A0 Unit: 41<br>=
=C2=A0=C2=A0=C2=A0 Control: name=3D&quot;Audient Internal Clock Validity&qu=
ot;, index=3D0<br>=C2=A0=C2=A0=C2=A0 Info: id=3D41, control=3D2, cmask=3D0x=
0, channels=3D1, type=3D&quot;BOOLEAN&quot;<br>=C2=A0=C2=A0=C2=A0 Volume: m=
in=3D0, max=3D1, dBmin=3D0, dBmax=3D0<br>=C2=A0 Unit: 42<br>=C2=A0=C2=A0=C2=
=A0 Control: name=3D&quot;Audient S/PDIF Clock Validity&quot;, index=3D0<br=
>=C2=A0=C2=A0=C2=A0 Info: id=3D42, control=3D2, cmask=3D0x0, channels=3D1, =
type=3D&quot;BOOLEAN&quot;<br>=C2=A0=C2=A0=C2=A0 Volume: min=3D0, max=3D1, =
dBmin=3D0, dBmax=3D0<br>=C2=A0 Unit: 43<br>=C2=A0=C2=A0=C2=A0 Control: name=
=3D&quot;Audient ADAT Clock Validity&quot;, index=3D0<br>=C2=A0=C2=A0=C2=A0=
 Info: id=3D43, control=3D2, cmask=3D0x0, channels=3D1, type=3D&quot;BOOLEA=
N&quot;<br>=C2=A0=C2=A0=C2=A0 Volume: min=3D0, max=3D1, dBmin=3D0, dBmax=3D=
0<br>=C2=A0 Unit: 60<br>=C2=A0=C2=A0=C2=A0 Control: name=3D&quot;Audient iD=
14=C2=A0 Volume&quot;, index=3D3<br>=C2=A0=C2=A0=C2=A0 Info: id=3D60, contr=
ol=3D4, cmask=3D0xf, channels=3D4, type=3D&quot;S16&quot;<br>=C2=A0=C2=A0=
=C2=A0 Volume: min=3D-32512, max=3D0, dBmin=3D-12700, dBmax=3D0<br>=C2=A0 U=
nit: 60<br>=C2=A0=C2=A0=C2=A0 Control: name=3D&quot;Audient iD14=C2=A0 Volu=
me&quot;, index=3D2<br>=C2=A0=C2=A0=C2=A0 Info: id=3D60, control=3D3, cmask=
=3D0xf, channels=3D4, type=3D&quot;S16&quot;<br>=C2=A0=C2=A0=C2=A0 Volume: =
min=3D-32512, max=3D0, dBmin=3D-12700, dBmax=3D0<br>=C2=A0 Unit: 60<br>=C2=
=A0=C2=A0=C2=A0 Control: name=3D&quot;Audient iD14=C2=A0 Volume&quot;, inde=
x=3D1<br>=C2=A0=C2=A0=C2=A0 Info: id=3D60, control=3D2, cmask=3D0xf, channe=
ls=3D4, type=3D&quot;S16&quot;<br>=C2=A0=C2=A0=C2=A0 Volume: min=3D-32512, =
max=3D0, dBmin=3D-12700, dBmax=3D0<br>=C2=A0 Unit: 60<br>=C2=A0=C2=A0=C2=A0=
 Control: name=3D&quot;Audient iD14=C2=A0 Volume&quot;, index=3D0<br>=C2=A0=
=C2=A0=C2=A0 Info: id=3D60, control=3D1, cmask=3D0xf, channels=3D4, type=3D=
&quot;S16&quot;<br>=C2=A0=C2=A0=C2=A0 Volume: min=3D-32512, max=3D0, dBmin=
=3D-12700, dBmax=3D0<br><br></span></div><div><span style=3D"font-family:mo=
nospace"><b><font face=3D"sans-serif">cat /proc/asound/card0/pcm0p/info</fo=
nt></b><br>card: 0<br>device: 0<br>subdevice: 0<br>stream: PLAYBACK<br>id: =
USB Audio<br>name: USB Audio<br>subname: subdevice #0<br>class: 0<br>subcla=
ss: 0<br>subdevices_count: 1<br>subdevices_avail: 1<br></span></div><div><b=
r><b>aplay -l</b><br><span style=3D"font-family:monospace">**** List of PLA=
YBACK Hardware Devices ****<br>card 0: iD14 [Audient iD14], device 0: USB A=
udio [USB Audio]<br>=C2=A0 Subdevices: 1/1<br>=C2=A0 Subdevice #0: subdevic=
e #0</span><br><br><b>aplay -L</b><br><span style=3D"font-family:monospace"=
>null<br>=C2=A0=C2=A0=C2=A0 Discard all samples (playback) or generate zero=
 samples (capture)<br>pulse<br>=C2=A0=C2=A0=C2=A0 PulseAudio Sound Server<b=
r>default:CARD=3DiD14<br>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=
=A0=C2=A0=C2=A0 Default Audio Device<br>sysdefault:CARD=3DiD14<br>=C2=A0=C2=
=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=A0 Default Audio Devic=
e<br>front:CARD=3DiD14,DEV=3D0<br>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audi=
o<br>=C2=A0=C2=A0=C2=A0 Front speakers<br>surround21:CARD=3DiD14,DEV=3D0<br=
>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=A0 2.1 Surro=
und output to Front and Subwoofer speakers<br>surround40:CARD=3DiD14,DEV=3D=
0<br>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=A0 4.0 S=
urround output to Front and Rear speakers<br>surround41:CARD=3DiD14,DEV=3D0=
<br>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=A0 4.1 Su=
rround output to Front, Rear and Subwoofer speakers<br>surround50:CARD=3DiD=
14,DEV=3D0<br>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=
=A0 5.0 Surround output to Front, Center and Rear speakers<br>surround51:CA=
RD=3DiD14,DEV=3D0<br>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=
=C2=A0=C2=A0 5.1 Surround output to Front, Center, Rear and Subwoofer speak=
ers<br>surround71:CARD=3DiD14,DEV=3D0<br>=C2=A0=C2=A0=C2=A0 Audient iD14, U=
SB Audio<br>=C2=A0=C2=A0=C2=A0 7.1 Surround output to Front, Center, Side, =
Rear and Woofer speakers<br>iec958:CARD=3DiD14,DEV=3D0<br>=C2=A0=C2=A0=C2=
=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=A0 IEC958 (S/PDIF) Digital A=
udio Output<br>dmix:CARD=3DiD14,DEV=3D0<br>=C2=A0=C2=A0=C2=A0 Audient iD14,=
 USB Audio<br>=C2=A0=C2=A0=C2=A0 Direct sample mixing device<br>dsnoop:CARD=
=3DiD14,DEV=3D0<br>=C2=A0=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=
=A0=C2=A0 Direct sample snooping device<br>hw:CARD=3DiD14,DEV=3D0<br>=C2=A0=
=C2=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=A0 Direct hardware =
device without any conversions<br>plughw:CARD=3DiD14,DEV=3D0<br>=C2=A0=C2=
=A0=C2=A0 Audient iD14, USB Audio<br>=C2=A0=C2=A0=C2=A0 Hardware device wit=
h all software conversions</span><br><br></div><b>aplay -vv ~/Downloads/bur=
n.wav </b><span style=3D"font-family:monospace"><br>Playing WAVE &#39;/home=
/cm/Downloads/burn.wav&#39; : Float 32 bit Little Endian, Rate 48000 Hz, St=
ereo<br>Plug PCM: Linear Integer &lt;-&gt; Linear Float conversion PCM (S32=
_LE)<br>Its setup is:<br>=C2=A0 stream=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
: PLAYBACK<br>=C2=A0 access=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : RW_INTERL=
EAVED<br>=C2=A0 format=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : FLOAT_LE<br>=
=C2=A0 subformat=C2=A0=C2=A0=C2=A0 : STD<br>=C2=A0 channels=C2=A0=C2=A0=C2=
=A0=C2=A0 : 2<br>=C2=A0 rate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : 48000<br>=C2=A0 exact rate=C2=A0=C2=A0 : 48000 (48000/1)<br>=C2=A0 ms=
bits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 32<br>=C2=A0 buffer_size=C2=A0 :=
 16384<br>=C2=A0 period_size=C2=A0 : 1024<br>=C2=A0 period_time=C2=A0 : 213=
33<br>=C2=A0 tstamp_mode=C2=A0 : NONE<br>=C2=A0 tstamp_type=C2=A0 : MONOTON=
IC<br>=C2=A0 period_step=C2=A0 : 1<br>=C2=A0 avail_min=C2=A0=C2=A0=C2=A0 : =
1024<br>=C2=A0 period_event : 0<br>=C2=A0 start_threshold=C2=A0 : 16384<br>=
=C2=A0 stop_threshold=C2=A0=C2=A0 : 16384<br>=C2=A0 silence_threshold: 0<br=
>=C2=A0 silence_size : 0<br>=C2=A0 boundary=C2=A0=C2=A0=C2=A0=C2=A0 : 46116=
86018427387904<br>Slave: Route conversion PCM (sformat=3DS32_LE)<br>=C2=A0 =
Transformation table:<br>=C2=A0=C2=A0=C2=A0 0 &lt;- 0<br>=C2=A0=C2=A0=C2=A0=
 1 &lt;- 1<br>=C2=A0=C2=A0=C2=A0 2 &lt;- none<br>=C2=A0=C2=A0=C2=A0 3 &lt;-=
 none<br>Its setup is:<br>=C2=A0 stream=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 : PLAYBACK<br>=C2=A0 access=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : MMAP_INT=
ERLEAVED<br>=C2=A0 format=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : S32_LE<br>=
=C2=A0 subformat=C2=A0=C2=A0=C2=A0 : STD<br>=C2=A0 channels=C2=A0=C2=A0=C2=
=A0=C2=A0 : 2<br>=C2=A0 rate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : 48000<br>=C2=A0 exact rate=C2=A0=C2=A0 : 48000 (48000/1)<br>=C2=A0 ms=
bits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 32<br>=C2=A0 buffer_size=C2=A0 :=
 16384<br>=C2=A0 period_size=C2=A0 : 1024<br>=C2=A0 period_time=C2=A0 : 213=
33<br>=C2=A0 tstamp_mode=C2=A0 : NONE<br>=C2=A0 tstamp_type=C2=A0 : MONOTON=
IC<br>=C2=A0 period_step=C2=A0 : 1<br>=C2=A0 avail_min=C2=A0=C2=A0=C2=A0 : =
1024<br>=C2=A0 period_event : 0<br>=C2=A0 start_threshold=C2=A0 : 16384<br>=
=C2=A0 stop_threshold=C2=A0=C2=A0 : 16384<br>=C2=A0 silence_threshold: 0<br=
>=C2=A0 silence_size : 0<br>=C2=A0 boundary=C2=A0=C2=A0=C2=A0=C2=A0 : 46116=
86018427387904<br>Slave: Direct Stream Mixing PCM<br>Its setup is:<br>=C2=
=A0 stream=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : PLAYBACK<br>=C2=A0 access=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : MMAP_INTERLEAVED<br>=C2=A0 format=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : S32_LE<br>=C2=A0 subformat=C2=A0=C2=A0=
=C2=A0 : STD<br>=C2=A0 channels=C2=A0=C2=A0=C2=A0=C2=A0 : 4<br>=C2=A0 rate=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 48000<br>=C2=A0 exact ra=
te=C2=A0=C2=A0 : 48000 (48000/1)<br>=C2=A0 msbits=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 : 32<br>=C2=A0 buffer_size=C2=A0 : 16384<br>=C2=A0 period_size=
=C2=A0 : 1024<br>=C2=A0 period_time=C2=A0 : 21333<br>=C2=A0 tstamp_mode=C2=
=A0 : NONE<br>=C2=A0 tstamp_type=C2=A0 : MONOTONIC<br>=C2=A0 period_step=C2=
=A0 : 1<br>=C2=A0 avail_min=C2=A0=C2=A0=C2=A0 : 1024<br>=C2=A0 period_event=
 : 0<br>=C2=A0 start_threshold=C2=A0 : 16384<br>=C2=A0 stop_threshold=C2=A0=
=C2=A0 : 16384<br>=C2=A0 silence_threshold: 0<br>=C2=A0 silence_size : 0<br=
>=C2=A0 boundary=C2=A0=C2=A0=C2=A0=C2=A0 : 4611686018427387904<br>Hardware =
PCM card 0 &#39;Audient iD14&#39; device 0 subdevice 0<br>Its setup is:<br>=
=C2=A0 stream=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : PLAYBACK<br>=C2=A0 acce=
ss=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : MMAP_INTERLEAVED<br>=C2=A0 format=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : S32_LE<br>=C2=A0 subformat=C2=A0=C2=
=A0=C2=A0 : STD<br>=C2=A0 channels=C2=A0=C2=A0=C2=A0=C2=A0 : 4<br>=C2=A0 ra=
te=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 48000<br>=C2=A0 exact =
rate=C2=A0=C2=A0 : 48000 (48000/1)<br>=C2=A0 msbits=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 : 32<br>=C2=A0 buffer_size=C2=A0 : 16384<br>=C2=A0 period_size=
=C2=A0 : 1024<br>=C2=A0 period_time=C2=A0 : 21333<br>=C2=A0 tstamp_mode=C2=
=A0 : ENABLE<br>=C2=A0 tstamp_type=C2=A0 : MONOTONIC<br>=C2=A0 period_step=
=C2=A0 : 1<br>=C2=A0 avail_min=C2=A0=C2=A0=C2=A0 : 1024<br>=C2=A0 period_ev=
ent : 0<br>=C2=A0 start_threshold=C2=A0 : 1<br>=C2=A0 stop_threshold=C2=A0=
=C2=A0 : 4611686018427387904<br>=C2=A0 silence_threshold: 0<br>=C2=A0 silen=
ce_size : 4611686018427387904<br>=C2=A0 boundary=C2=A0=C2=A0=C2=A0=C2=A0 : =
4611686018427387904<br>=C2=A0 appl_ptr=C2=A0=C2=A0=C2=A0=C2=A0 : 0<br>=C2=
=A0 hw_ptr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 0<br><br></span><b>./alsac=
ap</b><span style=3D"font-family:monospace"><br>*** Scanning for playback d=
evices ***<br>Card 0, ID `iD14&#39;, name `Audient iD14&#39;<br>=C2=A0 Devi=
ce 0, ID `USB Audio&#39;, name `USB Audio&#39;, 1 subdevices (1 available)<=
br>=C2=A0=C2=A0=C2=A0 4 channels, sampling rate 44100..96000 Hz<br>=C2=A0=
=C2=A0=C2=A0 Sample formats: S16_LE, S32_LE<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Subdevice 0, name `subdevice #0&#39;</span><br></div><span style=3D"fon=
t-family:monospace"></span></div></div>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Charles M=
ulder<div>Software Engineer/Musician<div><div>mobile: +27 83 653 3698</div>=
<div>phone: +27 27 948 2592</div><div>skype: charliemurder</div></div></div=
></div></div>

--f403045da1762a690f05640d5435--


--===============7226763645558481923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============7226763645558481923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============7226763645558481923==--
