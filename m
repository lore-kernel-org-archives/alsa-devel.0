From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Tue, 29 Jan 2013 01:32:15 +0100
Message-ID: <5107188F.3060001@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040309020906000209070203"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1110D26036E
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 01:32:18 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id q16so1584600bkw.0
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 16:32:17 -0800 (PST)
In-Reply-To: <510670CC.2090904@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040309020906000209070203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Am 28.01.2013 13:36, schrieb Pavel Hofman:
> Right, looks like a bug in snd_ak4114_create. Nevertheless the 7th reg
> RCS0 is read-only, writing anything bogus should not affect the operation.
Ok. I once filled it with a zero with no effect.

> What does the ak4114 regs dump in /proc/asound... dir of your
> audiophile192 look like? The snd_ak4114_proc_regs_read method reads real
> values from the regs.
You know what, there ist no ak4114... See the attached 
Audiophile192-proc.txt. That's everything in proc.
Before I was doing some printk's in snd_ak4114_create() and 
snd_ak4114_reg_write() and other places. They ended up in kern.log.
Then was also fiddling around with the configuration (ak4114_init_vals) 
which didn't change anything in the capture behaviour. I even entirely 
removed the snd_ak4114_create() call. It was still just capturing spdif 
6 dB to loud with the shifted signals as described before.
So the ak4114 code is not in operation at all?


>> @Pavel, btw. I also have an ESI Juli@. Spdif capture with this one does not
>> work at all (as compared to "kind of working" with the Audiophile 192).
> Interesting. I am pretty sure I tested the SPDIF input of Juli quite
> extensively. It even reported the incoming samplerate correctly. How did
> you test it? Please list amixer contents and ak4114 regs here. Thanks.

I just tried again. The Juli just seem to freeze the whole alsa when I 
try to access the spdif input.

See attached Juli files. There _is_ an ak4114 file.

- Jonas



--------------040309020906000209070203
Content-Type: text/plain; charset=UTF-8;
 name="Audiophile192-amixer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Audiophile192-amixer.txt"

Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 79 [62%] [-24.00dB]
  Front Right: Playback 79 [62%] [-24.00dB]
Simple mixer control 'IEC958',0
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'Deemphasis',0
  Capabilities: enum
  Items: '44.1kHz' 'Off' '48kHz' '32kHz'
  Item0: 'Off'
Simple mixer control 'H/W',0
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',1
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'Multi Track Internal Clock',0
  Capabilities: enum
  Items: '8000' '9600' '11025' '12000' '16000' '22050' '24000' '32000' '44100' '48000' '64000' '88200' '96000' '176400' '192000' 'IEC958 In'
  Item0: 'IEC958 In'
Simple mixer control 'Multi Track Rate Locking',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Multi Track Rate Reset',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]

--------------040309020906000209070203
Content-Type: text/plain; charset=UTF-8;
 name="Audiophile192-proc.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Audiophile192-proc.txt"


/proc/asound/Audiophile192/oss_mixer

VOLUME "" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "" 0
LINE "" 0
MIC "" 0
CD "" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "" 0
OGAIN "" 0
LINE1 "" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "" 0
PHONEOUT "" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0

/proc/asound/Audiophile192/id

Audiophile192

/proc/asound/Audiophile192/ice1724

M Audio Audiophile192 at 0xd080, irq 20

EEPROM:
  Subvendor        : 0x12143236
  Size             : 19 bytes
  Version          : 2
  System Config    : 0x68
  ACLink           : 0x80
  I2S              : 0xf8
  S/PDIF           : 0xc3
  GPIO direction   : 0x7fffba
  GPIO mask        : 0x45
  GPIO state       : 0x4000b5
  Extra #18        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x20
  CCS03    : 0x00
  CCS04    : 0x68
  CCS05    : 0x80
  CCS06    : 0xf8
  CCS07    : 0xc3
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0b
  CCS0e    : 0x01
  CCS0f    : 0x00
  CCS10    : 0xa0
  CCS11    : 0x12
  CCS12    : 0x40
  CCS13    : 0x80
  CCS14    : 0xfa
  CCS15    : 0x08
  CCS16    : 0x45
  CCS17    : 0x00
  CCS18    : 0xba
  CCS19    : 0xff
  CCS1a    : 0x7f
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x40
  CCS1f    : 0x00
  MT00     : 0x00
  MT01     : 0x10
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x00
  MT05     : 0x00
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x00
  MT11     : 0x00
  MT12     : 0x00
  MT13     : 0x00
  MT14     : 0x00
  MT15     : 0x00
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x00
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0x00
  MT1d     : 0x00
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0x00
  MT27     : 0x00
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x00
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00

/proc/asound/Audiophile192/ak4358

chip 0: 0x00 = 0x06
chip 0: 0x01 = 0x01
chip 0: 0x02 = 0x4e
chip 0: 0x03 = 0x01
chip 0: 0x04 = 0xcf
chip 0: 0x05 = 0xcf
chip 0: 0x06 = 0x00
chip 0: 0x07 = 0x00
chip 0: 0x08 = 0x00
chip 0: 0x09 = 0x00
chip 0: 0x0a = 0x00
chip 0: 0x0b = 0x00
chip 0: 0x0c = 0x00
chip 0: 0x0d = 0x00
chip 0: 0x0e = 0x00
chip 0: 0x0f = 0x00

/proc/asound/Audiophile192/midi0

ICE1724 MIDI

Output 0
  Tx bytes     : 0
Input 0
  Rx bytes     : 0

/proc/asound/Audiophile192/pcm1c/oss


/proc/asound/Audiophile192/pcm1c/sub0/prealloc_max

256

/proc/asound/Audiophile192/pcm1c/sub0/prealloc

256

/proc/asound/Audiophile192/pcm1c/sub0/status

closed

/proc/asound/Audiophile192/pcm1c/sub0/sw_params

closed

/proc/asound/Audiophile192/pcm1c/sub0/hw_params

closed

/proc/asound/Audiophile192/pcm1c/sub0/info

card: 0
device: 1
subdevice: 0
stream: CAPTURE
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Audiophile192/pcm1c/info

card: 0
device: 1
subdevice: 0
stream: CAPTURE
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Audiophile192/pcm1p/oss


/proc/asound/Audiophile192/pcm1p/sub0/prealloc_max

256

/proc/asound/Audiophile192/pcm1p/sub0/prealloc

256

/proc/asound/Audiophile192/pcm1p/sub0/status

closed

/proc/asound/Audiophile192/pcm1p/sub0/sw_params

closed

/proc/asound/Audiophile192/pcm1p/sub0/hw_params

closed

/proc/asound/Audiophile192/pcm1p/sub0/info

card: 0
device: 1
subdevice: 0
stream: PLAYBACK
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Audiophile192/pcm1p/info

card: 0
device: 1
subdevice: 0
stream: PLAYBACK
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Audiophile192/pcm0c/oss


/proc/asound/Audiophile192/pcm0c/sub0/prealloc_max

256

/proc/asound/Audiophile192/pcm0c/sub0/prealloc

256

/proc/asound/Audiophile192/pcm0c/sub0/status

closed

/proc/asound/Audiophile192/pcm0c/sub0/sw_params

closed

/proc/asound/Audiophile192/pcm0c/sub0/hw_params

closed

/proc/asound/Audiophile192/pcm0c/sub0/info

card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Audiophile192/pcm0c/info

card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Audiophile192/pcm0p/oss


/proc/asound/Audiophile192/pcm0p/sub0/prealloc_max

256

/proc/asound/Audiophile192/pcm0p/sub0/prealloc

256

/proc/asound/Audiophile192/pcm0p/sub0/status

closed

/proc/asound/Audiophile192/pcm0p/sub0/sw_params

closed

/proc/asound/Audiophile192/pcm0p/sub0/hw_params

closed

/proc/asound/Audiophile192/pcm0p/sub0/info

card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Audiophile192/pcm0p/info

card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

--------------040309020906000209070203
Content-Type: text/plain; charset=UTF-8;
 name="Juli-amixer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Juli-amixer.txt"

Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 87 [69%] [-20.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [0.00dB]
  Front Right: Playback 127 [100%] [0.00dB]
Simple mixer control 'IEC958',0
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'Deemphasis',0
  Capabilities: enum
  Items: '44.1kHz' 'Off' '48kHz' '32kHz'
  Item0: 'Off'
Simple mixer control 'H/W',0
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',1
  Capabilities: penum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'Monitor Analog In',0
  Capabilities: volume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 127
  Front Left: 0 [0%] [-99999.99dB] Playback [off]
  Front Right: 0 [0%] [-99999.99dB] Playback [off]
Simple mixer control 'Monitor Digital In',0
  Capabilities: volume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 127
  Front Left: 0 [0%] [-99999.99dB] Playback [off]
  Front Right: 0 [0%] [-99999.99dB] Playback [off]
Simple mixer control 'Monitor Digital Out',0
  Capabilities: volume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 127
  Front Left: 0 [0%] [-99999.99dB] Playback [off]
  Front Right: 0 [0%] [-99999.99dB] Playback [off]
Simple mixer control 'Multi Track Internal Clock',0
  Capabilities: enum
  Items: '16000' '22050' '24000' '32000' '44100' '48000' '64000' '88200' '96000' '176400' '192000' 'IEC958 In'
  Item0: 'IEC958 In'
Simple mixer control 'Multi Track Rate Locking',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Multi Track Rate Reset',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]

--------------040309020906000209070203
Content-Type: text/plain; charset=UTF-8;
 name="Juli-proc.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Juli-proc.txt"


/proc/asound/Juli/oss_mixer

VOLUME "Master" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "PCM" 0
SPEAKER "" 0
LINE "" 0
MIC "" 0
CD "" 0
IMIX "" 0
ALTPCM "" 0
RECLEV "" 0
IGAIN "" 0
OGAIN "" 0
LINE1 "" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "" 0
PHONEOUT "" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0

/proc/asound/Juli/id

Juli

/proc/asound/Juli/ice1724

ESI Juli@ at 0xd080, irq 20

EEPROM:
  Subvendor        : 0x31305345
  Size             : 19 bytes
  Version          : 2
  System Config    : 0x2b
  ACLink           : 0x80
  I2S              : 0xf8
  S/PDIF           : 0xc3
  GPIO direction   : 0x7fff9f
  GPIO mask        : 0x7f0060
  GPIO state       : 0x1a
  Extra #18        : 0x0

Registers:
  PSDOUT03 : 0x00000000
  CCS00    : 0x00
  CCS01    : 0xa0
  CCS02    : 0x20
  CCS03    : 0x00
  CCS04    : 0x2b
  CCS05    : 0x80
  CCS06    : 0xf8
  CCS07    : 0xc3
  CCS08    : 0x00
  CCS09    : 0x00
  CCS0a    : 0x00
  CCS0b    : 0x00
  CCS0c    : 0x00
  CCS0d    : 0x0b
  CCS0e    : 0x01
  CCS0f    : 0x00
  CCS10    : 0x20
  CCS11    : 0x06
  CCS12    : 0x10
  CCS13    : 0x80
  CCS14    : 0x79
  CCS15    : 0x00
  CCS16    : 0x60
  CCS17    : 0x00
  CCS18    : 0x9f
  CCS19    : 0xff
  CCS1a    : 0x7f
  CCS1b    : 0x00
  CCS1c    : 0x00
  CCS1d    : 0x00
  CCS1e    : 0x00
  CCS1f    : 0x7f
  MT00     : 0x00
  MT01     : 0x10
  MT02     : 0x00
  MT03     : 0x08
  MT04     : 0x00
  MT05     : 0x00
  MT06     : 0x00
  MT07     : 0x00
  MT08     : 0x00
  MT09     : 0x00
  MT0a     : 0x00
  MT0b     : 0x00
  MT0c     : 0x00
  MT0d     : 0x00
  MT0e     : 0x00
  MT0f     : 0x00
  MT10     : 0x00
  MT11     : 0x00
  MT12     : 0x00
  MT13     : 0x00
  MT14     : 0x00
  MT15     : 0x00
  MT16     : 0x00
  MT17     : 0x00
  MT18     : 0x00
  MT19     : 0x00
  MT1a     : 0x00
  MT1b     : 0x00
  MT1c     : 0x00
  MT1d     : 0x00
  MT1e     : 0x00
  MT1f     : 0x00
  MT20     : 0x00
  MT21     : 0x00
  MT22     : 0x00
  MT23     : 0x00
  MT24     : 0x00
  MT25     : 0x00
  MT26     : 0x00
  MT27     : 0x00
  MT28     : 0x00
  MT29     : 0x00
  MT2a     : 0x00
  MT2b     : 0x00
  MT2c     : 0x00
  MT2d     : 0x00
  MT2e     : 0x00
  MT2f     : 0x00

/proc/asound/Juli/ak4358

chip 0: 0x00 = 0x06
chip 0: 0x01 = 0x01
chip 0: 0x02 = 0x4e
chip 0: 0x03 = 0x01
chip 0: 0x04 = 0xd7
chip 0: 0x05 = 0xd7
chip 0: 0x06 = 0x00
chip 0: 0x07 = 0x00
chip 0: 0x08 = 0x00
chip 0: 0x09 = 0x00
chip 0: 0x0a = 0x00
chip 0: 0x0b = 0x00
chip 0: 0x0c = 0x00
chip 0: 0x0d = 0x00
chip 0: 0x0e = 0x00
chip 0: 0x0f = 0x00

/proc/asound/Juli/ak4114

0x00 = 0x0f
0x01 = 0x70
0x02 = 0x80
0x03 = 0x49
0x04 = 0x00
0x05 = 0x00
0x06 = 0x10
0x07 = 0x10
0x08 = 0x00
0x09 = 0x00
0x0a = 0x00
0x0b = 0x00
0x0c = 0x00
0x0d = 0x41
0x0e = 0x02
0x0f = 0x2c
0x10 = 0x00
0x11 = 0x00
0x12 = 0x00
0x13 = 0x00
0x14 = 0x00
0x15 = 0x00
0x16 = 0x00
0x17 = 0x00
0x18 = 0x00
0x19 = 0x00
0x1a = 0x00
0x1b = 0x00
0x1c = 0x00
0x1d = 0x00
0x1e = 0x00
0x1f = 0x00

/proc/asound/Juli/midi0

ICE1724 MIDI

Output 0
  Tx bytes     : 0
Input 0
  Rx bytes     : 0

/proc/asound/Juli/pcm1c/oss


/proc/asound/Juli/pcm1c/sub0/prealloc_max

256

/proc/asound/Juli/pcm1c/sub0/prealloc

256

/proc/asound/Juli/pcm1c/sub0/status

closed

/proc/asound/Juli/pcm1c/sub0/sw_params

closed

/proc/asound/Juli/pcm1c/sub0/hw_params

closed

/proc/asound/Juli/pcm1c/sub0/info

card: 0
device: 1
subdevice: 0
stream: CAPTURE
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Juli/pcm1c/info

card: 0
device: 1
subdevice: 0
stream: CAPTURE
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Juli/pcm1p/oss


/proc/asound/Juli/pcm1p/sub0/prealloc_max

256

/proc/asound/Juli/pcm1p/sub0/prealloc

256

/proc/asound/Juli/pcm1p/sub0/status

closed

/proc/asound/Juli/pcm1p/sub0/sw_params

closed

/proc/asound/Juli/pcm1p/sub0/hw_params

closed

/proc/asound/Juli/pcm1p/sub0/info

card: 0
device: 1
subdevice: 0
stream: PLAYBACK
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Juli/pcm1p/info

card: 0
device: 1
subdevice: 0
stream: PLAYBACK
id: ICE1724 IEC958
name: ICE1724 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Juli/pcm0c/oss


/proc/asound/Juli/pcm0c/sub0/prealloc_max

256

/proc/asound/Juli/pcm0c/sub0/prealloc

256

/proc/asound/Juli/pcm0c/sub0/status

closed

/proc/asound/Juli/pcm0c/sub0/sw_params

closed

/proc/asound/Juli/pcm0c/sub0/hw_params

closed

/proc/asound/Juli/pcm0c/sub0/info

card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Juli/pcm0c/info

card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Juli/pcm0p/oss


/proc/asound/Juli/pcm0p/sub0/prealloc_max

256

/proc/asound/Juli/pcm0p/sub0/prealloc

256

/proc/asound/Juli/pcm0p/sub0/status

closed

/proc/asound/Juli/pcm0p/sub0/sw_params

closed

/proc/asound/Juli/pcm0p/sub0/hw_params

closed

/proc/asound/Juli/pcm0p/sub0/info

card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

/proc/asound/Juli/pcm0p/info

card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ICE1724
name: ICE1724
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

--------------040309020906000209070203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040309020906000209070203--
