From: Rick Measham <rick@measham.id.au>
Subject: Re: 1.0.16rc1 release -- error: 'system_utsname'
	undeclared
Date: Sat, 26 Jan 2008 00:33:06 +1100
Message-ID: <4799E512.3000801@measham.id.au>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>	<47964342.1060608@measham.id.au>	<s5htzl5t45y.wl%tiwai@suse.de>	<s5hsl0pt2uj.wl%tiwai@suse.de>	<47988136.4030307@measham.id.au>	<s5hd4rr4ar8.wl%tiwai@suse.de>	<4798FF26.40803@measham.id.au>	<s5hd4rqcoxx.wl%tiwai@suse.de>	<4799CC9B.9050809@measham.id.au>
	<s5hodbajebr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2493663887852773387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from promethium.mailguard.com.au (promethium.mailguard.com.au
	[70.86.21.242]) by alsa0.perex.cz (Postfix) with ESMTP id BA852248A3
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 14:33:27 +0100 (CET)
In-Reply-To: <s5hodbajebr.wl%tiwai@suse.de>
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

This is a cryptographically signed message in MIME format.

--===============2493663887852773387==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080900070007030902020305"

This is a cryptographically signed message in MIME format.

--------------ms080900070007030902020305
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
 > That pin config actually looks strange.  It defines 4 "speaker"
 > outputs.  The autocfg routine in hda-intel driver switches these
 > speaker outputs to line-outs (just for compatibility issue).  That's
 > why you don't see any speaker there.
 >
 > The patch below is a quick fix to change the jack types for 3
 > outputs.  Give it a try.

Tried it, speaker-test still gives no sound out the internal speakers

dmesg, however, now shows 1 speaker:
[ 7023.408000] ALSA /usr/src/alsa/alsa-driver/pci/hda/hda_codec.c:2859:
      speaker_outs=1 (0xd/0x0/0x0/0x0/0x0)


 > Now more questions:
 >
 > - Does your machine have 3 output jacks in addition to HP?

There's the HP and Mic on the left-hand-side and then on the back is an 
S/PDIF port that has an adapter with a whole pile of inputs and outputs. 
I don't know what they all do, so maybe if I just take a photo, it will
help: http://rick.measham.id.au/paste/spdif.jpg

 > - What is the content of /proc/asound/card0/codec#* when you load the
 >   driver with model=auto?  After setting it, reboot so that BIOS
 >   resets the configuration.
 >
 > - Show both codec#* files for model=auto and without model option.
They appear to be exactly the same ..

# tail -n1 /etc/modprobe.d/alsa-base
options snd-hda-intel model=auto

# cat /proc/asound/card0/codec#0
Codec: SigmaTel STAC9221 A1
Address: 0
Vendor Id: 0x83847680
Subsystem Id: 0x102801bf
Revision Id: 0x103601
No Modem Function Group found
Default PCM:
      rates [0x7e0]: 44100 48000 88200 96000 176400 192000
      bits [0xe]: 16 20 24
      formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
    Amp-Out caps: N/A
    Amp-Out vals:  [0x7f 0x7f]
    Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
    Amp-Out caps: N/A
    Amp-Out vals:  [0xff 0xff]
    Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
    Amp-Out caps: N/A
    Amp-Out vals:  [0xff 0xff]
    Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
    Amp-Out caps: N/A
    Amp-Out vals:  [0x7f 0x7f]
    Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
    Power: 0x0
    Connection: 1
       0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
    Power: 0x0
    Connection: 1
       0x18
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
    PCM:
      rates [0x7e0]: 44100 48000 88200 96000 176400 192000
      bits [0xe]: 16 20 24
      formats [0x5]: PCM AC3
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
    PCM:
      rates [0x160]: 44100 48000 96000
      bits [0xe]: 16 20 24
      formats [0x5]: PCM AC3
    Connection: 1
       0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
    Pincap 0x08173f: IN OUT HP Detect
    Pin Default 0x0321101f: [Jack] HP Out at Ext Left
      Conn = 1/8, Color = Black
    EAPD: 0x0
    Pin-ctls: 0xc0: OUT HP
    Connection: 1
       0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
    Pincap 0x081737: IN OUT Detect
    Pin Default 0x01012024: [Jack] Line Out at Ext Rear
      Conn = 1/8, Color = Grey
    EAPD: 0x0
    Pin-ctls: 0x40: OUT
    Connection: 1
       0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
    Pincap 0x081737: IN OUT Detect
    Pin Default 0x01011222: [Jack] Line Out at Ext Rear
      Conn = 1/8, Color = Black
    EAPD: 0x0
    Pin-ctls: 0x40: OUT
    Connection: 1
       0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
    Pincap 0x08173f: IN OUT HP Detect
    Pin Default 0x91174220: [Fixed] Speaker at Int Rear
      Conn = Analog, Color = Green
    EAPD: 0x0
    Pin-ctls: 0x40: OUT
    Connection: 1
       0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
    Pincap 0x0824: IN Detect
    Pin Default 0x03a11050: [Jack] Mic at Ext Left
      Conn = 1/8, Color = Black
    EAPD: 0x0
    Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
    Pincap 0x0837: IN OUT Detect
    Pin Default 0x01016221: [Jack] Line Out at Ext Rear
      Conn = 1/8, Color = Orange
    EAPD: 0x0
    Pin-ctls: 0x40: OUT
    Connection: 1
       0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
    Pincap 0x0810: OUT
    Pin Default 0x90a70330: [Fixed] Mic at Int N/A
      Conn = Analog, Color = Unknown
    EAPD: 0x0
    Pin-ctls: 0x00:
    Connection: 3
       0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
    Pincap 0x0810024: IN EAPD Detect
    Pin Default 0x01452340: [Jack] SPDIF Out at Ext Rear
      Conn = Optical, Color = Grey
    EAPD: 0x0
    Pin-ctls: 0x00:
    Power: 0x0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
    Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
    Amp-Out vals:  [0x00 0x00]
    Connection: 7
       0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
    Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
    Amp-Out vals:  [0x00 0x00]
    Connection: 7
       0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
    Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
    Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
    Pincap 0x0820: IN
    Pin Default 0x40c003f1: [N/A] SPDIF In at Ext N/A
      Conn = Unknown, Color = Unknown
    Pin-ctls: 0x00:
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
    Volume-Knob: delta=1, steps=127, direct=1, val=127
    Connection: 4
       0x02* 0x03 0x04 0x05
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
    Amp-In caps: N/A
    Amp-In vals:  [0x80 0x80]
    Connection: 1
       0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
    Amp-In caps: N/A
    Amp-In vals:  [0x00 0x00]
    Connection: 1
       0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
    Pincap 0x0810: OUT
    Pin Default 0x405003f0: [N/A] Digital Out at Ext N/A
      Conn = Unknown, Color = Unknown
    Pin-ctls: 0x00:
    Connection: 1
       0x1a


# cat /proc/asound/card0/codec#1
Codec: Conexant ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x14f100c3
Revision Id: 0x90000
Modem Function Group: 0x2


++ REMOVED the options line and restarted

# tail -n1 /etc/modprobe.d/alsa-base
#options snd-hda-intel model=auto

# cat /proc/asound/card0/codec#0
Codec: SigmaTel STAC9221 A1
Address: 0
Vendor Id: 0x83847680
Subsystem Id: 0x102801bf
Revision Id: 0x103601
No Modem Function Group found
Default PCM:
     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
   Amp-Out vals:  [0x7f 0x7f]
   Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
   Amp-Out vals:  [0xff 0xff]
   Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
   Amp-Out vals:  [0xff 0xff]
   Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
   Amp-Out caps: N/A
   Amp-Out vals:  [0x7f 0x7f]
   Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
   Power: 0x0
   Connection: 1
      0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
   Power: 0x0
   Connection: 1
      0x18
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
   PCM:
     rates [0x7e0]: 44100 48000 88200 96000 176400 192000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Connection: 1
      0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
   Pincap 0x08173f: IN OUT HP Detect
   Pin Default 0x0321101f: [Jack] HP Out at Ext Left
     Conn = 1/8, Color = Black
   EAPD: 0x0
   Pin-ctls: 0xc0: OUT HP
   Connection: 1
      0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
   Pincap 0x081737: IN OUT Detect
   Pin Default 0x01012024: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Grey
   EAPD: 0x0
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
   Pincap 0x081737: IN OUT Detect
   Pin Default 0x01011222: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Black
   EAPD: 0x0
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
   Pincap 0x08173f: IN OUT HP Detect
   Pin Default 0x91174220: [Fixed] Speaker at Int Rear
     Conn = Analog, Color = Green
   EAPD: 0x0
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
   Pincap 0x0824: IN Detect
   Pin Default 0x03a11050: [Jack] Mic at Ext Left
     Conn = 1/8, Color = Black
   EAPD: 0x0
   Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
   Pincap 0x0837: IN OUT Detect
   Pin Default 0x01016221: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Orange
   EAPD: 0x0
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
   Pincap 0x0810: OUT
   Pin Default 0x90a70330: [Fixed] Mic at Int N/A
     Conn = Analog, Color = Unknown
   EAPD: 0x0
   Pin-ctls: 0x00:
   Connection: 3
      0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
   Pincap 0x0810024: IN EAPD Detect
   Pin Default 0x01452340: [Jack] SPDIF Out at Ext Rear
     Conn = Optical, Color = Grey
   EAPD: 0x0
   Pin-ctls: 0x00:
   Power: 0x0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 7
      0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
   Amp-Out vals:  [0x00 0x00]
   Connection: 7
      0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
   Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
   Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x0820: IN
   Pin Default 0x40c003f1: [N/A] SPDIF In at Ext N/A
     Conn = Unknown, Color = Unknown
   Pin-ctls: 0x00:
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
   Volume-Knob: delta=1, steps=127, direct=1, val=127
   Connection: 4
      0x02* 0x03 0x04 0x05
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
   Amp-In caps: N/A
   Amp-In vals:  [0x80 0x80]
   Connection: 1
      0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
   Amp-In caps: N/A
   Amp-In vals:  [0x00 0x00]
   Connection: 1
      0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
   Pincap 0x0810: OUT
   Pin Default 0x405003f0: [N/A] Digital Out at Ext N/A
     Conn = Unknown, Color = Unknown
   Pin-ctls: 0x00:
   Connection: 1
      0x1a


# cat /proc/asound/card0/codec#1
Codec: Conexant ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x14f100c3
Revision Id: 0x90000
Modem Function Group: 0x2

--------------ms080900070007030902020305
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJBzCC
At4wggJHoAMCAQICEHahvhsVL0qy1CdO97KnttwwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDYyODA2NTAwMloX
DTA4MDYyNzA2NTAwMlowRDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8G
CSqGSIb3DQEJARYScmlja0BtZWFzaGFtLmlkLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAwOurNHlazx8aZRpMSGQuUrzu2po3XFqj66HXP8etW37JWRM2lCn750qtJgi7
P4KZAc9Rsfqg+E4hqPVaO7P6gxCAO8Hx5PpTBVj/1ggSRZHpqG1Yf1wpiCktk3Ixk2iQC5DO
oTJqhJwiv2AVzE2tV+71ikGB0fFljlSIjD0Y1m/lMLoUwazamlnyTFIbXNiKLIIE5OGgO2Pi
d+idUA4oHN0IdS6j2h9R3tzH8mKC/ZRdftQ5uHSmGlQDeuP3nrqbKe7iynnptpOn9jsMUYh+
PtYRXeVZpontx/21IRpP7NQ0taSbdXX83FJ7ExAe6/hBiNcd9mLpGq3vs66CpngTqwIDAQAB
oy8wLTAdBgNVHREEFjAUgRJyaWNrQG1lYXNoYW0uaWQuYXUwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQUFAAOBgQABki3vumGUdihXJrv6N5tGVUiMNp2s8nCSCvI21pYo/nN+UY6Vp8Va
PEI9lRnfry/L8muvvnf6k5pk5izxBrICa234iMDV4nJsfMcKfeFMOaoxTuwKSyb0h/wUJYUo
I9rdUo6gAHiLqjx3mqZq3nrk9xC8s3PYMnmkUgxzuK1dcjCCAt4wggJHoAMCAQICEHahvhsV
L0qy1CdO97KnttwwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDYyODA2NTAwMloXDTA4MDYyNzA2NTAwMlowRDEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEhMB8GCSqGSIb3DQEJARYScmlja0Bt
ZWFzaGFtLmlkLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwOurNHlazx8a
ZRpMSGQuUrzu2po3XFqj66HXP8etW37JWRM2lCn750qtJgi7P4KZAc9Rsfqg+E4hqPVaO7P6
gxCAO8Hx5PpTBVj/1ggSRZHpqG1Yf1wpiCktk3Ixk2iQC5DOoTJqhJwiv2AVzE2tV+71ikGB
0fFljlSIjD0Y1m/lMLoUwazamlnyTFIbXNiKLIIE5OGgO2Pid+idUA4oHN0IdS6j2h9R3tzH
8mKC/ZRdftQ5uHSmGlQDeuP3nrqbKe7iynnptpOn9jsMUYh+PtYRXeVZpontx/21IRpP7NQ0
taSbdXX83FJ7ExAe6/hBiNcd9mLpGq3vs66CpngTqwIDAQABoy8wLTAdBgNVHREEFjAUgRJy
aWNrQG1lYXNoYW0uaWQuYXUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQABki3v
umGUdihXJrv6N5tGVUiMNp2s8nCSCvI21pYo/nN+UY6Vp8VaPEI9lRnfry/L8muvvnf6k5pk
5izxBrICa234iMDV4nJsfMcKfeFMOaoxTuwKSyb0h/wUJYUoI9rdUo6gAHiLqjx3mqZq3nrk
9xC8s3PYMnmkUgxzuK1dcjCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJ
BgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEa
MBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2Vy
dmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcw
MDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUg
Q29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1h
aWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065ypla
HmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FW
y688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEE
QB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2
oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3Js
MAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0x
MzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYf
qi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9l
X5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggNkMIIDYAIBATB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQdqG+GxUv
SrLUJ073sqe23DAJBgUrDgMCGgUAoIIBwzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0wODAxMjUxMzMzMDZaMCMGCSqGSIb3DQEJBDEWBBSmcqOiV8+YShaU
ew0un3qUXXmrZzBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAE
MXgwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHah
vhsVL0qy1CdO97KnttwwgYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHahvhsVL0qy1CdO97KnttwwDQYJKoZIhvcN
AQEBBQAEggEAEWYUi0FY97fLoCabYV3By7gKuxg1wH5exGPbj58aAEyRO17yW419PQwy1Er1
iiEzB+TzigDl19QaZVJlE4RnrudE12sQKoNBXm6AJ4j8ryeAcOjkWZNVWZPHPZYYrIba2HIF
Za3tTWA6vzpLTfU/tOqBXR3H4+Cy5Jhed7UfJPPFrXFwnTTSJGXGddQeV4v+L9wNndPQScfi
Ri/dgIHlyFTInmNCUu24KNpBLisAd9nWYY3qHoV47X72Y3XKvecW7DG28UKAPiagbzGRggB1
kXsVvLXU8jrqpXJSKbi3CEtqfLFLSi4O16Zxwx4D8E70qOAiw9JC0/vpmxKflITfgAAAAAAA
AA==
--------------ms080900070007030902020305--

--===============2493663887852773387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2493663887852773387==--
