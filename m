From: Die Mumie <mumie_die@yahoo.de>
Subject: Re: New Realtec ALC833 Codec in Fujitsu Siemens Xi2428
Date: Wed, 5 Dec 2007 19:05:36 +0100 (CET)
Message-ID: <271407.48342.qm@web26713.mail.ukl.yahoo.com>
References: <1196875384.10030.131.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1254038444-1196877936=:48342"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web26713.mail.ukl.yahoo.com (web26713.mail.ukl.yahoo.com
	[217.146.177.70])
	by alsa0.perex.cz (Postfix) with SMTP id 184581037EE
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 19:05:42 +0100 (CET)
In-Reply-To: <1196875384.10030.131.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: ALSA Developers List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0-1254038444-1196877936=:48342
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Ok, doing as you wish. There is no useable Documentation for this Noteboo=
k, because ist seems to work with "great Vista", all I could find is a Gu=
ide for installing the internal Microphone under Vista.
I'll attach 3 files,
-The Vista guide
-The Alsa-Info output
-The dmesg output



Tobin Davis <tdavis@dsl-only.net> schrieb:           The helps immensely,=
 thanks.  For some reason, pastebin seems to be having issues.  Could you=
 email me directly the alsa-info.txt file that the alsa-info.sh script ge=
nerated?  It should be in your /tmp directory.  Also, if you have a user'=
s manual in pdf form for your system, please attach it as well (english v=
ersion).  This may gleen some info about the specs of your system that ma=
y have been overlooked, especially the mic.=20
=20
 The last bit I'd like you to do, if you are up for it, is to rebuild the=
 drivers with debugging turned on.  To do this, download alsa-driver-1.0.=
15.tar.bz2 and extract it.  Then, in the directory it extracted to, type =
"./configure --with-debug=3Ddetect --with-cards=3Dhda-intel && make && ma=
ke install".  When you load this driver, set model=3Dauto.  This will dum=
p the bios configuration for the card (if any) into dmesg.  I need that o=
utput as well.
=20
 I'll try to work on this this week, but no guarantees.  We had some seri=
ous flooding this last weekend, and I'm busy fixing my house. =20
=20
 Based on the info below, I'll need to create a separate model for your s=
ystem.  It may take a few patches, but it will happen.
=20
 Tobin
=20
 On Wed, 2007-12-05 at 12:26 +0100, Die Mumie wrote: =20
So, first: I have a  -HDMI Connector -Jack for Headphones (HP) and SPDIF =
-Jack for Mic or Line -Two built in Mics * -Built in Speakers (I Guess th=
at they are Stereo, but I'm not sure) *  What I can test is:     Headphon=
es     Internel Speakers     Internal Microphone  so I'm going trough the=
 model list.  3stack-dig - Sound at HP, no IS, no Mic 6stack-dig - Front =
gives Sound at HP, Surround at IS, no Mic 3stack-6ch - Front gives Sound =
at HP, Surround at IS, no Mic 3stack-6ch-dig - Front gives Sound at HP, n=
o IS, no Mic 6stack-dig-demo - Front gives sound at HP and IS at the same=
 time, no switching by Jack, no Mic acer - Front gives Sound at HP, Surro=
und at IS, no Mic acer-aspire - Switchs between HP and IS by plugging the=
 HP, Headphones switch Enables/Disables sound on HP, no Mic medion - no S=
ound medion-md2 - sound on HP when HP switch is enabled, no mic targa-dig=
 - sound on HP when HP switch is enabled, Surround gives on IS, no Mic ta=
rga-2ch-dig - sound on HP when HP
 switch is enabled, no mic laptop-eapd - Front on HP, Surround on IS, no =
mic lenovo-101e -  Sound on Front Jack switching, no Mic lenovo-nb0763 - =
Sound on Speaker Jack switching, no Mic lenovo-ms7195-dig - Sound on Fron=
t same time at IS and HP, no Mic haier-w66 - Front on HP, no Mic 6stack-h=
p - Nothing 3stack-hp - Front on HP, Center on IS, no Mic  I hope this he=
lps  Andy Shevchenko <andy@smile.org.ua> schrieb: Hi Die Mumie!   On Wed,=
 Dec 05, 2007 at 01:47:07AM +0100, Die Mumie wrote next:  >  Also, try on=
e of the supported models for the ALC883: >                 3stack-dig   =
 3-jack with SPDIF I/O >                6stack-dig    6-jack digital with=
 SPDIF I/O >                3stack-6ch    3-jack 6-channel >             =
   3stack-6ch-dig 3-jack 6-channel with SPDIF I/O >                6stack=
-dig-demo  6-jack digital for Intel demo board >                acer     =
     Acer laptops (Travelmate 3012WTMi, Aspire 5600, etc) >              =
  acer-aspire   Acer Aspire 9810 >    =20
           medion        Medion Laptops >                medion-md2    Me=
dion MD2 >                targa-dig     Targa/MSI >                targa-=
2ch-dig Targs/MSI with 2-channel >                laptop-eapd   3-jack wi=
th SPDIF I/O and EAPD (Clevo M540JE, M550JE) >                lenovo-101e=
   Lenovo 101E >                lenovo-nb0763 Lenovo NB0763 >            =
    lenovo-ms7195-dig Lenovo MS7195 >                haier-w66     Haier =
W66 >                6stack-hp     HP machines with 6stack (Nettle boards=
) >                3stack-hp     HP machines with 3stack (Lucknow, Samba =
boards) >                auto          auto-config reading BIOS (default)=
 Did you hear some sound in the HP or internel speakers with someone of t=
hese models? If yes, please, say what is wrong with that sound. =20
     --  Tobin Davis =20
=20
=20
There are two types of people in this world, good and bad.  The good
sleep better, but the bad seem to enjoy the waking hours much more.
  -- Woody Allen

   =20

      =20
---------------------------------
Jetzt Mails schnell in einem Vorschaufenster =FCberfliegen. Dies und viel=
 mehr bietet das  neue Yahoo! Mail.=20
--0-1254038444-1196877936=:48342
Content-Type: text/plain; name="alsa-info.txt"
Content-Description: 2895476006-alsa-info.txt
Content-Disposition: inline; filename="alsa-info.txt"

name=root&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.34
!!################################

!!Script ran on: Wed Dec  5 01:29:45 CET 2007


!!Linux Distribution
!!------------------

Gentoo Base System release 1.12.9


!!Kernel Information
!!------------------

Kernel release:    2.6.22-gentoo-r9
Operating System:  GNU/Linux
Architecture:      i686
Processor:         Intel(R) Core(TM)2 Duo CPU T7250 @ 2.00GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.15
Library version:    1.0.14a
Utilities version:  1.0.14


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf0600000 irq 23


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 03)
	Subsystem: 1734:1107
--
	Region 0: Memory at f0402000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at f0400000 (64-bit, non-prefetchable) [size=8K]


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
enable : N
id : <NULL>
index : -1
model : <NULL>
position_fix : 0
power_save : 0
power_save_controller : Y
probe_mask : -1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------

Codec: Motorola Si3054
Address: 0
Vendor Id: 0x10573055
Subsystem Id: 0x10573055
Revision Id: 0x100700
Modem Function Group: 0x1
Codec: Realtek ALC883
Address: 1
Vendor Id: 0x10ec0883
Subsystem Id: 0x17341236
Revision Id: 0x100002
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x12 0x12]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x0121441f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
  EAPD: 0x0
  Pin-ctls: 0xc0: OUT HP
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
  EAPD: 0x0
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  EAPD: 0x0
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  EAPD: 0x0
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x01a19830: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  EAPD: 0x0
  Pin-ctls: 0x24: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x99a3093f: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
  EAPD: 0x0
  Pin-ctls: 0x24: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  EAPD: 0x0
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  EAPD: 0x0
  Pin-ctls: 0x20: IN
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  EAPD: 0x0
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x598301f0: [N/A] Line In at Int ATAPI
    Conn = ATAPI, Color = Unknown
  EAPD: 0x0
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x99430120: [Fixed] SPDIF Out at Int ATAPI
    Conn = ATAPI, Color = Unknown
  EAPD: 0x0
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  EAPD: 0x0
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Dec  4 21:29 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Dec  4 21:29 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116,  5 Dec  4 21:29 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116, 24 Dec  4 21:29 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Dec  4 21:29 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 17 Dec  4 21:29 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 26 Dec  4 21:29 /dev/snd/pcmC0D2c
crw-rw---- 1 root audio 116, 30 Dec  4 21:29 /dev/snd/pcmC0D6c
crw-rw---- 1 root audio 116, 22 Dec  4 21:29 /dev/snd/pcmC0D6p
crw-rw---- 1 root audio 116,  1 Dec  4 20:29 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Dec  4 21:29 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC883 Analog [ALC883 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC883 Digital [ALC883 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC883 Analog [ALC883 Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 0: Intel [HDA Intel], device 2: ALC883 Analog [ALC883 Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 18 [58%] [-19.50dB] [on]
  Front Right: Playback 18 [58%] [-19.50dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [on]
  Front Right: Playback 0 [0%] [-34.50dB] [on]
Simple mixer control 'Front Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [on]
  Front Right: Playback 0 [0%] [-34.50dB] [on]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 0 [0%] [-12.00dB] [on]
  Front Right: Capture 0 [0%] [-12.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 0 [0%] [-12.00dB] [on]
  Front Right: Capture 0 [0%] [-12.00dB] [on]
Simple mixer control 'Caller ID',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'Front Mic'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: enum
  Items: 'Mic' 'Front Mic'
  Item0: 'Mic'
Simple mixer control 'Off-hook',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!All Loaded Modules
!!------------------

Module
ipv6
bridge
llc
snd_pcm_oss
snd_mixer_oss
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
iwl4965
snd_hda_intel
snd_pcm
snd_timer
snd_page_alloc
snd_hwdep
snd
nvidia



--0-1254038444-1196877936=:48342
Content-Type: application/pdf; name="Microphone_Config_Vista_en.pdf"
Content-Transfer-Encoding: base64
Content-Description: 3897849076-Microphone_Config_Vista_en.pdf
Content-Disposition: attachment; filename="Microphone_Config_Vista_en.pdf"

JVBERi0xLjIKJcDIzNINCjEgMCBvYmoKPDwKL1RpdGxlIChNaWNyb3Bob25l
X0NvbmZpZ19lbi5kb2MpCi9BdXRob3IgKEFCR1NQRU5HTEVSQikKL0NyZWF0
b3IgKHBkZkZhY3Rvcnkgd3d3LnBkZmZhY3RvcnkuY29tKQovUHJvZHVjZXIg
KHBkZkZhY3RvcnkgMi40NSBcKFdpbmRvd3MgWFAgUHJvZmVzc2lvbmFsIEdl
cm1hblwpKQovQ3JlYXRpb25EYXRlIChEOjIwMDcxMDExMTMxOTMyKzAyJzAw
JykKPj4KZW5kb2JqCjQgMCBvYmoKPDwKL0ZpbHRlciAvRmxhdGVEZWNvZGUK
L0xlbmd0aCA1IDAgUgo+PgpzdHJlYW0NCkiJ1VdLcxQ3EL7vr9AlVaYqK+s1
Gk1ugIG4EooYNuGSy3q963XwPmyvIfz7SPPSq6WZBUIlxYG1ptXPr79u3aFC
KCwFIvofYxIXUv+HFSoqZn4vNuj0ZkPR2Q5dTJ7NJqcvKaowZWi2mrBaQpEC
C4FmZ+gEPUGzvyYvZpM7REuClaq1UlVfYKrAWnchrVrWqNXSkmPmCgtKtbCo
sFStLHdlhfA0C4KF8qRF77Bg5ltZlrXTvZOnLxkqcVXHwQuKuUQEl66ETosw
Abh3aH+nwAULPlqFU1bhUqJpVRm9WmZKMBFUH80W6OS8ljdHimsl5uihPiKY
FlLbtCdGiFe0EXpc2vQKrjATSJZSl4qYn3Um7pdojd6jbR14J1LH4ZXnAt0h
I6Fzw1ks4cepvSZdDL3DlHQeV0obMUc4DotGYZFeqE8HjoRYrIlkNPVCJVAJ
IbBAUyowrQvhGn4ea5g3Zurfh8jkMq7J9a6Vskf3n900d1WQrG6ybKWkMOXI
VSqUgCulragoSM66IHdx3NuomqteqOyObqKEXMeaHlshJphsrt2n0uyhoM+2
7E5u4nu7yINtrAlFQvtkofNCSwcN9wC2eIXVMLh6YOy2x6Jre4Cg1BJTFkoF
aX1KQimUSDY9pSVvYnqdwUTj8GJM9eMq7tdH1dpCeQmUH0E543Xj5HPG8wnj
o7IVkh9AdT6xQdNDGH+mlNcHPq5+B4bHEoqY6Zk4ELCe3yQ/GUKJJN/wDiMv
+iI1f/8dMcthoNEyPW7b99avMjOjWxbKrBac1FTLSuOCG7bJsfFhNWnl9SKh
RFe3kjkYNxlXHsBJJT2EExbiuz3Y7dddo/eXloFSBCp1ldiYW79WoF/OlevH
7oRR6WWyszIPdR6GdO62Xpq5KExOuzyroTR38lCeV5GtMLEhJqPycWlQ3Kgt
WBPC036MKLCc56HZXwOBN11tmGoOPiWT5GXRUbkGqz21B29DeMyDG7dJG1QI
H1Gtig+t22iqC2JXzkbdz2cp/LXq30XFeNxeHYvZMOwITfsBjfPwQuuDCbti
fiq7+v4x0K4PUSbnPZFRUpObfseoGqckpsIWaYTq1wmtnx3MTM0cqxSKam9g
VtWbgvZLkrIj9tql39LrCSNEJVet5QPE+6Tuijzx9w4kiT+UGDHvmJXsHohT
Qcybz2xISiXeSt/o8eWUs7aqVU65K6JbQ78pi3agciZaxLy3W4XwNjGDmdLf
KcONJrjg94XVt3M+b/oNibcTcgPoc5CvZ7AImrb0dmbv5nqZvshpd3GV8nHq
qr/tubTTdBsb7O9Z7Z+iezfxve11NskLwNI2urEaY6kdjMnizeOMHcbotTN6
VKqBlDEuvS05ToZ/b5/y1CtbR4EAwmy53Zxs0nFAKA0NNfUCEltvQqle8iTv
HudRxm/TkYUd0LjwOfqK484HyAA48qy+HQOG63XCt9FptWmzi5wIZlhIOIPN
k+nlm8DKwlHwYRQc435EECOl+BVunJiXnfpvr5J0E6bLcwuucO/ir23KzaOj
aKfZ1XAR9t3e5uQsORaADj8/mu9QuooOs37d6PDszTJ06ac7lYPLeTYJPwLA
mtvdM4e/692YqGIhDw2sWUv+ZIy3iwS3iwTvt0KfEMBxH5lMzZurm+Ts88yc
uWY+DtAvAL6HeDNSvF/dmns6bpGiTS8VU1Wanc5JGbB4NSkt5XiiPYlr4edg
93g5Zgv5ZnwYXGi/fTEfwrgqhXlEOGV4F2s7jlyAWutF3rwD2pTaVQMseYZY
LCOP5Psv3J49U9dpf5IsD/gyQMDAjfllW1lKJRYuUocoInzLWai5hfw8wJCL
D0AlCS6612muYaeCm/fRV/XgMZ36r6n//kdtQK/GzI9xQ+b/BHmIt4iIwa4I
VsoORLs/wZPK+nQL8BNTWAWjiI+h2ZHbwTJmq2S2hp5iIMt1PEEqLJUGUU23
Jhro8WfL3C+wuVkETLjk4ju0DWZ2jWPeF4fDOGtdpYUz7qT50fDXTzEQOO7I
rXWsbDMadCpVbqvSmAXrE4nLCmpCYMQCQSaAz6uA5l8PrGNAy+/26912GYdf
sD47QSOAKzwAkvBhRXD758eUBAi/POBTFOcJVcUPyeFUUSyEM5y8i+zIaj5d
xBk6JGvSAR2gpvkRnPpNeOnK2+u+QxgxOsYxG3Vb0EV9cmnOgx5mILuWnuTi
5rw52cQm9vFza6Cc88xocBx6koSyx0Se6niCATiGN0lGh1fJ506o02cAUJf7
mGCc9THz6BuL6ITzFSb2sWHF33poB0ZrjP9XA5sTMNgBLefbOBGSmyfsYCK6
InOJlcNXAzB8HF7WgBRfZnrDNm5XhqHVEF7rsmvFMi5xh3JeGIT/l9d924Bh
h4zcpY5ZgKAGyRgLxis4y22F3wPkt71K7nwxzKwESl0CeDvPk+ux3U+JMitH
s8S9+SXuPCqwtPTgcGzuNUtZ3a/Rc/bFbHKHqDDhaJUESWV+MVXoPVLIwtxZ
bNDpzaZAZzt0MblA/wBosj7AZW5kc3RyZWFtCmVuZG9iago1IDAgb2JqCjE4
ODMKZW5kb2JqCjYgMCBvYmoKPDwKL1R5cGUgL1BhZ2UKL1BhcmVudCAzIDAg
UgovTWVkaWFCb3ggWzAgMCA1OTUgODQyXQovUmVzb3VyY2VzCjw8Ci9Qcm9j
U2V0IFsvUERGL1RleHQvSW1hZ2VDXQovRm9udAo8PAovRjEgMTcgMCBSCi9G
MiAxOCAwIFIKL0YzIDE5IDAgUgovRjQgMjAgMCBSCj4+Ci9YT2JqZWN0Cjw8
Ci9pbTEgNyAwIFIKL2ltMiA5IDAgUgovaW0zIDExIDAgUgovaW00IDEzIDAg
UgovaW01IDE1IDAgUgo+Pgo+PgovQ29udGVudHMgNCAwIFIKPj4KZW5kb2Jq
CjcgMCBvYmoKPDwKL1R5cGUgL1hPYmplY3QKL1N1YnR5cGUgL0ltYWdlCi9O
YW1lIC9pbTEKL1dpZHRoIDczNgovSGVpZ2h0IDMwNQovQml0c1BlckNvbXBv
bmVudCA4Ci9Db2xvclNwYWNlIC9EZXZpY2VSR0IKL0ZpbHRlciAvRENURGVj
b2RlCi9MZW5ndGggOCAwIFIKPj4Kc3RyZWFtDQr/2P/gABBKRklGAAEBAAAB
AAEAAP/bAEMACAYGBwYFCAcHBwkJCAoMFA0MCwsMGRITDxQdGh8eHRocHCAk
LicgIiwjHBwoNyksMDE0NDQfJzk9ODI8LjM0Mv/bAEMBCQkJDAsMGA0NGDIh
HCEyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMv/AABEIATEC4AMBIgACEQEDEQH/xAAfAAABBQEBAQEBAQAAAAAA
AAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEFEiEx
QQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4
OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOU
lZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj
5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUG
BwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIy
gQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdI
SUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqi
o6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery
8/T19vf4+fr/2gAMAwEAAhEDEQA/APfXdY0LucKBkmoP7QtP+e60t9/x4zf7
hrmaiUrGc5uLOl/tC0/57rR/aFp/z3WuaxRip52T7VnS/wBoWn/PdaP7QtP+
e61zWKMUc7D2rOl/tC0/57rR/aFp/wA91rmsUYo52HtWdL/aFp/z3Wj+0LT/
AJ7rXNYoxRzsPas6X+0LT/nutH9oWn/Pda5rFGKOdh7VnS/2haf891o/tC0/
57rXNYoxRzsPas6X+0LT/nutH9oWn/Pda5rFGKOdh7VnS/2haf8APdaP7QtP
+e61zWKMUc7D2rOl/tC0/wCe60f2haf891rmsUYo52HtWdL/AGhaf891o/tC
0/57rXNYoxRzsPas6X+0LT/nutH9oWn/AD3WuaxRijnYe1Z0v9oWn/PdaP7Q
tP8Anutc1ijFHOw9qzpf7QtP+e60f2haf891rmsUYo52HtWdL/aFp/z3Wj+0
LT/nutc1ijFHOw9qzpf7QtP+e60f2haf891rmsUYo52HtWdL/aFp/wA91o/t
C0/57rXNYoxRzsPas6X+0LT/AJ7rR/aFp/z3WuaxRijnYe1Z0v8AaFp/z3Wj
+0LT/nutc1ijFHOw9qzpf7QtP+e60f2haf8APda5rFGKOdh7VnS/2haf891o
/tC0/wCe61zWKMUc7D2rOl/tC0/57rR/aFp/z3WuaxRijnYe1Z0v9oWn/Pda
P7QtP+e61zWKMUc7D2rOl/tC0/57rR/aFp/z3WuaxRijnYe1Z0v9oWn/AD3W
j+0LT/nutc1ijFHOw9qzpf7QtP8AnutH9oWn/Pda5rFGKOdh7VnS/wBoWn/P
daP7QtP+e61zWKMUc7D2rOl/tC0/57rR/aFp/wA91rmsUYo52HtWdL/aFp/z
3Wj+0LT/AJ7rWBc9Yv8Arkv8qhxRzsPaM6X+0LT/AJ7rR/aFp/z3WuaxRijn
Ye1Z0v8AaFp/z3Wj+0LT/nutc1ijFHOw9qzpf7QtP+e60f2haf8APda5rFGK
Odh7VnS/2haf891o/tC0/wCe61zWKMUc7D2rOl/tC0/57rR/aFp/z3WuaxRi
jnYe1Z0v9oWn/PdaP7QtP+e61zWKMUc7D2rOl/tC0/57rR/aFr/z2X8jXOyf
6qL6H+ddJZ/8eUH+4P5VUZNlRk2N+32v/PYfkaPt9r/z2H5GrNFVqXqVvt9r
/wA9h+Ro+32v/PYfkas0UahqVvt9r/z2H5Gj7fa/89h+RqzRRqGpW+32v/PY
fkaPt9r/AM9h+RqzRRqGpW+32v8Az2H5Gj7fa/8APYfkas0UahqVvt9r/wA9
h+Ro+32v/PYfkas0UahqVvt9r/z2H5Gj+0LT/nsv61ZrD1r/AI+4/wDc/qaT
bSJk2lc0/wC0LT/nutH9oWn/AD3WuaxRio52R7VnS/2haf8APdaP7QtP+e61
zWKMUc7D2rOl/tC0/wCe61PHIkqB0bcp6GuSrpNN/wCQfD9D/M1UZNsqE3Jj
77/jxm/3DXM1019/x4zf7hrmame5NXcKKKKgyCiiigAooooAKKKKACiiigAo
oooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACii
igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAnues
X/XJf5VBU9z1i/65L/KoKBvcKKKKBBRRRQAUUUUAFFFFABRRRQAUUUUAPk/1
cX0P866Sz/48oP8AcH8q5uT/AFcX0P8AOuks/wDjyg/3B/KtIbmtPcnooorQ
2CiiigAooooAKKKKACiiigAooooAKw9a/wCPuP8A3P6mtysPWv8Aj7j/ANz+
pqZ7EVPhM2iiisTnCiiigA7V0em/8g6H6H+ZrnO1dHpv/IOh+h/mauG5pS3H
33/HjN/uGuZrpr7/AI8Zv9w1zNE9x1dwoooqDIKKKKACiiigAooooAKKKKAC
iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK
KKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigCe56
xf8AXJf5VBU9z1i/65L/ACqCgb3CiiigQUUUUAFFFFABRRRQAUUUUAFFFFAD
5P8AVxfQ/wA66Sz/AOPKD/cH8q5uT/VxfQ/zrpLP/jyg/wBwfyrSG5rT3J6K
KM1obBUYniMpiEiGQDJTcM4+lY2v6jPaXFnbx3sdik4ctcyR7wCuMLg8c5PX
0rOit5LtLSSDSTFdtOkr3qsAGTOS+c7iGH8B9faoc9bI66eGvBTk7J/11t26
XZ11FGaM1ZyBRRmigAooooAKKKKACsPWv+PuP/c/qa3Kw9a/4+4/9z+pqZ7E
VPhM2iiisTnCiiigA7V0em/8g6H6H+ZrnO1dHpv/ACDofof5mrhuaUtx99/x
4zf7hrma6a+/48Zv9w1zNE9x1dwoooqDIKKigure53+RPFLsOG8tw20+hx0q
WgAooprukaF3YKqjJZjgCgB1FQW97a3e77NcwzbfveW4bH1xU9ABRRRQAUUU
UAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAT3PWL/
AK5L/KodrFSwUkDqfSprnrF/1yX+VEBzDcRgZLKCPwNPqV1ISjjblGG7kcdf
pQQVJBBBHBBrROJHiH/PCUJ/wED/AOsajSCCbMs0oXzHb+LHH9aLD5SjRT4U
ElwkbHhmwSKtiC0KB/3uPM8vGRz70JCSuUaXDbd2DtJxmrMMCOxVklchtpK8
ACpFgU2bbydkcjZx1PSiwcpRoq6lrB5KNJKFZ1J5bp6cYqvaxpLKVkbHykgZ
xk+lFg5WRUVNJCAJTsdCmMBjU32aFHm3l9saK3B5ycUWDlKdFXvslusKs8u1
nTeAX5HpxiqNDVhNWHyf6uL6H+ddJZ/8eUH+4P5Vzcn+ri+h/nXSWf8Ax5Qf
7g/lVw3NKe5xN3cQt421a3vZNQNvHHE0aWxchSV5J29KvaUzR+O57RJpmtk0
5HRZHJ5LAZOe+K0bLSrq38XapqUip9muo4kjw3OVGDkVDd6ZqFp4qOtWUUVx
FLbC3khZ9rAhs5HGOwqOVrXzPelWpyXs0/sJb6Xsvue5y+pXdzDpPix0uJQ1
vdQrCd5+QFhkD8zWzbpLd+NLzTmuZ0thYRvtWQjkkZwe1Zuu6Td6f4K1y6v2
i+1X08cjpESVXDgAAmujsdJu4vFs+quEFtLZpCo3fNuBB5HpURT5rf11OirV
pqk5Jrqk/NKnt+JiaVZ3E9xr/kXNy89jclLVXnYrwOAR3/Gm6Fd2c+nXJnur
yPXI7eTz47mRkZjg8hCcenQVu6Rpd/p11rk+2Etd3JmgBYkEf7XpVLUNEvtf
1Kynns4bFYCWllVw0knGNoIHT60+VpJpGft4TlKMpe7prfstrdU326lBLq5H
wpmu/tEv2jZv83cd2d4HWuz0wY0u15JzEpJJySSK5E6Brg8LzeHFitTG77Uu
jIcCPdnkYzu4+laevaRqVx/ZqWEkjW1vHIk0KXTQNISoEbZX+6QT+Oeaumnf
Xsc2OlTcWotO8pPTtpb/AIY6aivOL7wz4wkmikstQkikiffIX1CQpOwl3r8u
OF2jaR6HFTweFfFM9rcG71p4bl0Z1MdxIQsjPI20HIAQb1XoThQBjFbHmHoF
FcZe6DrOom+uvPntp5lm8iJb5wIj5KJH904++rN/wKs9PDXikyRSrfyReXbp
GUN5Jln3NubOSBwRyQenQUAeh1h61/x9x/7n9TTvDNlqFjYyxX7lj5mYt0hd
wuB94kkZznocfSm61/x9x/7n9TUz2IqfCZtFFFYnOFFFFAB2ro9N/wCQdD9D
/M1znauj03/kHQ/Q/wAzVw3NKW4++/48Zv8AcNczXTX3/HjN/uGuZonuOruF
FFFQZHnPwr/13iP/AK/f/iq9C+0Q4kPmx4j+/wDMPl+vpXn3wr/13iP/AK/f
6tWVo+kf2/4/1+xut39mw3rXMqKcCVw2FVvUck4qmtTSSu2eqW91b3ce+3mj
lXOMowIrgfHs0OpeINA0SedPsM1xvuFD4zjPBI6cZ/Olt9Og8P8AxWtrfTVF
vaX1qzSQR8JlVOOPw/U1V8W6Jph+IHh9DYw7buRjcDb/AK36+tC3CKSZ2mia
FoekGV9Ht4YvMAWQxOWzjpnk+tXxqNkbn7MLuDz+nl+YN35VxHjoW3hfwsbL
RIEsZdQnWPMHyntnp7cVoXHw90OPw1LYwWcYuVhPl3ZUebvHIO7Gev6UeYrL
dnYMwVSzEBQMkntUMl5bRRpJJcRKjnCsXGG+nrXDeHtVudV+Fuqi7bfPaQXF
qzEkltsfBJPfBql4B8H2upaNZa1q++5k24toXY7IlUkAgepxmiwcttz0j7RC
C482PMYy43D5R7+lNtry2vFZraeOZVOCY2Bwa8ug0ga58VdYsp2b7Gu2edAc
CQKQAh9QS3I9qXXPDyW3xDs9H0dm0+11O1/0lbc7RhSxJGOnC4/E+tFh8qPU
IL21uZHjguIpHT7yo4JH1qevOtf0ax8OeJfC9xpFulm014LaYRfKJEYrw3rX
otJoloKKKKRIUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQA
UUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAT3PWL/r
kv8AKmW8xt51lADEZ4NPuesX/XJf5VBT6je5NDcNCZSACZFIOffvSRzKsXly
RCRQcj5iMVFRRcLsdG/lyq4H3TnFPE5WNUwOJN9RUUguWFu8KA0SsVYspJ6E
/wA6Rbt16KMFixHqD1FQUU7sLsn+0o0YSSEMFzs+YjA9Peoo2RGy8e8Y6ZxT
aKQXLH2sFzuiDR7QoTJ4A6c0kl20plJUAyhQfbH/AOqoKKd2F2TfaFaIJLEH
KjCtnBAqGiikFx8n+ri+h/nXSWf/AB5Qf7g/lXNyf6uL6H+ddJZ/8eUH+4P5
VpDc0p7k9FFFaGxXubK3uzEZ4xJ5Tb0BJwD647/jXBeK2ubfxCJ9UguJ9KKh
YxDIUC+/Hfr1r0WsHU/D9zqFxK6azeQQyja0KkFcd8VtQkoSuzizClUrUVCN
3Z+VvmnpY4zxFeWp0nRjpN1MbfzZAdzNuB+Q7Tn0zVnXGSTx3dQ3H2x4BCpE
dsxznaOeK3ZfAdg9ja2iXE6LBI0m7gl2bbnPH+yKs3/hNbzWZNUi1K7tZ3UK
fJIHAAHX8K6FWpq1n3/M8uWBxMrtxWrjottE0zntcsnHh7TrfTTdo090xCzO
d+dp4/SqsviO41LwpaaZBIWv5NwmYHBVU+bOfcD9DXZReHiqWgn1C6uXtrgz
q8xBJ+XG36VDbeELC0u764jLA3SlQMD90D121KrQtrrbU0ngcQ5XhopKz9LL
bz3XzOMvbicfD3TpBNJvN4QWDHJG1q19Pt7VdJv7i3XUI5VteWuGO05Hateb
wZazaFBpRuphHDL5ocAbicEY/WpbfwzJFFLFLrF9cRSRGPZK4IAPcCnKtBqy
fUmnga8Zpyjf3Uum9jhtN1q5sdH1DTryVwtzbGa3kLEnccDAP4H8qv6y94lp
otzdw3FzpAsovMWOXZmQqeSRz6V0t74Jsb3TLOzeWRWtRtWZQNzLzwePeprj
w5cPFbRWusXltHBAsG1CMMF4yR603Xpt3REcBilBwlqklbbvezvul+JL4Xud
Nn0kDTJZHhVjlZSSyE9jmk1r/j7j/wBz+pqfQtBtdAtGgti7lzud3xlj+FQa
1/x9x/7n9TXFXabbjsexSjONCKqJJ+Wxm0UUVzCCiiigA7V0em/8g6H6H+Zr
nO1dHpv/ACDofof5mrhuaUtx99/x4zf7hrma6a+/48Zv9w1zNE9x1dwoooqD
I86+Ff8ArvEf/X7/AFarngoD/hKfFhwM/b25/E11mn6Rp+lGc2NrHAZ23y7B
95vU/nTrXTLOyuLie2t0iluX3zMvV29TVNluV7nJaj/yVzRf+vSX/wBBNReL
P+Sh+Ff+uh/rXZPplnJqMWoPbo13EpRJj95QeopLjS7K7vbe8uLZJLi3OYZG
6p9KVwUjkfinp8lx4ci1CIFm0+dZSvqCQK2LrxhpH/CLzaxFeRNH5LMi5wxb
oFx1znjpXQkbhggEHqDXPR+BPDMV6t4mkQiZW3g7mwD/ALucfpRdW1BNWszm
/C9jcWfwr1ia4TY97Fc3QX/ZaPA/lXSeBOPA+kf9cB/M1uzW8VxbSW8qK0Mi
FHQ9CpGCPyptpaQWFpHa2sSxQRDaiL0UUN3E5XOI8Nf8lQ8Tcf8ALNP51Z1H
/kruj/8AYPk/m1dTBpdjbX899BbIl1OAJZR1f60r6bZyajHqD26G8iQxpMfv
Kp6j9aLj5tTlfHP/ACGfCf8A2FE/mK7Wqt3ptnfS28t1bpK9tIJYS38DDuKt
UEt6BRRRSEFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFF
FFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAE9z1i/wCu
S/yqCp7nrF/1yX+VQUDe4UUUUCCiiigAooooAKKKKACiiigAooooAfJ/q4vo
f510ln/x5Qf7g/lXNyf6uL6H+ddJZ/8AHlB/uD+VaQ3Nae5PRRRWhsFFFFAB
RRRQAUUUUAFFFFABRRRQAVh61/x9x/7n9TW5WHrX/H3H/uf1NTPYip8Jm0UU
Vic4UUUUAHauj03/AJB0P0P8zXOdq6PTf+QdD9D/ADNXDc0pbj77/jxm/wBw
1zNdNff8eM3+4a5mie46u4UUUVBkFFFFABRRRQAUUUUAFFFFABRRRQAUUUUA
FFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAU
UUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBPc9Yv+uS/yqCp
7nrF/wBcl/lUFA3uFFFFAgooooAKKKKACiiigAooooAKKKKAHyf6uL6H+ddJ
Z/8AHlB/uD+Vc3J/q4vof510ln/x5Qf7g/lWkNzWnuT0UUVobBRRRQAUUUUA
FFFFABRRRQAUUUUAFYetf8fcf+5/U1uVh61/x9x/7n9TUz2IqfCZtFFFYnOF
FFFAB2ro9N/5B0P0P8zXOdq6PTf+QdD9D/M1cNzSluPvv+PGb/cNczXTX3/H
jN/uGuZonuOruFFFFQZBRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUU
UAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQ
AUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAWZ4ZX8pkjdh5S8hSe1RfZ5
/wDnjJ/3waaJHAwHYD60eZJ/z0b86ZWg77PP/wA8ZP8Avg0fZ5/+eMn/AHwa
b5kn/PRvzo8yT/no350haDvs8/8Azxk/74NH2ef/AJ4yf98Gm+ZJ/wA9G/Oj
zJP+ejfnQGg77PP/AM8ZP++DR9nn/wCeMn/fBpvmSf8APRvzo8yT/no350Bo
O+zz/wDPGT/vg0fZ5/8AnjJ/3wab5kn/AD0b86PMk/56N+dAaDvs8/8Azxk/
74NH2ef/AJ4yf98Gm+ZJ/wA9G/OjzJP+ejfnQGg77PP/AM8ZP++DR9nn/wCe
Mn/fBpvmSf8APRvzo8yT/no350BoOmRkSIOpU4PBGO9dHZkfYoP9wfyrmWLM
csxP1NKJHAwHYD61SlYqMrM6zI9aMj1rk/Mk/wCejfnR5kn/AD0b86r2hftf
I6zI9aMj1rk/Mk/56N+dHmSf89G/Oj2ge18jrMj1oyPWuT8yT/no350eZJ/z
0b86PaB7XyOsyPWjI9a5PzJP+ejfnR5kn/PRvzo9oHtfI6zI9aMj1rk/Mk/5
6N+dHmSf89G/Oj2ge18jrMj1oyPWuT8yT/no350eZJ/z0b86PaB7XyOsyPWs
PWv+PuP/AHP6ms/zJP8Ano350hZmOWYn6mk53RMp3VhKKKKgzCiiigA7V0em
/wDIOh+h/ma5ztXR6b/yDofof5mrhuaUtx99/wAeM3+4a5mumvv+PGb/AHDX
M0T3HV3CiiioMgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAO1dHpv/IOh+h/ma5ztXR6b/yDofof5mrhuaUtx99/x4zf7hrma6a+/wCP
Gb/cNczRPcdXcKKKKgyCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooo
oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiig
AooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAC
iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK
KKACiiigA7V0em/8g6H6H+ZrnO1dHpv/ACDofof5mrhuaUtx99/x4zf7hrma
6a+/48Zv9w1zNE9x1dwoooqDIKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigA
ooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACi
iigAooooAKKKKADtXR6b/wAg6H6H+ZrnO1dHpv8AyDofof5mrhuaUtx99/x4
zf7hrma6a+/48Zv9w1zNE9x1dwoooqDIKKKKACiiigAooooAKKKKACiiigAo
oooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACii
igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA
KKKKACiiigAooooAKKKKADtXR6b/AMg6H6H+ZrnO1dHpv/IOh+h/mauG5pS3
H33/AB4zf7hrma6a+/48Zv8AcNczRPcdXcKKKKgyCiiigAooooAKKKKACiii
gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigA7V0em/8g6H6H+ZrnO1dHpv/IOh+h/m
auG5pS3H33/HjN/uGuZrpr7/AI8Zv9w1zNE9x1dwoooqDIKKKKACiiigAooo
oAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiig
AooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAC
iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK
KKACiiigAooooAKKKKACiiigAooooAKKKKADtXR6b/yDofof5muc7V0em/8A
IOh+h/mauG5pS3H33/HjN/uGuZrpr7/jxm/3DXM0T3HV3CiiioMgooooAKKK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigA
ooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACi
iigAooooAKKKKACiiigAooooAKKKKACiiigAooooAO1dHpv/ACDofof5muc7
V0em/wDIOh+h/mauG5pS3H33/HjN/uGuZrpr7/jxm/3DXM0T3HV3CiiioMgo
oooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACii
igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA
KKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAO1dHpv8AyDof
of5muc7V0em/8g6H6H+Zq4bmlLcfff8AHjN/uGuZrpr7/jxm/wBw1zNE9x1d
woooqDIKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo
ooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKADtXR
6b/yDofof5muc7V0em/8g6H6H+Zq4bmlLcfff8eM3+4a5mumvv8Ajxm/3DXM
0T3HV3CiiioMgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiig
AooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAC
iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK
KKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooo
oAO1dHpv/IOh+h/ma5ztXR6b/wAg6H6H+Zq4bmlLcfff8eM3+4a5mupuYzLb
SRr1ZSBmsb+x7j1T86c02yqkW3oZ9FaP9j3Hqn50f2PceqfnUcrM+SXYzqK0
f7HuPVPzo/se49U/OjlYckuxnUVo/wBj3Hqn50f2PceqfnRysOSXYzqK0f7H
uPVPzo/se49U/OjlYckuxnUVo/2PceqfnR/Y9x6p+dHKw5JdjOorR/se49U/
Oj+x7j1T86OVhyS7GdRWj/Y9x6p+dH9j3Hqn50crDkl2M6itH+x7j1T86P7H
uPVPzo5WHJLsZ1FaP9j3Hqn50f2PceqfnRysOSXYzqK0f7HuPVPzo/se49U/
OjlYckuxnUVo/wBj3Hqn50f2PceqfnRysOSXYzqK0f7HuPVPzo/se49U/Ojl
YckuxnUVo/2PceqfnR/Y9x6p+dHKw5JdjOorR/se49U/Oj+x7j1T86OVhyS7
GdRWj/Y9x6p+dH9j3Hqn50crDkl2M6itH+x7j1T86P7HuPVPzo5WHJLsZ1Fa
P9j3Hqn50f2PceqfnRysOSXYzqK0f7HuPVPzo/se49U/OjlYckuxnUVo/wBj
3Hqn50f2PceqfnRysOSXYzqK0f7HuPVPzo/se49U/OjlYckuxnUVo/2Pceqf
nR/Y9x6p+dHKw5JdjOorR/se49U/Oj+x7j1T86OVhyS7GdRWj/Y9x6p+dH9j
3Hqn50crDkl2M6itH+x7j1T86P7HuPVPzo5WHJLsZ1FaP9j3Hqn50f2Pceqf
nRysOSXYzqK0f7HuPVPzo/se49U/OjlYckuxnUVo/wBj3Hqn50f2PceqfnRy
sOSXYzqK0f7HuPVPzo/se49U/OjlYckuxnUVo/2PceqfnR/Y9x6p+dHKw5Jd
jOorR/se49U/Oj+x7j1T86OVhyS7GdRWj/Y9x6p+dH9j3Hqn50crDkl2M6it
H+x7j1T86P7HuPVPzo5WHJLsZ1FaP9j3Hqn50f2PceqfnRysOSXYzqK0f7Hu
PVPzo/se49U/OjlYckuxnUVo/wBj3Hqn50f2PceqfnRysOSXYzqK0f7HuPVP
zo/se49U/OjlYckuxnUVo/2PceqfnR/Y9x6p+dHKw5JdjOorR/se49U/Oj+x
7j1T86OVhyS7GdRWj/Y9x6p+dH9j3Hqn50crDkl2M6itH+x7j1T86P7HuPVP
zo5WHJLsZ1FaP9j3Hqn50f2PceqfnRysOSXYzqK0f7HuPVPzo/se49U/OjlY
ckuxnUVo/wBj3Hqn50f2PceqfnRysOSXYzqK0f7HuPVPzo/se49U/OjlYcku
xndq6PTf+QdD9D/M1mf2PceqfnWvZwtBaRxNjco5x9auCaZpTi09SeiiitDU
KKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAo
oooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACii
igAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKK
ACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooA
/9llbmRzdHJlYW0KZW5kb2JqCjggMCBvYmoKMTAyMzMKZW5kb2JqCjkgMCBv
YmoKPDwKL1R5cGUgL1hPYmplY3QKL1N1YnR5cGUgL0ltYWdlCi9OYW1lIC9p
bTIKL1dpZHRoIDIyOQovSGVpZ2h0IDI1NAovQml0c1BlckNvbXBvbmVudCA4
Ci9Db2xvclNwYWNlIC9EZXZpY2VSR0IKL0ZpbHRlciAvRENURGVjb2RlCi9M
ZW5ndGggMTAgMCBSCj4+CnN0cmVhbQ0K/9j/4AAQSkZJRgABAQAAAQABAAD/
2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIs
IxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjL/wAARCAD+AOUDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAEC
AwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1Fh
ByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RF
RkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZ
mqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo
6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL
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
KKKKACiiigCO4/49pf8AcP8AKsa3I+0xfKv3x/Evr9K3GUOjKc4IxxVdbGJH
Vg0mQc8uapOxEotsdcf6+1/66n/0Bqil/wCPuX/rnH/N6luP9fa/9dT/AOgN
UUv/AB9y/wDXOP8Am9SWfO2r2wi1OZx/GQf0FFSa0+dRcemP5CivUpfAjwMV
/Gken+Hf9TL/ANekn8kru7L/AI8Lf/rkv8hXC+HxiCT/AK9JP5JXdWX/AB4W
/wD1yX+QrzGe9HYLH/kH23/XJf5Cp6gsf+Qfbf8AXJf5Cp6QwooooAKKKKAC
iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAILj/X2v8A11P/
AKA1RS/8fcv/AFzj/m9S3H+vtf8Arqf/AEBqil/4+5f+ucf83oA+ctUkJ1e5
HoV/lRT9XjA1Wdh3I/kKK9Sn8CPn8V/GkereH/8AUSf9ekn8krubL/jwt/8A
rkv8hXDeH/8AUSf9ekn8krubL/jwt/8Arkv8hXmHvoLH/kH23/XJf5Cp6gsf
+Qfbf9cl/kKnpDCiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKK
KACiiigAooooAguP9fa/9dT/AOgNUUv/AB9y/wDXOP8Am9S3H+vtf+up/wDQ
GqKX/j7l/wCucf8AN6APnnWAf7Sl/D+QopdZz/aMn4fyFFerT+FHz+K/jSPT
PDUySwzBTnbayA/+OV31l/x4W/8A1yX+QrzXwZbvBFdl2yXt5SPb7telWX/H
hb/9cl/kK8lO6uj6C1gsf+Qfbf8AXJf5Cp6gsf8AkH23/XJf5Cp6YBRRRQAU
UUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAQXH+vtf+
up/9Aaopf+PuX/rnH/N6luP9fa/9dT/6A1RS/wDH3L/1zj/m9AHz5rf/AB/t
+H8hRSayD/aD59v5CivVp/Cj5/FfxpHpfhtSIps97WT/ANkrvrL/AI8Lf/rk
v8hXC+HxiCT/AK9JP5JXdWX/AB4W/wD1yX+QrxqXwH0Ld3cLH/kH23/XJf5C
p6gsf+Qfbf8AXJf5Cp60EFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABR
RRQAUUUUAFFFFABRRRQBBcf6+1/66n/0Bqil/wCPuX/rnH/N6luP9fa/9dT/
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
m9tudt1IgJXocAAZHr1/KoYvCUUCRLDbxxiFiyFbqUEEgA89egry1/GXiHPy
6hIP+2r/AONM/wCEx8Sf9BF/+/r/AONL2Mh/WaZ6/Z6HLYrtt0iUbVT5p3fC
jOByDwMmrEljfNE6gW/zKV5kPcY/u14x/wAJj4k/6CD/APf1/wDGrEPjHXQc
y38xHtI//wAVR7CbD6zTPc2DiRXUKcAggnHXH+FO8yX/AJ5p/wB9n/CvFv8A
hNdRx/x9XOf+urf/ABVNPjPUz0vLkf8AbRv/AIqq+rTF9apnrZ0qJrkzMhJJ
YlRJgHOc5wuT1PWnrp0ShAIuUdHyZSSSvTORXjreMdXPS/uB/wBtG/8AiqZ/
wmOtjpfz/jI//wAVR9XmH1qme5eZL/zzT/vs/wCFN+dpVZlUBVI4bOc49vav
Dh4x1wdb+Y/9tH/+KoPjLXO19L/38f8AxpfV5j+tUzO1c51KX6j+QorA1XXv
LuyqxGSbrIWOB0GMdc/jRXTGtCC5WzzquGqVZucFoz//2WVuZHN0cmVhbQpl
bmRvYmoKMTAgMCBvYmoKOTgyMAplbmRvYmoKMTEgMCBvYmoKPDwKL1R5cGUg
L1hPYmplY3QKL1N1YnR5cGUgL0ltYWdlCi9OYW1lIC9pbTMKL1dpZHRoIDIx
OQovSGVpZ2h0IDI1NAovQml0c1BlckNvbXBvbmVudCA4Ci9Db2xvclNwYWNl
IC9EZXZpY2VSR0IKL0ZpbHRlciAvRENURGVjb2RlCi9MZW5ndGggMTIgMCBS
Cj4+CnN0cmVhbQ0K/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgH
BwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0
Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAD+ANsD
ASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QA
tRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0Kx
wRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZ
WmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKz
tLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6
/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQD
BAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLR
ChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hp
anN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6
wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIR
AxEAPwC/pWlQtB9mgEVvHBENoAABx6+pPUmrtpYpLAZdu4qHyqfMcqzKQMdc
7f1qvp1ve3DebYed5kYGTEjNgH1AB9O/pWlDY6tEu37LOc7snyJPmyxYk/L1
yxrTSxmitCtgbVJbuSO2cpvZS4cKOerDj+E8deDSH+ym2+Xco+dhOOMB87T7
5xjA5zx1qQaJdLK8g064JdcMDHLyfm+Y8ct8x5PNPbSbx2dn02d2fbuLxysS
R0PI69OevFJjIY4tLnJEN4spDlCIwWOQQO3+8v51FcQQW2rNZTAqgjVvNDgn
cxwF2jnk8Z9eKttpuomIw/2fcGMjG0pLjbkHaOOF4HHSpXg1mQsWsZiWKscw
vyVOV/h7GgCkINM+X/TFG7pkEYHHJ9B8y8nj5h6ioy2lvErwXHnl1JXYpxwG
PzHGF+43X0pf7C1ATJINNnwi7QhjkKkfLjIxzjaoAPAwOOBU39m6sY/LbTrh
lA25ZJWOMMMZIzjDMPocUrsGNit9PuWaK3ulkmUlXRMttI659u2emeOtY+oK
bViATwfWtg6ZrAK7LC4GxzIi7JdqsQQSBjA6n8z61n3fh/XbkktZTnP/AEyf
/wCJqlYl3MNrx/75/Oq730oPEjf99GtY+EdbP/LjN/36f/4mon8G663/AC4T
f9+n/wAKq6J94ymvpsZ85/8Avo1F/aE2f9dJ/wB9mtY+C9f/AOfCb/v0/wDh
TP8AhB9f/wCfCb/v2/8AhR7oWkUU1CU/8tn/AO+jUy3khPMr/wDfRq0vgrXw
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
8/o/78J/hR9WmH1umeoeVdf8+8v5p/8AFUqQXLuimF1XerFmK4ADA9ifSvL/
APhYWv8A/P5/5AT/AAo/4WFrv/P5/wCQY/8ACj6tMPrdM9TuILgXMrJEzq7B
gVK/3QMHJHpVO60+4uhHmO5jeNt6PGY8qcEHqxHQkcj9a85/4WFrn/P4f+/M
f+FL/wALC1z/AJ/D/wB+I/8ACj6tMPrdM7P/AIRKA+eXt7t2mG1maRC2Mg9d
2TyBycmprXw6LW++2LbzNOSWLssIYkg5JIwTnJOM49AK4X/hYWuf8/h/78R/
4Uf8LC1z/n8P/fmP/Cj6tMPrdM9OEd0GB+zynB9U/wDiqvQRyQ2tqrLlo1UM
FP8As44z715H/wALC1z/AJ/D/wB+Y/8ACj/hYWu/8/h/78R/4UfVph9bpnsf
nH/njJ/47/jWa2nJJPI8iylHBBQY5y27klj39MV5d/wsLXf+fz/yBH/hR/ws
LXf+fz/yDH/hR9WmH1un3PVoLKKB43EU7OmMsdvzYGB0OPT8hV3zj/zxk/8A
Hf8AGvG/+Fha9/z+f+QE/wAKX/hYWvf8/n/kFP8ACj6tMPrVM9U1bJ0TVGKl
d0EhAPX7leC3jbrpz9P5V0U3j3WriGSGa6DxyKUdfJQZBGCOBmuBu9d3Xcnk
wZjBwC7YJxweBnvW1KPsU+fqcuJf1hKNPWx//9llbmRzdHJlYW0KZW5kb2Jq
CjEyIDAgb2JqCjExNjI3CmVuZG9iagoxMyAwIG9iago8PAovVHlwZSAvWE9i
amVjdAovU3VidHlwZSAvSW1hZ2UKL05hbWUgL2ltNAovV2lkdGggMjE5Ci9I
ZWlnaHQgMjU0Ci9CaXRzUGVyQ29tcG9uZW50IDgKL0NvbG9yU3BhY2UgL0Rl
dmljZVJHQgovRmlsdGVyIC9EQ1REZWNvZGUKL0xlbmd0aCAxNCAwIFIKPj4K
c3RyZWFtDQr/2P/gABBKRklGAAEBAAABAAEAAP/bAEMACAYGBwYFCAcHBwkJ
CAoMFA0MCwsMGRITDxQdGh8eHRocHCAkLicgIiwjHBwoNyksMDE0NDQfJzk9
ODI8LjM0Mv/bAEMBCQkJDAsMGA0NGDIhHCEyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMv/AABEIAP4A2wMBIgAC
EQEDEQH/xAAfAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAAC
AQMDAgQDBQUEBAAAAX0BAgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR
8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2Rl
ZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAf
AQADAQEBAQEBAQEBAAAAAAAAAQIDBAUGBwgJCgv/xAC1EQACAQIEBAMEBwUE
BAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ0
4SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1
dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TF
xsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/
AL+laVC0H2aARW8cEQ2gAAHHr6k9Sau2liksBl27iofKp8xyrMpAx1zt/Wq+
nW97cN5th53mRgZMSM2AfUAH07+laUNjq0S7fss5zuyfIk+bLFiT8vXLGtNL
GaK0K2BtUlu5I7Zym9lLhwo56sOP4Tx14NIf7Kbb5dyj52E44wHztPvnGMDn
PHWpBol0sryDTrgl1wwMcvJ+b5jxy3zHk809tJvHZ2fTZ3Z9u4vHKxJHQ8jr
0568UmMhji0uckQ3iykOUIjBY5BA7f7y/nUVxBBbas1lMCqCNW80OCdzHAXa
OeTxn14q22m6iYjD/Z9wYyMbSkuNuQdo44XgcdKleDWZCxaxmJYqxzC/JU5X
+HsaAKQg0z5f9MUbumQRgccn0HzLyePmHqKjLaW8SvBceeXUldinHAY/McYX
7jdfSl/sLUBMkg02fCLtCGOQqR8uMjHONqgA8DA44FTf2bqxj8ttOuGUDblk
lY4wwxkjOMMw+hxSuwY2K30+5Zore6WSZSVdEy20jrn27Z6Z461j6gptWIBP
B9a2DpmsArssLgbHMiLsl2qxBBIGMDqfzPrWfd+H9duSS1lOc/8ATJ//AImq
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
TPZqK8Z/4WHr/wDz+/8AkBP8KP8AhYev/wDP6P8Avwn+FH1aYfW6Z7NWOlvd
RxpH5Eh2KFypXBwMZGWFeY/8LD1//n8/8gJ/hR/wsPX/APn8/wDICf4UfVph
9bpnpsttPNE8UlrKyOpVhlOQev8AFWfD4fMN4bwR3jXR27pmePcwHG0/NjGM
cd8A9ea4L/hYWv8A/P4P+/Kf4Uf8LC1//n9H/fhP8KPq0w+t0z1Dyrr/AJ95
fzT/AOKpUguXdFMLqu9WLMVwAGB7E+leX/8ACwtf/wCfz/yAn+FH/Cwtd/5/
P/IMf+FH1aYfW6Z6ncQXAuZWSJnV2DAqV/ugYOSPSqd1p9xdCPMdzG8bb0eM
x5U4IPViOhI5H615z/wsLXP+fw/9+Y/8KX/hYWuf8/h/78R/4UfVph9bpnZ/
8IlAfPL2927TDazNIhbGQeu7J5A5OTU1r4dFrffbFt5mnJLF2WEMSQckkYJz
knGcegFcL/wsLXP+fw/9+I/8KP8AhYWuf8/h/wC/Mf8AhR9WmH1umenCO6DA
/Z5Tg+qf/FVegjkhtbVWXLRqoYKf9nHGfevI/wDhYWuf8/h/78x/4Uf8LC13
/n8P/fiP/Cj6tMPrdM9j84/88ZP/AB3/ABrNbTkknkeRZSjggoMc5bdySx7+
mK8u/wCFha7/AM/n/kCP/Cj/AIWFrv8Az+f+QY/8KPq0w+t0+56tBZRQPG4i
nZ0xljt+bAwOhx6fkKu+cf8AnjJ/47/jXjf/AAsLXv8An8/8gJ/hS/8ACwte
/wCfz/yCn+FH1aYfWqZ6pq2TomqMVK7oJCAev3K8FvG3XTn6fyropvHutXEM
kM10HjkUo6+SgyCMEcDNcDd67uu5PJgzGDgF2wTjg8DPetqUfYp8/U5cS/rC
Uaetj//ZZW5kc3RyZWFtCmVuZG9iagoxNCAwIG9iagoxMTY1MwplbmRvYmoK
MTUgMCBvYmoKPDwKL1R5cGUgL1hPYmplY3QKL1N1YnR5cGUgL0ltYWdlCi9O
YW1lIC9pbTUKL1dpZHRoIDE4NwovSGVpZ2h0IDkxCi9CaXRzUGVyQ29tcG9u
ZW50IDgKL0NvbG9yU3BhY2UgL0RldmljZVJHQgovRmlsdGVyIC9EQ1REZWNv
ZGUKL0xlbmd0aCAxNiAwIFIKPj4Kc3RyZWFtDQr/2P/gABBKRklGAAEBAAAB
AAEAAP/bAEMACAYGBwYFCAcHBwkJCAoMFA0MCwsMGRITDxQdGh8eHRocHCAk
LicgIiwjHBwoNyksMDE0NDQfJzk9ODI8LjM0Mv/bAEMBCQkJDAsMGA0NGDIh
HCEyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMv/AABEIAFsAuwMBIgACEQEDEQH/xAAfAAABBQEBAQEBAQAAAAAA
AAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEFEiEx
QQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4
OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOU
lZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj
5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUG
BwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIy
gQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdI
SUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqi
o6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery
8/T19vf4+fr/2gAMAwEAAhEDEQA/APGRIW57mnb3XJI/Gk3hRynTHPrTd5Oe
nWsSkOEhIAxT0Y9DxURxwe2e1OLJt3E8e1FgsSnLHAINNQ7VIOMigSqz7lFN
dR5m5SQKVgY/+HkcUhVfu9z1NCq+Tg4FNb5enJoQDDGyhsdM8GmJvySQTU6k
uB+eKkUgEetO9gRCuSCCMGpFT5Q2eaexXaT0I/WoA+SeORSbbBgyZjIbqTVc
LhsenerLYK9M1G0atg9BVLYCNGwMYFKOSeMVMgjTgfrTWJVyAo/GmMheJzyO
lRGFiRVshicnGKTKkck/jRcRUMTe1NMX4VabA6kVA4Gev4U0wIzH6UwpjvTy
T2puMnJpiG7R2NNx708gDmmfjTA0XYSNggj2oYMpJwMYHehITuAJbrShDlg3
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
xDiTWKDDTLBERztJE61pr76l/yFwItWHPqhmX64O5Mx814r8b61Yn+X69oka
u9SNtKEca22ZgqJRjXP9TZvTffH97Hb2Af0JcVI2/mVuZHN0cmVhbQplbmRv
YmoKMjIgMCBvYmoKMjM0MAplbmRvYmoKMjMgMCBvYmoKPDwKL1R5cGUgL1Bh
Z2UKL1BhcmVudCAzIDAgUgovTWVkaWFCb3ggWzAgMCA1OTUgODQyXQovUmVz
b3VyY2VzCjw8Ci9Qcm9jU2V0IFsvUERGL1RleHQvSW1hZ2VDXQovRm9udAo8
PAovRjEgMTcgMCBSCi9GMiAxOCAwIFIKL0YzIDE5IDAgUgovRjUgMzAgMCBS
Cj4+Ci9YT2JqZWN0Cjw8Ci9pbTYgMjQgMCBSCi9pbTcgMjYgMCBSCi9pbTgg
MjggMCBSCj4+Ci9FeHRHU3RhdGUgPDwKL0dTMSAzMSAwIFIKPj4KPj4KL0Nv
bnRlbnRzIDIxIDAgUgovQW5ub3RzIDMyIDAgUgo+PgplbmRvYmoKMjQgMCBv
YmoKPDwKL1R5cGUgL1hPYmplY3QKL1N1YnR5cGUgL0ltYWdlCi9OYW1lIC9p
bTYKL1dpZHRoIDQ3MAovSGVpZ2h0IDM2NgovQml0c1BlckNvbXBvbmVudCA4
Ci9Db2xvclNwYWNlIC9EZXZpY2VSR0IKL0ZpbHRlciAvRENURGVjb2RlCi9M
ZW5ndGggMjUgMCBSCj4+CnN0cmVhbQ0K/9j/4AAQSkZJRgABAQAAAQABAAD/
2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIs
IxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjL/wAARCAFuAdYDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAEC
AwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1Fh
ByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RF
RkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZ
mqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo
6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL
/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKR
obHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RV
VldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaan
qKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3
+Pn6/9oADAMBAAIRAxEAPwDroBpei6Pbl4YEVwoG6MM0shHTkEljjpVrS7q3
1CaOA2VukrRGRlEasFwQMZ2jPJP5VXurK31DR7aG4neDCq6Oj7SGC/r16Hil
0e2g0uVJnv4ppRE0ZIwoILbumTjv3qnz8ytsC9n7N3fvX/Av295pE8l4jLbQ
i0fZK8qRqoOSvXtyO+KW8vNEsbhILiSzVmJBxGhCEf3sDjr3qvPbaTcFmaVA
zOXJ3K2SWLdGBBwWbt/Eah/s3RhdtdLNtmOSrCVflJzz055J657DoMVSuQrd
TSM2kfaordZLF3kJUFVjIDDAwT2OSABUVzd6TazTQMtu1xExRoViTfkR+Z09
Md6ow6ZodtcWk8RRJLOR5LdldQYy3DcgZbIyPmzwTV66lsbpJVeZR5khlJWQ
ZDGPy8j/AIDQIdK9lBp095NaBBbtski+zKzhjjC4AOSdy4xnrUhGliETNNYJ
GVDbmEYwDjGc/wC8v/fQ9ap3A027s2tbqQTxvKJpS8uDI4GATjHTA4GOgqpF
Z6ZbMht7mSPywBEFlBEeNoBGQeyKOc8D3NAaGjbzaXcpE6SWSiXHlBhEC+QC
MDr0YfmPWoLm80y1luIpVjEkEscTqLYH5n+7jjnv9MVVFtpaKFEjFMKHUy58
wKEwD/3wp4x09zUsx06e7e6faZX3ZPmf3ggP6IP19admJst79KMiRrd6aXdz
GqgxZZhjKgevI49xTPM0o7cXum/McLhouayrey0q1geFCSjuGPzgdNvoB/cX
nr71S/sqyjV4IbnZaTNuuYcD96QSRyMBRkngD+mBJ9R6HQqtlOStvNZTPt3b
YxGxxkjPHbII/A1QuSYmx5cP/flP8KfbXVvZK3ksmWQITtVcgFiOFAH8R7VU
uLkSkncPzqku5D8gS5If5o4SP+uK/wCFWhIpGfKg/wC/Kf4Vllh6irFvOMbW
YD8arQV2Xgw/55Qf9+V/wpQy/wDPGD/vyv8AhUAlj/56L+dPEsf/AD0X86Wg
ak2V/wCeMH/flf8ACg7ccRQf9+V/wqMSx/8APRP++hR50X/PRP8AvoUaBqRs
5B/1cP8A35X/AApvmn/nnD/35T/CnyPEw/1if99CoN6f31/OnoLUk80/884f
+/Kf4Uvmn/nnD/35T/Cot6f3l/Ojen99fzo0DUmEv/TOH/vyv+FHmf8ATOH/
AL8r/hUW9P76/nS+Yn99fzo0DUc0hB/1cP8A35X/AApvmn/nnD/35X/CguhH
31/Ooyy/3l/OjQNR/nN/ch/78r/hQZm/uQ/9+V/wqPcv94fnSbl/vD86NB6k
nnN/ch/78r/hVKa7lW5CgRY/64p/hVncv94fnVCbm6U9qFa4nc6TRisw/eRQ
N9YV/wAK3ooLYnDWtuf+2K/4Vz2iSxp96RV+pxW4LmAHPnR/99CtLRJuy6LO
0I/49Lb/AL8r/hS/Y7T/AJ9Lb/vyv+FRRXtuRgzxD/gYqX7Zbf8APxD/AN9i
laIXYfY7T/n0tv8Avyv+FH2O0/59Lf8A78r/AIUfbLb/AJ+If++xR9stv+fi
H/vsUWQXYfY7T/n0t/8Avyv+FH2O0/59Lf8A78r/AIUfbLb/AJ+If++xR9st
v+fiH/vsUWQXYn2O0/59Lf8A78r/AIVHJZ22Mi1t/wDvyv8AhUv2y2/5+If+
+xSG7tj/AMvEX/fYotELsq/Z7cH/AI9rf/vyv+FKLe2/59bf/vyv+FLJcW4O
RPF/32KZ9qg/57x/99ii0QuyQW1t/wA+tv8A9+V/wpwtbX/n1t/+/K/4VF9q
g/57xf8AfYpwu7f/AJ7xf99ii0QuyUWtr/z6W/8A35X/AAp32S0/59Lb/vyv
+FRi7t/+e8X/AH2KcLu2/wCfiL/vsUrId2PFnaf8+lt/35X/AApws7P/AJ87
b/vyv+FM+2W3/PxF/wB9ilF5bf8APxF/32KVkO7H/YrP/nztv+/K/wCFVbmG
xtrqF3srcqY5BgQr6p7VZF7bf8/MP/fYqOeSyuAu66jUqcqyyLkfnwfxpNIp
NlBtW0dIvNNhbeXwcgRE8/7Od34YzUbXNhHNeOtlb5OwLmFcDjntV3y7T/oI
j/vqP/4mmrb2SuzjUBufGfmj7fhU8pXMRR3NiHG6ztyNwGDGhzwfRR0wPzrm
bzX7S0vZoVs49okfGIFP8be1dd5dp/0ER/31H/8AE1RfRdJkkZ3vssxJPzx9
Scn+H1NY1acpL3GdOGrU4SvUV0YMGs29zHcybYojGuY0MUSmQ4PyjcM57559
MZxmufE9sqDNrGTjqLdef0rp/wCxdI/5/v8Ax+P/AOJpp0PR263v/j8f/wAT
WLo1mlqdUcVhlKTcb3202OU8QC3Phyw1OBPJmlnljYoAuV3vwR+FFaHj23gt
vDlhFa48lbg7cNuzkMTz9SaK9KnRTgrnzWKxM41pKLsjofDv37X/AK9W/wDa
ddJXNeHfv2v/AF6t/wC066C4ZliG1ipLquRjgFgD1rje560diWioNv8A09Sf
kv8AhRt/6epPyX/CkMnoqDb/ANPUn5L/AIUbf+nqT8l/woAnoqDb/wBPUn5L
/hRt/wCnqT8l/wAKAJ6Kg2/9PUn5L/hRt/6epPyX/CgCeioNv/T1J+S/4VTs
JZZ3vBLdyYiuDGmAg+Xap9Pc0AadFZkt8kblFmuHYHGQEA/lUX9rQLC0j3Uo
KKruimNigYZGRjI/Ks1VhK9ntv5FOMla63NiiqUM6TqjLdTDeNy7lUcYz/d9
Km2/9PUn5L/hWhJPRUG3/p6k/Jf8KNv/AE9Sfkv+FAE9FQbf+nqT8l/wqazt
IpLG3kdpWZo1JPmtySPrQAtFS/YYP+mv/f5/8aRrO2RSzGRVAySZmAA/OgCO
iqthc2GpTypbJdNHGMifzG8t/wDdO7n8qv8A2GD/AKa/9/n/AMaAIqKl+wwf
9Nf+/wA/+NH2GD/pr/3+f/GgCKipfsMH/TX/AL/P/jR9hg/6a/8Af5/8aAIq
KitSWtIWYkkxqST34qWgAooooAKKKKACiiigAooooAKKKKACiiigAooooAKK
KKACiiigAooooAKKKKACiiigAooooAKKKKAPPviB/wAgK2/6/ZP5vRR8QP8A
kBW3/X7J/N6K9Oj/AA0eBi/40v66G54d+/a/9erf+063rz/j3/4Gn/oQrB8O
/ftf+vVv/adbt5/x7/8AA0/9CFea9z3lsc3qWt/2fMYVtJriQRiQ7CoAGSO5
9jXI3fxDvxcGG2sYlcDO2XJbH0BFdbf6bJcXTXMbjcYRHsPHQk9fxrg38Mat
LrOpZ0kuJoI0huGlCiIjcTgZ5znFIZYHxG1WDc9zaWbxrjd5LHI/8eNdL4T8
aWniz7UttBPDJasFkEmMEkdsGuStPhnqEltJHd31tD5mzPlhpCNox3xXW+E/
CFr4UhnEM7zzTkGSRlC5wPQUDN6K9tp5HjhuYpHRijqkgJVh1BA6Hg/lUizI
7siyKzL1UHJHUf0P5Vzd/wCG7m4le5iu4jNvJSN4ysbIZGfa+Cc/exn26c1A
fCEsunxwvexLN5SpJIISTkFiNrbgQAW/8dH0ofkI6U6haKIS93CvnjMQZwC4
9s9eoqfzAHCbxvIJC55I9f1FYdz4fa4tIrYXQVBDHDKfKyWCEEFTn5Tke/6V
QufC17M1q5vreaSKQbzLbnBj2oMY3c/cyRnBz2xyAdW0iqyqzgFjhQT1PXiq
1iTuvf8Ar6P/AKAlZVr4fnhmtnmvkuRbOrR+bAS2BvzyW+984+b/AGeladif
mvP+vk/+gJTEVpLjbPIuejn+dZE0GnQXF/do9z9tuoYYZA7Dy8pGp+UDnOCM
59OPd17cbL6cZ6OaqSSi4uZ4IYla4YRKeCNo8tcPnp83Tj+6B/DXiYV3+sr1
/wDbjuq6ez/rsa2hx28N1M0V5dTPPIXKSkbE2LsYJ7BgRz7dua2ri7gtIxJc
3EcKE7Q0jhQT6ZP0rKs7N7BvtcnklH5JRcEcc4P4Enpzk1a1OzfU7SNIZxCw
besm1iRlSOMMvPP09q9ttPZnCjRyfWokuI5JpYUkBkixvUdVyMiuat/CtxHP
HcvqOJVTARFbYr7QNwG7Bbg5JBzk8VDF4KMZkzqAdJD80TRvsIzkD/WZwPr2
HpSGdhk+tbmm/wDILtP+uKf+giuJtND+yXkE6XGfL37gVJL7iT1LHHUe52jm
u103/kF2n/XFP/QRQBNcXEVrbvPO4SJBlmPasmO3udbdpb1Zbew48u0PytKO
5kx29FB6dfSsq68Q2V9fxb2draCZlNuBlpmBG1j2wDzgmuklv0Wye4RSSuAF
bg5JwP507CuWUjSJAkaKijoqjAFVNQ1ex0pVa9nEQZXYZUnIUZPQdcdup7Vj
W+rXcM0Mk1158EnJHlgYGcZ456/yrZ1DSbPVEC3kQkAUque2cHI9+BzUxlGW
sXdDs1o1YZDrukzhDHqVrl/uq0oVjxnoeegJqOTxJosag/2rZNkqMLOhPJwD
16Z71Db+GLC3iMKmZrfLN5LMMbmQoTnG7O0464qta+DrODUZbqSeWdWmSdI3
CjbKufnJA5J3NxwBnp0qtLh0NNte0dV3Nq1iBxyblO4yO/cDNWre7trvf9mu
Ipth2v5bhtp9DjpWSnhTTUVUxK0caMkaFhiMMCGxxnnOec+2BxV3S9ItdISR
LVQquQcbEBAHQZABOPViT70gIrP/AI8oP+ua/wAqmqGz/wCPKD/rmv8AKpqA
CiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAK
KKKACiiigAooooA8++IH/ICtv+v2T+b0UfED/kBW3/X7J/N6K9Sj/DR4GL/j
S/robvh371r/ANerf+062r+RI7XLuqjenJOP4hWN4e+9af8AXq3/ALTrof8A
l6tv+uh/9AavMPeRg/a7f/ntH/30KPtdv/z2j/76FdWzEMqjq3euF8Qy+LbX
xFNcaXFcyWoVlRU+dD+7XkqemDvIIyS2AcDmkMv/AGu3/wCe0f8A30KPtdv/
AM9o/wDvoVnvqnjYMm2zJPmRhgLcbcbARyTnDPkMf4AOM1V1G78ctexokc/l
/wCkPshgAUgeeEVnBBHSEj1zninbWwr6XNr7Xb/89o/++hR9rt/+e0f/AH0K
wta17xlpWlzyGMh2nbyHW2V2AzKFjCk/NnZGc9fn6Vr6wPFltqtxNprPPC9s
txHGcbEkVdjR47537wPWP3pPQa1Jvtdv/wA9o/8AvoUfa7f/AJ7R/wDfQrAO
p+Pbee8mWyuZllWFYFMA4PGWK5+XKhiw5wxAq2t/49hjmd4BPvtWdV8gIYn+
TgYzuIBfAPWh6AjU+12//PaP/voVWs7mBTd5lQZuCR8w6bErrbBrqTTrV7na
tw0KGUbMYfAzxnjntVjD/wB5f++f/r0xHm9/pUNzPLPFfxqznO1sYz9c09bI
MkW69gjdAmdnzElenJI4z7V6Lh/7y/8AfP8A9ejD/wB5f++f/r1jToU6cpSg
rOW5cpykkpdDgpD5zuklwnlsMH5xgZ6kc9T/AFNaC3NsiBVljCqMAbhXW4f+
8v8A3z/9ejD/AN5f++f/AK9XCEYJqPVt/eKUnJ3focn9rt/+e0f/AH0KPtdv
/wA9o/8AvoV1mH/vL/3z/wDXow/95f8Avn/69UI5P7Xb/wDPaP8A76FdJphB
0qzI6GBP/QRVjD/3l/75/wDr0Yf+8v8A3z/9egDGl8KaTJdG5WGSKUtuJjlY
DP0zgfhV86bCbOS2LSMH5LO5JyOQfwOKtYf+8v8A3z/9ejD/AN5f++f/AK9O
4rIw7fw6Y7zzZplePcGKhfvEdPoM845zW9TcP/eX/vn/AOvRh/7y/wDfP/16
iMYwXLFWX+eo223djqKbh/7y/wDfP/16MP8A3l/75/8Ar1QDqKbh/wC8v/fP
/wBejD/3l/75/wDr0AY9pd2ws4AbiIERr/GPSpvtlt/z8Q/99itLD/3l/wC+
f/r0Yf8AvL/3z/8AXoAzftlt/wA/EP8A32KPtlt/z8Q/99itLD/3l/75/wDr
0Yf+8v8A3z/9egDN+2W3/PxD/wB9ij7Zbf8APxD/AN9itLD/AN5f++f/AK9G
H/vL/wB8/wD16AM37Zbf8/EP/fYo+2W3/PxD/wB9itE7h1dfy/8Ar0Zb++n5
f/XoAzvtlt/z8Q/99ij7Zbf8/EP/AH2K0RuPR1/L/wCvRlv76fl/9egDO+2W
3/PxD/32KPtlt/z8Q/8AfYrRy399Py/+vQGYEZIIJxwKAM77Zbf8/EP/AH2K
Ptlt/wA/EP8A32K1KKAMv7Zbf8/EP/fYo+2W3/PxD/32K1KKAMv7Zbf8/EP/
AH2KPtlt/wA/EP8A32K1KKAMv7Zbf8/EP/fYo+2W3/PxD/32K1KKAM6OWOUE
xyK4HUqc0+qupki6OCR8ifzeqW9v7x/OtY0uZXuS3Y16KyN7f3j+dG9v7x/O
q9h5hzGvRWRvb+8fzo3t/eP50ew8w5jXorI3t/eP51Um1HydQgtGEh82N5d4
6AKVGPqd4x9DUypqEXJvRDTu7I6KisSa480hYkaME8nzCSf8K0bEko+STzXL
Qr066lKk7pFyi46M4j4gf8gG2/6/ZP5vRUHj67ibSYYQfnS8kz/309FexR/h
o+exf8aX9dDpvD/3rP8A69W/9p10H/L1bf8AXQ/+gNWDoIwbL/r0b/2nW9/y
9W3/AF0P/oDV5h75cf8A10X4/wAqRZ1a6e3AO9EVye2CSB/6CaV/9dF+P8qa
1pE12t0Q4lVduVkYAjnqAcHqeoOM0xCzzrAgZldsnGEGTVC91ICwuCsNyrCJ
sHZjBwa1KiuIvPtpYc48xCufTIxSGYFtcRQDTpEiO92CyGNPmf8AdsefXkA1
sDUUJA8i45/6Z1RstKuoLi2Mhi8uA5yrklvlK9Nox97PWtqgClqepw6VbpNO
rMrvsGGRecE8l2AHT1qzBMtxbxTqGCyIHAYYIBGeR60SwRThRLGrhTkBhkdC
P5E/nSxRJDEkUYwiKFUZzgCgB9FFFABVIanGekFwRnr5dXaKAKX9pJ/z73P/
AH7o/tJP+fe5/wC/dXaKAKX9pJ/z73P/AH7o/tJP+fe5/wC/dXaKAKX9pJ/z
73P/AH7o/tJP+fe5/wC/dXaKAKX9pJ/z73P/AH7o/tJP+fe5/wC/dXaKAKX9
pJ/z73P/AH7o/tJP+fe5/wC/dXaKAKX9pJ/z73P/AH7o/tJP+fe5/wC/dXaK
AKX9pJ/z73P/AH7o/tJP+fe5/wC/dXaKAKX9pJ/z73P/AH7o/tJP+fe5/wC/
dXaKAKX9pJ/z73P/AH7qreXscxt42glCNIdwkj+UgIx5/ECteqmoW0lzCgiK
70bcAxwDwR1wcdfSgChYXscEt1GsMnlhwVEcfA+UVqwTidCwR0wcYdcGqul2
c1os5m2bpHDAIxbAwB1IHpV+gDK1XyBdRSXCK6RwSuQyg9NpOM+1cvp/ivRt
Us3uLSztyFm8vDhRkdumcE5HrXSayrm5t9sbupjkVisZYc7eDgHrzXMxeFtM
t7GWztbO6topblrlhBG6YZjkqMJwvbHUDjNb0nSs/aLUiSk3ozqdK+ztdzPb
IixvDGw2KBnlvSsbX7j7Pe5EKOzXYViybjsCKcfTk1raMri6uS0TouxAMxlB
1bgZA9qr3yyC+uR5UpDOGBEbMCNqjqAfQ1imk7lNXRyEXiZbhLhVtbXeMPGF
hHAB5/DFd/pyohnWJVWMT/KqjAH7tTx+JNcLoPhu50m/luJELh8hMRSkoPQZ
X613GkhvKdmRl3TZAdSpICAZweeoNb4j2fPalsZ0lLl9/c06Kp3ePPQu7Kio
zHDlR1HWmhY2UMrsVPQiVsH9a5zUvUVQUROzKshLL94CU5H60KInZlWQsVOG
AlJx9eaAL9FUMRc/O3y9f3rcfrQixSKGR2ZT0KysR/OgC/RVIRoc4Z+Ov7xv
8adbDbcyAMxGxTgsT3PrQBS1T/j6P+4n82rNeWON0R5EVnOEBYAt9PWtLVP+
Po/7ifzeuQ1zw9Pq2qWl8lysTWW1oF25+beC+TjIBVQvGOpzxXVT+Ah7m19s
tcZ+0w4C7vvjpnGfpnile5gjjeR5o1SPh2ZgAvTqe3UfnXAL8Nbnz5UOpqLS
e3EUqKnzL+8Mh254wWweR1LVs2PhvUbWBUknt53juIbkMzMPMZIEhwwxxnbu
zzzjirTfVCaOmN1bq0QM8QM3+qBcfP8AT1/Cpa5Cx8I32n3xuINR4mljklUZ
AQKzExqOcod/A4xgHnpXX01drUAqpeWRup7WVZTGYJCxx/GMfd/PB/CrdFTU
pxqQcJbMcZOLuhoQD61oWH3H+tUavWH3H+tY+xp0aXJTVkPmcndnk3jjPmT8
/wDL2/8A6FJRTvHI/wBafW8f/wBCkorsofw0eFjP40v66Homh9LA+tm3/tOt
z/l6tv8Arof/AEBqwtCcMmnY/wCfNv8A2nW7/wAvVt/10P8A6A1eae+XXIyF
wCW7HpXI6rdeJotenNjaqdMgaEHMG4yBiobYAMkjJJPQCutf/XRfj/KlEqGZ
oQ37xVDEY6AkgfyNAHnTeM/EMkU9svh2SK8aGeS3LWzhsRpuDGPk/MWVQO5D
dcYFr/hKvECS2cX/AAjk8iy5WWb7FKqx/MwEmOpGFzswD0weRXdySpEoZzgE
46ZqpeX8cdlO8bsHWNip2Hrj6UCOag1PxFeWGtxpY+ReWrMbJ5LNlW5UNkEb
uBkDbtzu79xWdfeJfFSWE32bw/N5zKkkTfZHJ2vl+RjAKDCFT82TnjBFdNbX
nl/YJDNITMwWXLs2f3bN05xyB0rXF5ATgM3/AHw3+FAzh38WeJGldIfC0mIx
HkvbS4YnYHA452lmORkYU/WtbQNa1jVNRMN/oBsbcWiyeZIrAtIduQMjGOW4
6jb78dDd3kNlGrzGTDNtURxtIScE9FBPQGpYpUnhSaJg0cihlYdweQaYCbP+
mUf5/wD1qNn/AEyj/P8A+tUlFICPZ/0yj/P/AOtRs/6ZR/n/APWqSq4vrcjI
ckeoQ/4UASbP+mUf5/8A1qNn/TKP8/8A61M+2wf3m/74b/Cj7bB/eb/vhv8A
CgB+z/plH+f/ANajZ/0yj/P/AOtTPtsH95v++G/wo+2wf3m/74b/AAoAfs/6
ZR/n/wDWo2f9Mo/z/wDrUz7bB/eb/vhv8KPtsH95v++G/wAKAH7P+mUf5/8A
1qNn/TKP8/8A61M+2wf3m/74b/Cj7bB/eb/vhv8ACgB+z/plH+f/ANajZ/0y
j/P/AOtTPtsH95v++G/wo+2wf3m/74b/AAoAfs/6ZR/n/wDWo2f9Mo/z/wDr
Uz7bB/eb/vhv8KPtsH95v++G/wAKAH7P+mUf5/8A1qNn/TKP8/8A61M+2wf3
m/74b/Cj7bB/eb/vhv8ACgB+z/plH+f/ANajZ/0yj/P/AOtTPtsH95v++G/w
o+2wf3m/74b/AAoAfs/6ZR/n/wDWo2f9Mo/z/wDrUz7bB/eb/vhv8Kq3l5G3
kRrI4DyENgMpwFY9fqBQBd2f9Mo/z/8ArUbP+mUf5/8A1qz7G8RZLmN5HZUc
bM7nIBUd+e+a0Y5UlUshJAOOQR/OgBNn/TKP8/8A61Gz/plH+f8A9asbXIYL
m/tYbpmFuIZpWAcryuznjngE1h6W3hjV0drV2bEpjUefJl/TAznkc49j6GtV
T9znd7en/BMuaTlyxX4/8A7XZ/0yj/P/AOtRs/6ZR/n/APWrI0a3is9SvLa3
3CERROFLlsMS4PJ+gpl3bWk91eTXahvKbaCWICqEU9B7k1ElZ2RUHzK7NrZ/
0yj/AD/+tQPlYDYozxkV55oWoWGpak1tNbwgNkx7XbPHbrXa6ZGkKywxAiKO
fCDJOAUB7+5NVUpypvlkghNTV4kt7F5zhMgZQ4JzxyvoRWcNIdrhppboyElT
gpgDBB7H2/WtmW3jmdXbduUEAqxHX6U37LH/AHpf+/jf41mWZVxpT3Gf9ICD
LEbY+cFt2Cc8/pUT6GSytFdGM7mZjtzuJJPr9Pyra+yx/wB6X/v43+NH2WP+
9L/38b/GgDKGlHdI7TBndXUtsPG7Hv2xSPpLyXHmtc4zklUTaOQB6+1a32WP
+9L/AN/G/wAaPssf96X/AL+N/jQBkyaS8gfNycsDyVPBOM4574rQso/Kfyy2
7ZEi5PfGam+yx/3pf+/jf406OBInZ13bmABLMTwPr9aAMzU/+Po/7ifzeuW1
TXG07VI7ciLyvLEjbiMnJI45zxjPCt74HNdVqf8Ax9N/uJ/N6o4rqp/CiHuc
mPG0ctrFPFaZDKHbMo4zN5WAOp7nPQcZqzqHiOeyuAVt0kgW1SdwMnG7fj94
Pl6qo6c7s10eKXFWI5RvGsS2kl0bCXyVgSVX3j5iwjO3HUY80c47Gt3TL06h
ZC4Mfl5dlC+gBIq6cDqcUAg9CDTASilpcUANq9Y/cf61Sq7Zfcf61nV+Ea3P
LPHa4tmb1vZP/Q5KKm8fLjTFb1v5f/Q5KK6KH8NHh4z+PL+uh0XgvWLTVJ4Y
rZmZrW2eKXKkYbMY/oa7P/l6tv8Arof/AEBq8p+Ep/4muqD3k/8AQlr1b/l6
tv8Arof/AEBq8+Ssz3Yu6Lj/AOui/H+VRta5vhdLNIh2BHjG3a4GcZyM8bj0
IqK8eQ3lpAkhRZN+5lAzwM8ZrOk1nSorv7LJrUqTb3QhgAAVxnJ24HUcnrzj
oaQzeqK6iM9pNCpALxsoP1GKyzqWljGfEMIycD/SYuuAfT0I/MVGmsaTJK0a
+IIyQgfd9oiwRz0OOfumkMi02x1CO8tRPaiOKAkmTzFOfkZRwOe9dFWMNS0s
lgPEMOVUMf8ASYuAcYPTpyPzFVL/AMR6Pp01xDcazcCW3jWSRQmcK2NvO3HO
R370AbV/ptpqkAgvYEnhB3GNxkHgjn8zU8UflQpHvZ9qgbnOSfc+9YdprWmX
cLyDWvKCFgRJcQg8HaTxnjPGams9R07UJ3gtNb82VHaNo1kTduHXAxz9RxTA
2aKwr2+k095PNv7WKEOEV7uTYSdobGRgev5GlmvL6AIZJbUeYwRAN5LE+gH5
/QE0gNyisOe7vbaIyzz2ccYIBZmcAZ49aadQuVu1tGu9PFyy7lhMjbyOeQuc
44P5GgDeorI8zU/71r+b/wCNNafUFZVaW0BY4UFn5OM8c+gNAGzRVWydri1j
kk4ZlBIVjjJFWNg9W/76NADqKbsHq3/fRo2D1b/vo0AOopuwerf99GjYPVv+
+jQA6im7B6t/30aNg9W/76NADqKbsHq3/fRo2D1b/vo0AOopuwerf99GjYPV
v++jQA6im7B6t/30aNg9W/76NADqo6rDNLbIbePzJEfcE3AZ4I6n61c2D1b/
AL6NGwerf99GgDN0W3uoY7hrqHymeQELuDcbQO1alN2D1b/vo0bB6t/30aAM
DxE6xX1o8q5haGaNzg4+bZxx6gGuX0LStB8O20tvYITHJM0wEuW2ZIIVT1wM
DnrxXoxjU9c/99Gjyk9D/wB9GtVU9zkexnyyUuaLMLw/L9o1K+nXJQxxKGxg
EguSP1H51HqEix3t0jsq7nyA7BcjYo4z7g10IjUdM/8AfRo8pff/AL6NRJ3d
yoRcVY8o8N6XdafqrT3UUKRgERN9tR9gPbAAz35r0bSDuikccq03BHQ4jUcf
iDWj5Seh/wC+jShFU5A/M5q61Z1Z88v6+8UIKCsh1FFFZFhRRRQAUUUUAFFF
FAGRqX/H03+4n83qniruo/8AH23+4n83qniuqn8JD3ExSHgE+lOxQRkEetWI
5PXdfe1ZI7dEklYnO/OFA+lUtN8SXAvIxMiKrHa23OOe49Ki13SLyG+eRYZJ
ImYlWQbsZ5waZo2iXd3fRtJBJHAh3Mzjbn0ArZRgo3uY3k2d+OlLilxgUYrE
2ExVyz+431qpirdp9xvrWdX4Rrc8o8danbTJJpyMftMF5I7jBwAWkxzRWJ4u
H/FWar/12/8AZnorqo/w0eHi3++l/XQ6f4VKF1bUiO4f/wBCWvUv+Xq2/wCu
h/8AQGrzP4XxeXqV8f7wc/8Ajy16Z/y9W3/XQ/8AoDVwVPiPch8I66/5Cth/
20/9Bqne+FdJv5TLLAwlJYs6Ngtkk8+uMnFXLr/kK2H/AG0/9Bq9UXLMO98L
2l/A6Tz3DSPuLyfLlydnUAAceWh4x0+tNg8JafDAqs0zzAxsZyQGLIpVGwBj
gHpjHAznnO9RSuBhSeEtMkjAZXLh2k8xgrEu2NzEMCpzt9Mc8AcYWXwrp011
NOwYGaNI3VVQDCY24O3K9BwCB7VuUULTYDCk8J6Y15Ldorx3EhDNIApbcG3A
gsCRgnoOD3Bqe18P2tpqLXqSzmVmZ2BYYZj1JwAfU4zjnpWtRQBzWt2l5cXZ
EAZQJA4YwmRWBjKEY/E/4Vz8fhExrINs7kuXjeWF5GU7WUE7iRxu4wB0Htj0
WigDzb/hELhrRbR7i8NspdvL8lj97HHJPygAYH15rSm0aebe5W5R2iSPbGjr
FhSTgxg4IOSCD27129FFwPPm8LyvAyM13uOTuWJhtzt4UdgApAHYMRUljoFz
Z3CTM1xM6TecC8BPO1lz/vYYcj0HFd7RQBn2MwhtI0kjmDBFBHkv1x9Ks/a4
/wC7N/34f/Cp6KAIPtcf92b/AL8P/hR9rj/uzf8Afh/8KnooAg+1x/3Zv+/D
/wCFH2uP+7N/34f/AAqeigCD7XH/AHZv+/D/AOFH2uP+7N/34f8AwqeigCD7
XH/dm/78P/hR9rj/ALs3/fh/8KnooAg+1x/3Zv8Avw/+FH2uP+7N/wB+H/wq
eigCD7XH/dm/78P/AIUfa4/7s3/fh/8ACp6KAIPtcf8Adm/78P8A4Ufa4/7s
3/fh/wDCp6KAIPtcf92b/vw/+FH2uP8Auzf9+H/wqeigCD7XH/dm/wC/D/4U
fa4/7s3/AH4f/Cp6KAIPtcf92b/vw/8AhR9rj/uzf9+H/wAKnooAg+1x/wB2
b/vw/wDhR9rj/uzf9+H/AMKnooAg+1x/3Zv+/D/4Ufa4/wC7N/34f/Cp6KAI
Ptcf92b/AL8P/hR9rj/uzf8Afh/8KnooAg+1x/3Zv+/D/wCFH2uP+7N/34f/
AAqeigCD7XH/AHZv+/D/AOFOiuI5nZF3hlAJDIy8HOOo9jUtQJ/x/wA3/XJP
5vQBR1D/AI+2/wBxP5vVTFXL/wD4+2/65p/N6q4rpp/CQ9xuKMU7FI3yqT6C
rERu8affIH1ojkjfhGU47CuQ8Qa5PC6Q2j7JGJLSEA4AOMAGqGm67eJdRmZ9
53AMQANwPrisvaq5DqLoeg4oxSjkA0uK1LG4q1a/db61XxVm2+631qKnwjW5
4V4uI/4SzVR/02/9meimeLf+Rw1f/rqP/Qnorqo/w0eFi/40v66HZfDGUSan
fAfwq4/8eSvS/wDl6tv+uh/9AavJ/hIrjWNULHg78f8AfS16x/y9W3/XQ/8A
oDV59T4j3YfCOuv+QrYf9tP/AEGr1Ubr/kK2H/bT/wBBq7moLFopM0ZoAWik
zRmgBaKTNGaAFopM0ZoAWikzRmgBaKTNGaAFopM0ZoAWikzRmgBaKTNGaAFo
pM0ZoAWikzRmgBaKTNV728Wyg8xkZ8nAC+tAFmisX/hIVHW1f/voU3/hJIx1
tpP++hRYDcorCPieAdbeT8xXI6h48urPUngFheSjIIaNzjn8KdmK56XRXK6d
4rQ6fDLdQTI8oLBWOSBkjn8qsnxfYjrHLRZhc6GiudPjLTx1SX8qtab4jstT
uvs0IcSbSw3D0oswubFFJmjNIYtFJmjNAC0UmaM0ALRSZozQAtFJmjNAC1An
/H/N/wBck/m9TZqFP+P+b/rkn83oAp33/H2//XNP5vVbFWb3/j7f/rmn83qD
FdFP4SWNxSEZBBp+KMVYjitb8NXcl001siyozEhd2CuetJo/he6F4k14ixxI
c7d2Sx7dK7GSZIzg5J9BSRXEcpKg4YdjWXJG9yFTincfilxTsUYrUsbirFv9
1vrUOKng+6frUVPhGjwXxb/yOGr/APXUf+hPRR4t/wCRw1f/AK6j/wBCeiuu
l8CPCxf8aX9dDr/hcoXU7/3D/wDoSV6d/wAvVt/10P8A6A1eV/CiUyavqYPb
eP8Ax5a9U/5erb/rof8A0Bq8+p8R7kNhbv8A5Clh/wBtP/Qau1Su/wDkKWH/
AG0/9Bq5UljLidbaB5n+6ozVCDWBJdRQSQmPzhmNt2c1curdbq2kgfhXGKxt
P8M/Y9QS6kvJJhHny0botaQUOV825Eua6tsXrnXbK01GWxmaRZorX7UfkO0p
lhgHu3yk464qYatYNIY0vLdnU4dBKuU4J5GeOh/I1T1bw9a6xHdLNNcRNcQr
D5kLBWjCliCpIOD87A+xxTU8N2y3Ecxubl/KeR4kcoVTeWLAfLyCW756Csyz
Ri1CynlSOG8t5JHXeqpKCWX1AB5HvVW212zuZbpcvClvKYjLOAiOw3bgpJ5x
tOfpVfT/AAxYadqP2+Iu8+wIWkVDwM4x8uVwGIwuBjAxxUV94Utr9pnkvr1H
lbJePywQMOuPucjEjDJyenNAGi2uaQm/dqtkPLfY+bhPlbJGDzwcgjHtT21b
TVRnbULQKqqzEzLgBvuk89DkY9a56XwbJIIWGpTCSK/N0h+UiNDIXKr8vU/L
1yOK0X8L2Emn/Y3aVo98b5cI5yiBBkMpByBzkdz0oYdDTbUrFZfKa9txJv8A
L2GVc7/7uM9faol1rTSm57+1Q7BIVadMqpxgnB6cjn3qtL4ftpbpp/OlRjKk
u1FjABX0+XIz0JzkjAzgCqkfg+wjkgbz7phAVaNWZcBgqLn7vUiNR6dcYzQv
MDfhniuYVmglSWJhlXRgyn6EU+q9rapaQtFGWKmR5Pm65dyx/VjU9AC0UlFA
C0UlFAC0UlFAC0UlFAC0UlFAC1Q1hN1iT/dYGr1V75d9jOP9gmgDho0Yz3Ik
d2Pm5X5zwCowKk8lP9r/AL7P+NID/psw9UQ/j8w/oKV3xXpUYpwWh4uIlJVW
rjWiiHY/99H/ABqIpF/dP/fR/wAaY8tQNNW6pLsZKUu5YMcB6pn/AIEf8aUQ
Wx/5ZD8zVTzqes1V7Jdh80u5aFpaEZMK/mad4CTfqRkJzttup9SRVO5ufKsp
nz0Q4rX8AxAPeuOihEH6/wCFcWKSjsduCu7ts7eikorhPRFopKKAFopKKAFo
pKKAFopKKAFqGP8A4/5v+uSfzepaij/4/wCb/rkn83oAq3n/AB+P/wBc0/m9
QYqxdf8AH4//AFzT+b1FitobEsZikfhGI7CpMUmARiqEcLrNzNc3Yh3vHEgz
8rEbj7/SmWN3PbyRgSM4DgLuOTg9RW9qOgSzzGW2kT5jkrIOB9MUmm+HXgul
uLuRHKfdjQcA+vNZ2dzp5qajpubwHFGKfijFaHMMxU0PQ0zFSRdDUz2Gjwbx
cP8AirdW/wCu3/sz0UeLj/xV2rf9dv8A2Z6K7KP8NHhYv+NL+uh03wnx/a2p
4/2//Qlr1X/l6tv+uh/9AavKvhOMavqf/A//AEJa9V/5erb/AK6H/wBAavOn
ue5DYW8/5Clh/wBtP/Qat5qpef8AITsP+2n/AKDVqhFDXmWM4Ic/7qE/yFN+
0p/dl/79N/hUlGQe9AEf2lP7sv8A36b/AAo+0p/dl/79N/hUlFAEf2lP7sv/
AH6b/Cj7Sn92X/v03+FSUUAR/aU/uy/9+m/wo+0p/dl/79N/hUlFAEf2lP7s
v/fpv8KPtKf3Zf8Av03+FSUUAR/aU/uy/wDfpv8ACj7Sn92X/v03+FSUUAR/
aU/uy/8Afpv8KPtKf3Zf+/Tf4VJRQAiSCQZAYDp8ykfzp2aSigBc0ZpKKAFz
RmkooAXNGaSo55DDA8gQuVGQoOM0AS5psg3xsvqCK5zVNX1IWe6FrPTznmW4
fzBj0A4GaraRrN7IkiyazY3zjn5INpX8A1K4Ga7bL0/7UfP4H/7KoZXqW9Ux
38ZLq2VcZUYHOD6n0qnK1ephNaaPJxa/esikkqs8vvRK9UpJMV6MYmKRa86p
El96zPO5qaOTNU4DsWr992nyL/eKj/x4V23geDy9Ikm/56yfy4rgrl8xRD1f
+hP9K7vQZbi10CzSMxKGVnzIpOcsfQivHx2k7Hfg17p1OaM1wN1rt0uosD4s
giXd/qY7JWUc9Cxyf1rp7XUpppolMkEiv3RCMj1HJrgudhr5ozSUUwFzRmko
oAXNGaSigBc0ZpKKAFzUUX/H9N/1yT+b1JUcP/H9N/1yT+b0MCC5/wCPx/8A
rmn83rndZ8QS6TdvGtks0UVuLmVzNtYJv2nau05IGT1GeldHcf8AH5J/1zT+
b1m3ei6df30F7dWqS3EGPLds/Lg5HHQ8881cdgZz9t40+1XptxYxxqkjJJI8
5AX/AEhoF4CZyxQnnAGQM5qBfHUolkE2mQxxppsmobvtZJO1ygTGwclgOc96
338L6JI0bNp8RaOVpkPOQ5feT1/vc/WnR+GtGh8vZp8Q8tAideFEnmAf99jd
9aeoiloHiUa59nH2UQtJamaQCXeI3DlGTIAzgg89638VSj0TTYdQF/Haol0C
5EgJBy5y3fuav8HoaaAbijFPxRigBmKkj6Gm4p6dKmew0eCeLR/xV2rH/psP
/Qnoo8XH/irdWH/Tb/2Z6K7qP8NHgYv+NL+uh0nwmJ/tjVM/7f8A6Eter/8A
L1bf9dD/AOgNXlfwoGNX1L/gf/oS16p/y9W3/XQ/+gNXnS3PejsF7/yE7D/t
p/KrWaq3v/ISsP8Atp/IVZoQytqDypYTNCCZAvAFc5pd882sW8cEMynB+0Fg
cfr+FdWcEYNNWKNCSqKpPUgVrGajFqxMottO5kX9/qUGu26Q2k76eijz5I0B
yzEgDru44J2g9eahg1bVn+xbrbmVVMifZJV5Jwy7icJsHOW4btimeJtc1HSo
bh9PgtZPs0KSyfaGYZ3OVAGPoTTU8UvaxCPULGd7oySRoLOMOspR9p2jdnjI
649qzLs7XK7a34huLZRDYtDJJGw3NZyZVxCrDhiBjeWXnrx15NWtG1LVri9k
ivIGhi81trtazfvhgcjJxH+PBzx0NWr3XDZ3tiGgkFtcQmRyyAMrF4kUEFhj
mTng9Kjj8VWcp+W3uSpjEithMMSEIUfN1/eLycDrzR5h0sUrfU9aR7nzROf9
PeJWks5JBHDuk2kKqISMBBnc3XJ94/7W8RWdtBG1p55NushmNpIxVtr/ACMo
OScqozxjdyKltvGKtcSxXVlNE/2uS2hjXYxkKmMDnfgHMn09/W/a+JrS7v7a
0SC4U3K7o5GC7c+WJMcNnO1h2x70BZpk15cTrqcCNJdwwFAV+zweYJHzyrna
20AY5+XqeeOMPTtf8S3jI02liBBMVYPaSAtHmLGMt8p+eTnn7vsas3XjK2Fj
cSW0Fx50Sg4kjGFJYKN3zD+I449D6VaOuXCWdvOYFkaS8eApHgEqu/GNzAZ+
UdT60rhYy9Q1zxIGjhttMZ0milMkq28imFh0QdckdQ3Ru1U4NZ8Vx21nZpYz
tLLBI0txNauxjfEhXnIHVVGCO49a34vFdrO7rHZX7BVj+fygELSbNqBs43fv
F746806XxPbxOymyuywIACmM7m3ohA+fjDOOTgcHBPGS3Qd9CG31TV99urWr
EO53ZtpB5g3kE5JxFhcNhuucDFX9CvNQu7Nm1KARTrsPyxNGDuRWPDEngkr1
7Vmx+NLKSRYl0/UmmOw+WkIkYKy5DfKx49e/tXS0ybC5ozSUUALmjNJRQAua
M0lGRQBQ1vVY9F0e5v5MERLwv95icAfma8e/4WB4mZvnvwUJ5XyUwR6dK0/G
3ii51SefS0EQs4p8hlB3PtyOTnGM89PSuM8v2rmlU5tYnTCnZe8egeIXbUbe
3ljZGWMlijNgMCBzmszSPlujceZGu3+FGB/lUN1MtpDDY30oVmgjZhzwGUEA
+/NVReWtsm6GRpWYc47fXp+la3Rhyu9joX1azuQC17BDJFKRh2HOMjpkVE9/
Zt/zErT8x/8AFVwzqXdmPUnJpvl+1OGKqQVojnhKc3eR27COT7t5CfoP/r1E
LBrjIimDkddsef61y0N7dW5Gwq4HZ/8AGte18TvbjP2Vg56lGH9a61jZ20mY
fVUn8Jaew8tjvnwR1yuMfrUbSRQY3XUQ+v8A+ultdTn1KZ1SzUl3RMOcnk8n
64BrnbhZTcOsxJZWKkHtiiePqJaSuOOFjJ6o3nvIGK7rmEhTkYOP61q+HfEV
3dC5t7mffDBhYBtA2rzxwOe3WuI8v2q5p90bGVmAJVhggVxzxEqjvI6I4eMI
tRNmSCO3nNsLpChbOSpyM9iavajr93ollbJp1xsmB27yobgDnggj0rI+32Mp
MjrL5mOmOCfz/Wl8R2jQvYybxJDcWyzIR2znI+oxSk9NAhH3tT0bwD4ludf0
64W/lV7uCQZIULlCODge4NdfmvDPCWrvomvwSl9tvIwjnHbaeM/h1r3LIp05
XQqkbMXNGaSitDMXNGaSigBc0ZpKKAFzUcP/AB/Tf9ck/m9PpkH/AB/Tf9c0
/m9J7ARz/wDH7J/1zT+b0zFPm/4/ZP8Armn83pMVUdgG4ob5VJ9BT8U1l3KR
6jFUByOv+IDZlFjjEsjk4UnAUDvVLSvFEhukWWMIrNtYA5HPcVW8Q6TeRXzO
YZHi3HY6qW4PODio9D0O7vL6MtDIkKnc7upXp0AzWF5NnPeTZ6OORRinAYFG
K3OgbinCjFLUy2BHgXi7/kbtW/66j/0J6KPF3/I3at/12/8AZnorvo/w0eDi
/wCNL+uh03woz/a+p5/2/wD0Ja9V/wCXq2/66H/0Bq8s+FJ/4m+pfR//AEJa
9T/5erb/AK6H/wBAavOlue7HYL7/AJCVh/20/kKsZqtff8hKx/7afyFWM01s
MXNGaTNGaYGdeDSzcubxY3kdBEyOCwZeXA29D91iOOxrOOseHry5uLWa3hZY
AHdpoV2kswJAB53bgMjGdwHer+oaJaajO08xmWQxeVmOQrgZznHTPJGfRiOh
qlD4P0q3aRovOR3xllcDBDBwQAMDkDtj2oGi21zpN/YRyXFqskMjvbpHLb7y
drHI24JxmPPT+EE4xUEV74eNgkht4YLaSAsBLamNfLC8jlcfdXp6L6CrMmi2
0lhHaNJNsSYzbww3lixYndjI5Y8rg1nw6Fo+qxpNHPNPDHGYY+QAqlSMA4z9
1/XnjOSKBDI9V8LSeajWkMY85oCstltLuNmVClcsTlO3Ye1aFveaC99bw2xt
DcYPkGOMdkGQrAYyExkA5xjtiopfDml/bY7qQusn2o3CAyYHmnaTj1zsHHtV
az8LJZa1aXNu3k2lpvKReYXMjMgQscgbeAO5H05yIp2HWWr+H9StJJ1tAqSc
ustp8zjzGCkjB6uG2g8k5wM1NNqnhqaNbaaSylicmRY2jDKTjJPTGQCST2GS
e9TQeHrG2tGt4DKgITDB8lSkjSKRn0ZieeOxqFfCekpGsaRyKqiQAeYf402N
+Y/WiyFpcjvr3w9YXj2tzYxBmjTzH+yZTy8HblsYIHl9OcYHpxbsxoN1cv8A
ZIbJ5tiszJEuWUYKnOOQCF6dCB6U670O0vbjzpTLnyhEVDAAgBgD0znDt+dN
0vQLDSJXktI9pZAmSi5wMfxY3HpnBJFAuhDFP4cufIkjisnMhBjPkDPygBT0
4GHUA/7Yx94Zu2msWV/dNb2sjSMsYk3iNthBJHDYwTkHj2Poapp4Y02Oe3mV
G8yAAIWCvgBUX+IHHEacjB49zVuw0m201gbcyACPy9rNuyNxbvz1Lfn9MAGh
mjNJmjNAC5ozSZozQAuay/EV9/Z2gXlwGw4jKp/vHgfzrTzXEfELUALaDTlJ
yxErfTkCsqsuWDLpxvJHmjKzuXYkknJJq1pWmvqeqW9mgyZXx+HU/pSbK3fC
KN/bo8rH2gwyCHP9/af6Zrniuh1SelzH12db7Xb24XBjaUiP/cHC/oBWd5dW
bqG50+Vlvrd4VJIV2U4Pt9afDZ3rqXe0lRW5QFDnHqannTdupvLDThDnfw9H
39O/n26lPy6Ty/atD7Dcf88JP++DTv7NuvIaf7O/lqcM2OlXYwuZvl0nl+1b
ek6NJqlxsBCRKRvf0+lej6X4Y0aOMKbGGQ92lXeT+dJO7sD0Vzye33R2U5Qs
rB0IIOCOtVihYknJJOSTXrmt+E9NmtZUtYUtpGAw8YwOPbpXnU2j3UWotYrH
5kwPG3oR60+thJ31Mny/ajy60DYXCsVMEmQcH5TUc1neIoaO1kfB5Xacke1J
6amkI88lFPcqeXW1ODe+Erd2O6SyuTF9EdQV/VWrKgWa9YLZQvLjBdgpIUen
1rptMspbbQdYa8haOB41CeYMZlB+XH4bqIyUth1qM6NlNWfbr8zlfLr2Twbq
zaroEbTPvuISY5Cep9D+WK8l2V1PgbUzYav9kcnyrrC/RhnH+FVCXLK5hUjz
RPUc0ZpM0ZrrOUXNGaTNGaAFzRmkzRmgBc0y3/4/p/8Armn83p2abb/8f0//
AFzj/m9J7ANl/wCP2T/rmn83pcUSf8f0n/XNP5vS4oWwDcUYp2KMUwGFFYYY
A/WlChRgAAe1OxRigBuKMU7FGKAG4oNOxTWpS2A8B8Xf8jbq3/Xb/wBmeil8
XD/irdV/67f+zPRXoUf4aPBxf8aX9dDpfhP/AMhfU/8Agf8A6Eteq/8AL1bf
9dD/AOgNXlfwo/5C+p/R/wD0Ja9U/wCXq2/66H/0Bq86W57sNhL/AP5CNj/2
0/kKmqG//wCQjY/9tP5Cpc047DFopM0ZqgMPWtCm1KS6lhuBHJJDFHHk/d2y
Fm7EDcDtPB49agHh+5VmJFvOuIvknkY7lVApjY7cbcjdnHXHy10eaM0Csc5H
4cnijBd4bqTzIyyzFtrqsIjwev8AF8/TqB35GbbeDNRtrdVGqkSJJGyOhbKq
AQQOe/H5V2uaM0FJtHL6dp2pfZ3WWwitVe8jkEXmBjGqCP5hgkc7W468j3rq
aTNGaVhC0UmaM0wFopM0ZoAWikzRmgBaKTNGaAFopM0ZoAWvFPGviSD/AISm
7SRJiIyEXAGMAdufrXruq3H2bS7iQEhtu1fqeBXmt9GqwMzKCWOMkV52NxHs
2la52YWlzJtnGf8ACRWn/POf/vkf40DxJbKwKxzgjoQB/jVq8sVjlLqo2N7d
DVb7OP7opQnzxUkayjyuzGXXihtQYrfTXk8CnKRPISAfXk9asW/ja9iQpJfX
7gH5T5pzj35qH7OPQUeR7CmlZ3Np4iU4ezaVui7enr179S0fHNx/z835/wC2
p/xp3/Cd3BgeEzXRR/vZYE/nmqfkewqSKxlnz5UTPj0FVzNdTn5U+h3XhmdP
7MhlVSvmfOQetddb3u1eDXAabNLa20UUysjqOhrZjv8Ajqa4VVcZO50ukpJW
OmuL3cpyTXGeKNXfSEj1GFnWQOIzt7g5PIPXpV2S/wCOtYerrPqEAjhjLgPk
nsKartyTQvYpRdznz45uCxP2i9GTniTH9aZP43vXj2w3t+hPVvMPA9uafJaP
C22RNp9DTfK9q6XUbRnC1OSlbbuVLfxO1g+6xmvIQ5zKqyEbz6nB61Zn8X/a
gBcSXkwHTzH3Y/M07yR6ClEA/uikpcuiLq1JVWnPV9+r9St/wkVp/wA85/yH
+NSQeJbdLiN4knEisCpAHXPHerEdp5kgUAc1vWlvGg8sIuO3FY1sSoaW3FCl
zanq2mXy6jp8V0oI3jkehHBq3XI+EbwRNLZOT853x/XHP9K63NelhqvtaSl1
6nn1qfJNoWikzRmugyFopM0ZoAWktv8Aj+n/AOucf83ozRa/8fs//XOP+b1M
tgFf/j+l/wCuafzenYpG/wCP6X/rkn83p+KSGNxRinYoxTENxRinYoxQA3FG
KdijFADcUx+oqXFRydRSYzxbxrYomoXV0MbpLhgfwZ6KXxvdK1/cQA8pcMT/
AN9PRXo0f4aPn8V/GkXvhR/yF9T/AOB/+hLXqv8Ay9W3/XQ/+gNXlfwoGNX1
L/gf/oS16p/y9W3/AF0P/oDV50tz3YbDdQ/5CFj/ANtP5Cpc1FqP/H/Y/wDb
T+Qp+aqOxTHZozTc0ZqhDs0ZpuaM0AOzRmm5ozQA7NGabmjNADs0ZpuaM0AO
zRmm5ozQA7NGabmjNADs0ZpuaM0AOzRmm5ozQBh+IpS/lW46Y3N/SuH1dsTr
EOijJ+tdlen7RdPJ26D6CuFv5fOv53HTeQPoOK+ex0uaTZ6+FjaKRUdBIhU1
UNqQau0VzUq8qasjedNS3KP2U0n2U1forX67Mj2ESh9lNdRp6LEkaqAAAKxq
0rGXK7Twy9PcVMsRKbXMaQpKN7G3daUupwKUcJOn3Seh9jXPzWV/aOUkt5Rj
uFJB+hrdt78wkZXP0NaUesRbfvEexrojOnJasycakXojlLXTr68cDynjTvI6
kAVpvbpZ2whU7sdW9T61pXGpxuDgk1lzyGYnsKipOCVkXCM27sy7yJZoWUj3
B9KyhZmty4CqmB1aqwWueNaUNEaThGT1M37Gad9jNaW2lC1X1mZn7KJVt7YR
Ak9TVlPlcN6GnhaULWMm5PmZaslZGtaMbe5iuE52MG+td3DKs0KSr0dQRXCa
cPMgKd0P6V1WjTZtzATyhyPpXsZfOz5ejPOxcbq/Y1c0ZpuaM16xwDs0Zpua
M0AOzRa/8fs//XOP+b03NLaf8fs//XOP+b1MthokP/H9L/1yT+b1Lio/+X6X
/rkn83qXFQhjcUYp2KMUwG4oxTsUmKAExS4pcUmKADFRS9RUuKim6ikwPH/H
GiiGSXUd3NxdMuPTDPRWz4//AOQJb/8AX5J/N6K9Ol8CPn8X/GkZfwo/5C+p
f8D/APQlr1X/AJerb/rof/QGryn4T/8AIY1P/gf/AKEterf8vVt/10P/AKA1
ebLc96Gw3Uf+P+x/7afyFOpmpf8AH/Zf9tP5ClqobDY6im0VYh1FNooAdRTa
KAHUU2igB1FNooAdRTaKAHUU2igB1FNooAdUczYhbHXGKdTXUuMdqio7RZUV
dnPau32XSrmXoQm0fU8f1rgK7PxnKUjt7RT9/LuPYdP6/lXJCOvmsXL95y9j
2cOvcv3IcUoUmpwgpwWuU6CAR08R1KFpwWgCIJTlBVgRwRUgWnBaLCuWoZRI
vPDelSVTUFSCO1S7zVopSJ6RmCqSai3mkOWpg5oibLsWPegLUoWlC0WM7kYW
lC1KFpQtOwrkYWlC1KFpQtOwrkunv5V2mThWO0109qPJuEft0P0rlAtdZpxF
zYxv/EBtb6iuzCuzsc1daXNnIoqKInywD24p9e/F3Vzy2rOw6im0UxDqdZ/8
fs//AFzj/m9R0+y/4/bj/rnH/N6mWw0TD/j/AJf+uSfzepqiH/H/AC/9ck/m
9TVmMSilooASilooASilooASoZvvCp6gn+8PpQB5v4//AOQJb/8AX5J/N6KP
H/8AyBLf/r8k/m9FenS+BHz+L/jSMr4Tf8hjU/8Agf8A6Eterf8AL1bf9dD/
AOgNXk/wkOdZ1X/gf/oS16x/y9W3/XQ/+gNXmy3PdhsM1L/j+sv+2n8hRmjU
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
L/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3
DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0
uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/
s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gV
L/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3
DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0
uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/
s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gV
L/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3
DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0
uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/
s6D/AJ6XX/gVL/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gV
L/8AFVboo5n3DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3
DlXYqf2dB/z0uv8AwKl/+Ko/s6D/AJ6XX/gVL/8AFVboo5n3DlXYzfL04Ej7
bJkHB/05/wD4qpIXsIHLJeZJGPnumcfkzGktLxEsrdTnIiT/ANBFS/bk96Ls
LIf9ttP+fqH/AL+CqTQ6eZHdL1I97F2AkQgk9TyDXO33i7Vre52W9tBcZnkj
MKxPvjUNhSx3fxDJ4HbjNdTDqCPBG5cOWUHcowDx1HPSlYZX8qyH/MSH/fUX
/wATV6zS3jtUjtWVoVyAVbd9eaZ9uT3pbRxJJdMOhlH/AKAtAHmHjjq//X03
/oT0UeOer/8AX03/AKE9FerS+BHz2K/jSL/w3s1ttUvHUY8xHJ/NK9JrwvSv
FYhhV7fz45QuyQqdo3cZxhunA61o/wDCa3f/AD8XX/fxv/iq5JUJSd0essTC
Pus9jorx0eNrvvPdf9/G/wDiqX/hNrr/AJ73X/fxv/iqX1WY/rdM9horx7/h
Nrr/AJ73X/fxv/iqP+E2uv8Anvdf9/G/+Ko+qzD63TPYaK8e/wCE2uv+e91/
38b/AOKo/wCE2uv+e91/38b/AOKo+qzD63TPYaK8fHje57zXX/fxv/iqd/wm
8/8Az2u/+/jf/FUvq0w+t0z16ivIf+E3m/57Xf8A38b/AOKqvc+OL4oRBPch
vVpG/wDiqPq0x/W6Z7NRXg3/AAmfiEn/AI/3A9pH/wAacPGWvd7+X/v4/wDj
S+ryH9Zpnu9FeFf8Jlrn/P8ATf8Afx/8aX/hMtb/AOf6b/v6/wDjR9XmH1qm
e6UV4X/wmWuf8/03/fx/8aB4y1v/AJ/pv+/j/wCNH1eYfWqZ7pRXhv8Awmet
f8/s3/fx/wDGl/4TPWf+f2f/AL+P/wDFUfV5i+tUz3GivDG8Za2R8t9MPrI/
+NM/4THXv+f+X/v4/wDjT+rzD61TPdqK8MXxlrX8V9N+Ej//ABVPHjLV+97c
f9/G/wDiqPq0w+tUz3CivEx4y1PHN5c/9/G/+Kp48aagOt1c/wDf1v8A4qj6
tMPrVM9porxQ+NtS7XNx+Mr/APxVKPG2o4/4+bj/AL+v/wDFUfVph9apntVF
eK/8JrqP/Pzc/wDfxv8A4qgeNdRz/wAfNz/39b/4qj6tMPrVM9qorxR/GmpH
7t3cj/tq3/xVM/4TPVP+fy4/7+N/8VR9WmH1qme3UV4a3jPWP4b2f8ZX/wDi
qQeM9a/5/Zv+/r//ABVH1aYfWqZ7nRXho8Z6znm9m/7+v/8AFVOvjTUwObu5
P/bRv/iqPq0w+tUz2uivFf8AhNdS/wCfq4/7+N/8VTG8aar2u5/+/jf/ABVH
1aYfW6Z7bRXiQ8a6r3up/wDv4/8A8VQfGuq9rqf/AL+N/wDFU/q0w+t0z22i
vD28aax/DeTD/to//wAVUZ8Z652vZf8Av4/+NL6tMPrVM90orwr/AITPXf8A
n+l/7+P/AI01vGWv9r+T/v4/+NL6vMf1qme70V4TH4y14N899KR7Sv8A41J/
wmmsZ/4/J8f9dX/+Ko+rzD61TPcqK8N/4TPV/wDn9n/7+v8A/FU8eNdV73dx
/wB/X/8AiqPq8w+tUz2+ivEv+E11L/n6uP8Av6//AMVTJPGmrH7l5cD/ALav
/wDFUfV5B9ZpnuFFeEf8Jlr2f+P6XH/XR/8AGl/4TPXs/wDH9Jj/AK6P/jR9
XmL61TPZhpMYAAuJwBwB8vA7D7tL/ZSf8/M//jv/AMTXkFt421ZX/fXMzL7S
v/8AFVqr44bAzJeZ/wCujf8AxdP6tMPrdM9K/spP+fmf/wAd/wDiaP7KT/n5
n/8AHf8A4mvNv+E4P9+9/wC/jf8AxdL/AMJx/t3v/fxv/i6Pq0w+t0z0j+yk
/wCfmf8A8d/+JqzbW62yModnLNuLNjJ4A7AdgK8sPjhu0l5/38b/AOLo/wCE
4b/npef9/G/+Lo+rTD61TDxx96T/AK+m/wDQnormvEniP7cI4II2L7jI7TZ9
+nJJ5J60V0qpGCUX0POqYepWm5w2Z//ZZW5kc3RyZWFtCmVuZG9iagoyNSAw
IG9iagoyNDkzMAplbmRvYmoKMjYgMCBvYmoKPDwKL1R5cGUgL1hPYmplY3QK
L1N1YnR5cGUgL0ltYWdlCi9OYW1lIC9pbTcKL1dpZHRoIDMzOQovSGVpZ2h0
IDY0Ci9CaXRzUGVyQ29tcG9uZW50IDgKL0NvbG9yU3BhY2UgL0RldmljZVJH
QgovRmlsdGVyIC9EQ1REZWNvZGUKL0xlbmd0aCAyNyAwIFIKPj4Kc3RyZWFt
DQr/2P/gABBKRklGAAEBAAABAAEAAP/bAEMACAYGBwYFCAcHBwkJCAoMFA0M
CwsMGRITDxQdGh8eHRocHCAkLicgIiwjHBwoNyksMDE0NDQfJzk9ODI8LjM0
Mv/bAEMBCQkJDAsMGA0NGDIhHCEyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMv/AABEIAEABUwMBIgACEQEDEQH/
xAAfAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQD
BQUEBAAAAX0BAgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKC
CQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpz
dHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPE
xcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEB
AQEBAQEBAAAAAAAAAQIDBAUGBwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncA
AQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZ
GiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqC
g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS
09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APUbGw0y
y0aKeaC3C+UJZZZUBJJUEkk1X0/U9Gv8MtjAivLsiJhX51JADYxxksvHXmpL
vTDrPhiC0EvlsYo3RigYBgARkEdM1maL4f1OFY3vzEs0U4fKNkMNyEn/AMc4
HvVyclJKK0CCpuDcnr2OimXRra5a3mitUlWBrkqYBxGpAZs47ZFNsjomox20
lrDbyJdQ+fC32baHTCncMr/tL+dJqekR6ncxztcSRFQEYIB88eTuQ57MDg1T
XwvDG9s6XLE25BVXjDI3yInzDvwmR6HB7VS5uxC5e5q3Gn6dbW0s8trbJFEh
d28leABknpTLawsbi2iuIbaBopVDoTAFyCMjgjIrETwTYRQmCORRC0IiOYgW
GEK/KewO4lhg59qkt/B9lbo8QkVoXBBHlAOQduVLd0+UYXHHrTsybo3P7Mtf
+fS3/wC/K/4Uf2ba/wDPpb/9+V/wrnrnwdYSGbZNLCkhLGNANm7cSDj0AJXH
pSN4SsXdp2cJdBVEUsMYQQEOz5RecDLnjmjXsGnc6L+zbX/n0t/+/K/4VBPB
p1u6pLDbKzKWA8lckDAJ6e4/OsW08JadbTSszNMjyI+JSWOFIIU87SOBj5cj
nmnN4Yt2jiAlgDRrKgxbDAVypIHO7+Hk7icE4I4wWfYLo1mh05Ut3MFuFuGC
xHyB8xIJHbjgHrVj+zbX/n0t/wDvyv8AhXOnwhYmyhgE7LJE0Z81UHzKibAh
yTlDnJGeamt/DVpGI4p5ftFtGwKQyRjGAztg+vMh/IUe92D3e5tNp1sP+XS3
/wC/K/4VA9lar/y6W/8A35X/AArD0bQjpOuCVAzQxwyIZpVTfIWKdwSSPkPU
DHvXQySbjWkVfdESdupX+y2v/Ppb/wDflf8ACk+y2v8Az62//flf8KkzRmtO
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
todzp6K5n/hKbb/oM6T+Y/8AjlH/AAlFt/0GtJ/Mf/HKPZT7B7aHc6asrXf9
VZf9fcf9az/+Eotv+g1pP5j/AOOVBPrun3nlC41rTdkUglHluqkke5c01Tkn
sDqwa3PMfGX/ACNuof74/wDQRRVXxNqEN94kvri2WWSFpMK6JkNgAZB7jiiu
5VYLqeJLD1W7qJ//2WVuZHN0cmVhbQplbmRvYmoKMjcgMCBvYmoKNTA1MQpl
bmRvYmoKMjggMCBvYmoKPDwKL1R5cGUgL1hPYmplY3QKL1N1YnR5cGUgL0lt
YWdlCi9OYW1lIC9pbTgKL1dpZHRoIDIxNgovSGVpZ2h0IDEzMAovQml0c1Bl
ckNvbXBvbmVudCA4Ci9Db2xvclNwYWNlIC9EZXZpY2VSR0IKL0ZpbHRlciAv
RENURGVjb2RlCi9MZW5ndGggMjkgMCBSCj4+CnN0cmVhbQ0K/9j/4AAQSkZJ
RgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRof
Hh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwL
DBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIyMjL/wAARCACCANgDASIAAhEBAxEB/8QAHwAAAQUBAQEB
AQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQID
AAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJico
KSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG
h4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW
19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAA
AAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJB
UQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5
OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOU
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
IFIgMzUgMCBSIDM3IDAgUiAzOSAwIFJdCmVuZG9iagozMyAwIG9iago8PAov
VHlwZSAvQW5ub3QKL1N1YnR5cGUgL0xpbmsKL1JlY3QgWzMxOCA1OC43MSA0
MjIuNjQgNTEuODFdCi9BIDM0IDAgUgovQm9yZGVyIFswIDAgMF0KL0ggL0kK
Pj4KZW5kb2JqCjM0IDAgb2JqCjw8Ci9TIC9VUkkKL1VSSSAobWFpbHRvOnRl
Y2huaWNhbC5zdXBwb3J0QGZ1aml0c3Utc2llbWVucy5jb20pCj4+CmVuZG9i
agozNSAwIG9iago8PAovVHlwZSAvQW5ub3QKL1N1YnR5cGUgL0xpbmsKL1Jl
Y3QgWzQzNy4yOCA5OS45OSA1MjEuNzYgOTMuMDldCi9BIDM2IDAgUgovQm9y
ZGVyIFswIDAgMF0KL0ggL0kKPj4KZW5kb2JqCjM2IDAgb2JqCjw8Ci9TIC9V
UkkKL1VSSSAoaHR0cDovL3d3dy5mdWppdHN1LXNpZW1lbnMuY29tLykKPj4K
ZW5kb2JqCjM3IDAgb2JqCjw8Ci9UeXBlIC9Bbm5vdAovU3VidHlwZSAvTGlu
awovUmVjdCBbNDM3LjI4IDc5LjM1IDQ4OS44NCA3Mi40NV0KL0EgMzggMCBS
Ci9Cb3JkZXIgWzAgMCAwXQovSCAvSQo+PgplbmRvYmoKMzggMCBvYmoKPDwK
L1MgL1VSSQovVVJJIChodHRwOi8vc3VwcG9ydC5mdWppdHN1KQo+PgplbmRv
YmoKMzkgMCBvYmoKPDwKL1R5cGUgL0Fubm90Ci9TdWJ0eXBlIC9MaW5rCi9S
ZWN0IFs0MzcuMjggNTEuNzUgNTUyLjk2IDQ0Ljg1XQovQSA0MCAwIFIKL0Jv
cmRlciBbMCAwIDBdCi9IIC9JCj4+CmVuZG9iago0MCAwIG9iago8PAovUyAv
VVJJCi9VUkkgKGh0dHA6Ly93d3cuZnVqaXRzdS1zaWVtZW5zLmNvbS9pbXBy
aW50Lmh0bWwpCj4+CmVuZG9iagoxNyAwIG9iago8PAovVHlwZSAvRm9udAov
U3VidHlwZSAvVHJ1ZVR5cGUKL05hbWUgL0YxCi9CYXNlRm9udCAvQXJpYWwK
L0ZpcnN0Q2hhciAzMgovTGFzdENoYXIgMjU1Ci9XaWR0aHMgWzI3OCAyNzgg
MzU1IDU1NiA1NTYgODg5IDY2NyAxOTEgMzMzIDMzMyAzODkgNTg0IDI3OCAz
MzMgMjc4IDI3OAo1NTYgNTU2IDU1NiA1NTYgNTU2IDU1NiA1NTYgNTU2IDU1
NiA1NTYgMjc4IDI3OCA1ODQgNTg0IDU4NCA1NTYKMTAxNSA2NjcgNjY3IDcy
MiA3MjIgNjY3IDYxMSA3NzggNzIyIDI3OCA1MDAgNjY3IDU1NiA4MzMgNzIy
IDc3OAo2NjcgNzc4IDcyMiA2NjcgNjExIDcyMiA2NjcgOTQ0IDY2NyA2Njcg
NjExIDI3OCAyNzggMjc4IDQ2OSA1NTYKMzMzIDU1NiA1NTYgNTAwIDU1NiA1
NTYgMjc4IDU1NiA1NTYgMjIyIDIyMiA1MDAgMjIyIDgzMyA1NTYgNTU2CjU1
NiA1NTYgMzMzIDUwMCAyNzggNTU2IDUwMCA3MjIgNTAwIDUwMCA1MDAgMzM0
IDI2MCAzMzQgNTg0IDc1MAo1NTYgNzUwIDIyMiA1NTYgMzMzIDEwMDAgNTU2
IDU1NiAzMzMgMTAwMCA2NjcgMzMzIDEwMDAgNzUwIDYxMSA3NTAKNzUwIDIy
MiAyMjIgMzMzIDMzMyAzNTAgNTU2IDEwMDAgMzMzIDEwMDAgNTAwIDMzMyA5
NDQgNzUwIDUwMCA2NjcKMjc4IDMzMyA1NTYgNTU2IDU1NiA1NTYgMjYwIDU1
NiAzMzMgNzM3IDM3MCA1NTYgNTg0IDMzMyA3MzcgNTUyCjQwMCA1NDkgMzMz
IDMzMyAzMzMgNTc2IDUzNyAyNzggMzMzIDMzMyAzNjUgNTU2IDgzNCA4MzQg
ODM0IDYxMQo2NjcgNjY3IDY2NyA2NjcgNjY3IDY2NyAxMDAwIDcyMiA2Njcg
NjY3IDY2NyA2NjcgMjc4IDI3OCAyNzggMjc4CjcyMiA3MjIgNzc4IDc3OCA3
NzggNzc4IDc3OCA1ODQgNzc4IDcyMiA3MjIgNzIyIDcyMiA2NjcgNjY3IDYx
MQo1NTYgNTU2IDU1NiA1NTYgNTU2IDU1NiA4ODkgNTAwIDU1NiA1NTYgNTU2
IDU1NiAyNzggMjc4IDI3OCAyNzgKNTU2IDU1NiA1NTYgNTU2IDU1NiA1NTYg
NTU2IDU0OSA2MTEgNTU2IDU1NiA1NTYgNTU2IDUwMCA1NTYgNTAwXQovRW5j
b2RpbmcgL1dpbkFuc2lFbmNvZGluZwovRm9udERlc2NyaXB0b3IgNDEgMCBS
Cj4+CmVuZG9iago0MSAwIG9iago8PAovVHlwZSAvRm9udERlc2NyaXB0b3IK
L0ZvbnROYW1lIC9BcmlhbAovRmxhZ3MgMzIKL0ZvbnRCQm94IFstNjY1IC0z
MjUgMjAwMCAxMDA2XQovU3RlbVYgOTUKL0l0YWxpY0FuZ2xlIDAKL0NhcEhl
aWdodCA5MDUKL0FzY2VudCA5MDUKL0Rlc2NlbnQgLTIxMgo+PgplbmRvYmoK
MTggMCBvYmoKPDwKL1R5cGUgL0ZvbnQKL1N1YnR5cGUgL1RydWVUeXBlCi9O
YW1lIC9GMgovQmFzZUZvbnQgL0FyaWFsLEJvbGQKL0ZpcnN0Q2hhciAzMgov
TGFzdENoYXIgMjU1Ci9XaWR0aHMgWzI3OCAzMzMgNDc0IDU1NiA1NTYgODg5
IDcyMiAyMzggMzMzIDMzMyAzODkgNTg0IDI3OCAzMzMgMjc4IDI3OAo1NTYg
NTU2IDU1NiA1NTYgNTU2IDU1NiA1NTYgNTU2IDU1NiA1NTYgMzMzIDMzMyA1
ODQgNTg0IDU4NCA2MTEKOTc1IDcyMiA3MjIgNzIyIDcyMiA2NjcgNjExIDc3
OCA3MjIgMjc4IDU1NiA3MjIgNjExIDgzMyA3MjIgNzc4CjY2NyA3NzggNzIy
IDY2NyA2MTEgNzIyIDY2NyA5NDQgNjY3IDY2NyA2MTEgMzMzIDI3OCAzMzMg
NTg0IDU1NgozMzMgNTU2IDYxMSA1NTYgNjExIDU1NiAzMzMgNjExIDYxMSAy
NzggMjc4IDU1NiAyNzggODg5IDYxMSA2MTEKNjExIDYxMSAzODkgNTU2IDMz
MyA2MTEgNTU2IDc3OCA1NTYgNTU2IDUwMCAzODkgMjgwIDM4OSA1ODQgNzUw
CjU1NiA3NTAgMjc4IDU1NiA1MDAgMTAwMCA1NTYgNTU2IDMzMyAxMDAwIDY2
NyAzMzMgMTAwMCA3NTAgNjExIDc1MAo3NTAgMjc4IDI3OCA1MDAgNTAwIDM1
MCA1NTYgMTAwMCAzMzMgMTAwMCA1NTYgMzMzIDk0NCA3NTAgNTAwIDY2Nwoy
NzggMzMzIDU1NiA1NTYgNTU2IDU1NiAyODAgNTU2IDMzMyA3MzcgMzcwIDU1
NiA1ODQgMzMzIDczNyA1NTIKNDAwIDU0OSAzMzMgMzMzIDMzMyA1NzYgNTU2
IDI3OCAzMzMgMzMzIDM2NSA1NTYgODM0IDgzNCA4MzQgNjExCjcyMiA3MjIg
NzIyIDcyMiA3MjIgNzIyIDEwMDAgNzIyIDY2NyA2NjcgNjY3IDY2NyAyNzgg
Mjc4IDI3OCAyNzgKNzIyIDcyMiA3NzggNzc4IDc3OCA3NzggNzc4IDU4NCA3
NzggNzIyIDcyMiA3MjIgNzIyIDY2NyA2NjcgNjExCjU1NiA1NTYgNTU2IDU1
NiA1NTYgNTU2IDg4OSA1NTYgNTU2IDU1NiA1NTYgNTU2IDI3OCAyNzggMjc4
IDI3OAo2MTEgNjExIDYxMSA2MTEgNjExIDYxMSA2MTEgNTQ5IDYxMSA2MTEg
NjExIDYxMSA2MTEgNTU2IDYxMSA1NTZdCi9FbmNvZGluZyAvV2luQW5zaUVu
Y29kaW5nCi9Gb250RGVzY3JpcHRvciA0MiAwIFIKPj4KZW5kb2JqCjQyIDAg
b2JqCjw8Ci9UeXBlIC9Gb250RGVzY3JpcHRvcgovRm9udE5hbWUgL0FyaWFs
LEJvbGQKL0ZsYWdzIDMyCi9Gb250QkJveCBbLTYyOCAtMzc2IDIwMDAgMTAx
MF0KL1N0ZW1WIDExOQovSXRhbGljQW5nbGUgMAovQ2FwSGVpZ2h0IDkwNQov
QXNjZW50IDkwNQovRGVzY2VudCAtMjEyCj4+CmVuZG9iagoxOSAwIG9iago8
PAovVHlwZSAvRm9udAovU3VidHlwZSAvVHJ1ZVR5cGUKL05hbWUgL0YzCi9C
YXNlRm9udCAvQXJpYWwsSXRhbGljCi9GaXJzdENoYXIgMzIKL0xhc3RDaGFy
IDI1NQovV2lkdGhzIFsyNzggMjc4IDM1NSA1NTYgNTU2IDg4OSA2NjcgMTkx
IDMzMyAzMzMgMzg5IDU4NCAyNzggMzMzIDI3OCAyNzgKNTU2IDU1NiA1NTYg
NTU2IDU1NiA1NTYgNTU2IDU1NiA1NTYgNTU2IDI3OCAyNzggNTg0IDU4NCA1
ODQgNTU2CjEwMTUgNjY3IDY2NyA3MjIgNzIyIDY2NyA2MTEgNzc4IDcyMiAy
NzggNTAwIDY2NyA1NTYgODMzIDcyMiA3NzgKNjY3IDc3OCA3MjIgNjY3IDYx
MSA3MjIgNjY3IDk0NCA2NjcgNjY3IDYxMSAyNzggMjc4IDI3OCA0NjkgNTU2
CjMzMyA1NTYgNTU2IDUwMCA1NTYgNTU2IDI3OCA1NTYgNTU2IDIyMiAyMjIg
NTAwIDIyMiA4MzMgNTU2IDU1Ngo1NTYgNTU2IDMzMyA1MDAgMjc4IDU1NiA1
MDAgNzIyIDUwMCA1MDAgNTAwIDMzNCAyNjAgMzM0IDU4NCA3NTAKNTU2IDc1
MCAyMjIgNTU2IDMzMyAxMDAwIDU1NiA1NTYgMzMzIDEwMDAgNjY3IDMzMyAx
MDAwIDc1MCA2MTEgNzUwCjc1MCAyMjIgMjIyIDMzMyAzMzMgMzUwIDU1NiAx
MDAwIDMzMyAxMDAwIDUwMCAzMzMgOTQ0IDc1MCA1MDAgNjY3CjI3OCAzMzMg
NTU2IDU1NiA1NTYgNTU2IDI2MCA1NTYgMzMzIDczNyAzNzAgNTU2IDU4NCAz
MzMgNzM3IDU1Mgo0MDAgNTQ5IDMzMyAzMzMgMzMzIDU3NiA1MzcgMjc4IDMz
MyAzMzMgMzY1IDU1NiA4MzQgODM0IDgzNCA2MTEKNjY3IDY2NyA2NjcgNjY3
IDY2NyA2NjcgMTAwMCA3MjIgNjY3IDY2NyA2NjcgNjY3IDI3OCAyNzggMjc4
IDI3OAo3MjIgNzIyIDc3OCA3NzggNzc4IDc3OCA3NzggNTg0IDc3OCA3MjIg
NzIyIDcyMiA3MjIgNjY3IDY2NyA2MTEKNTU2IDU1NiA1NTYgNTU2IDU1NiA1
NTYgODg5IDUwMCA1NTYgNTU2IDU1NiA1NTYgMjc4IDI3OCAyNzggMjc4CjU1
NiA1NTYgNTU2IDU1NiA1NTYgNTU2IDU1NiA1NDkgNjExIDU1NiA1NTYgNTU2
IDU1NiA1MDAgNTU2IDUwMF0KL0VuY29kaW5nIC9XaW5BbnNpRW5jb2RpbmcK
L0ZvbnREZXNjcmlwdG9yIDQzIDAgUgo+PgplbmRvYmoKNDMgMCBvYmoKPDwK
L1R5cGUgL0ZvbnREZXNjcmlwdG9yCi9Gb250TmFtZSAvQXJpYWwsSXRhbGlj
Ci9GbGFncyA5NgovRm9udEJCb3ggWy01MTcgLTMyNSAxMDgyIDk5OF0KL1N0
ZW1WIDk1Ci9JdGFsaWNBbmdsZSAtMTIKL0NhcEhlaWdodCA5MDUKL0FzY2Vu
dCA5MDUKL0Rlc2NlbnQgLTIxMgo+PgplbmRvYmoKMjAgMCBvYmoKPDwKL1R5
cGUgL0ZvbnQKL1N1YnR5cGUgL1RydWVUeXBlCi9OYW1lIC9GNAovQmFzZUZv
bnQgL1RhaG9tYQovRmlyc3RDaGFyIDMyCi9MYXN0Q2hhciAyNTUKL1dpZHRo
cyBbMzEzIDMzMiA0MDEgNzI4IDU0NiA5NzcgNjc0IDIxMSAzODMgMzgzIDU0
NiA3MjggMzAzIDM2MyAzMDMgMzgyCjU0NiA1NDYgNTQ2IDU0NiA1NDYgNTQ2
IDU0NiA1NDYgNTQ2IDU0NiAzNTQgMzU0IDcyOCA3MjggNzI4IDQ3NAo5MDkg
NjAwIDU4OSA2MDEgNjc4IDU2MSA1MjEgNjY3IDY3NSAzNzMgNDE3IDU4OCA0
OTggNzcxIDY2NyA3MDgKNTUxIDcwOCA2MjEgNTU3IDU4NCA2NTYgNTk3IDkw
MiA1ODEgNTc2IDU1OSAzODMgMzgyIDM4MyA3MjggNTQ2CjU0NiA1MjUgNTUz
IDQ2MSA1NTMgNTI2IDMxOCA1NTMgNTU4IDIyOSAyODIgNDk4IDIyOSA4NDAg
NTU4IDU0Mwo1NTMgNTUzIDM2MCA0NDYgMzM0IDU1OCA0OTggNzQyIDQ5NSA0
OTggNDQ0IDQ4MCAzODIgNDgwIDcyOCAxMDAwCjU0NiAxMDAwIDIxMSA1NDYg
Mzk3IDgxNyA1NDYgNTQ2IDU0NiAxMzkxIDU1NyAzODMgOTc3IDEwMDAgNTU5
IDEwMDAKMTAwMCAyMTEgMjExIDQwMSA0MDEgNDU1IDU0NiA5MDkgNTQ2IDg3
NiA0NDYgMzgzIDkwOSAxMDAwIDQ0NCA1NzYKMzEzIDMzMiA1NDYgNTQ2IDU0
NiA1NDYgMzgyIDU0NiA1NDYgOTI5IDQ5MyA1NzMgNzI4IDM2MyA5MjkgNTQ2
CjQ3MSA3MjggNDkzIDQ5MyA1NDYgNTY4IDU0NiAzNTQgNTQ2IDQ5MyA0OTMg
NTczIDEwMDAgMTAwMCAxMDAwIDQ3NAo2MDAgNjAwIDYwMCA2MDAgNjAwIDYw
MCA5MTMgNjAxIDU2MSA1NjEgNTYxIDU2MSAzNzMgMzczIDM3MyAzNzMKNjk4
IDY2NyA3MDggNzA4IDcwOCA3MDggNzA4IDcyOCA3MDggNjU2IDY1NiA2NTYg
NjU2IDU3NiA1NjUgNTQ4CjUyNSA1MjUgNTI1IDUyNSA1MjUgNTI1IDg4MCA0
NjEgNTI2IDUyNiA1MjYgNTI2IDIyOSAyMjkgMjI5IDIyOQo1NDYgNTU4IDU0
MyA1NDMgNTQzIDU0MyA1NDMgNzI4IDU0MyA1NTggNTU4IDU1OCA1NTggNDk4
IDU1MyA0OThdCi9FbmNvZGluZyAvV2luQW5zaUVuY29kaW5nCi9Gb250RGVz
Y3JpcHRvciA0NCAwIFIKPj4KZW5kb2JqCjQ0IDAgb2JqCjw8Ci9UeXBlIC9G
b250RGVzY3JpcHRvcgovRm9udE5hbWUgL1RhaG9tYQovRmxhZ3MgMzIKL0Zv
bnRCQm94IFstNjAwIC0yMDcgMTMzOCAxMDM0XQovU3RlbVYgMTA1Ci9JdGFs
aWNBbmdsZSAwCi9DYXBIZWlnaHQgMTAwMAovQXNjZW50IDEwMDAKL0Rlc2Nl
bnQgLTIwNwo+PgplbmRvYmoKMzAgMCBvYmoKPDwKL1R5cGUgL0ZvbnQKL1N1
YnR5cGUgL1RydWVUeXBlCi9OYW1lIC9GNQovQmFzZUZvbnQgL1N5bWJvbAov
Rmlyc3RDaGFyIDMyCi9MYXN0Q2hhciAyNTUKL1dpZHRocyBbMjUwIDMzMyA3
MTMgNTAwIDU0OSA4MzMgNzc4IDQzOSAzMzMgMzMzIDUwMCA1NDkgMjUwIDU0
OSAyNTAgMjc4CjUwMCA1MDAgNTAwIDUwMCA1MDAgNTAwIDUwMCA1MDAgNTAw
IDUwMCAyNzggMjc4IDU0OSA1NDkgNTQ5IDQ0NAo1NDkgNzIyIDY2NyA3MjIg
NjEyIDYxMSA3NjMgNjAzIDcyMiAzMzMgNjMxIDcyMiA2ODYgODg5IDcyMiA3
MjIKNzY4IDc0MSA1NTYgNTkyIDYxMSA2OTAgNDM5IDc2OCA2NDUgNzk1IDYx
MSAzMzMgODYzIDMzMyA2NTggNTAwCjUwMCA2MzEgNTQ5IDU0OSA0OTQgNDM5
IDUyMSA0MTEgNjAzIDMyOSA2MDMgNTQ5IDU0OSA1NzYgNTIxIDU0OQo1NDkg
NTIxIDU0OSA2MDMgNDM5IDU3NiA3MTMgNjg2IDQ5MyA2ODYgNDk0IDQ4MCAy
MDAgNDgwIDU0OSA2MDAKNjAwIDYwMCA2MDAgNjAwIDYwMCA2MDAgNjAwIDYw
MCA2MDAgNjAwIDYwMCA2MDAgNjAwIDYwMCA2MDAgNjAwCjYwMCA2MDAgNjAw
IDYwMCA2MDAgNjAwIDYwMCA2MDAgNjAwIDYwMCA2MDAgNjAwIDYwMCA2MDAg
NjAwIDYwMAo2MDAgNjIwIDI0NyA1NDkgMTY3IDcxMyA1MDAgNzUzIDc1MyA3
NTMgNzUzIDEwNDIgOTg3IDYwMyA5ODcgNjAzCjQwMCA1NDkgNDExIDU0OSA1
NDkgNzEzIDQ5NCA0NjAgNTQ5IDU0OSA1NDkgNTQ5IDEwMDAgNjAzIDEwMDAg
NjU4CjgyMyA2ODYgNzk1IDk4NyA3NjggNzY4IDgyMyA3NjggNzY4IDcxMyA3
MTMgNzEzIDcxMyA3MTMgNzEzIDcxMwo3NjggNzEzIDc5MCA3OTAgODkwIDgy
MyA1NDkgMjUwIDcxMyA2MDMgNjAzIDEwNDIgOTg3IDYwMyA5ODcgNjAzCjQ5
NCAzMjkgNzkwIDc5MCA3ODYgNzEzIDM4NCAzODQgMzg0IDM4NCAzODQgMzg0
IDQ5NCA0OTQgNDk0IDQ5NAo2MDAgMzI5IDI3NCA2ODYgNjg2IDY4NiAzODQg
Mzg0IDM4NCAzODQgMzg0IDM4NCA0OTQgNDk0IDQ5NCA2MDBdCi9Gb250RGVz
Y3JpcHRvciA0NSAwIFIKPj4KZW5kb2JqCjQ1IDAgb2JqCjw8Ci9UeXBlIC9G
b250RGVzY3JpcHRvcgovRm9udE5hbWUgL1N5bWJvbAovRmxhZ3MgNgovRm9u
dEJCb3ggWzAgLTIyMCAxMTEzIDEwMDVdCi9TdGVtViA4MwovSXRhbGljQW5n
bGUgMAovQ2FwSGVpZ2h0IDEwMDUKL0FzY2VudCAxMDA1Ci9EZXNjZW50IC0y
MjAKPj4KZW5kb2JqCjMgMCBvYmoKPDwKL1R5cGUgL1BhZ2VzCi9Db3VudCAy
Ci9LaWRzIFs2IDAgUiAyMyAwIFJdCj4+CmVuZG9iagoyIDAgb2JqCjw8Ci9U
eXBlIC9DYXRhbG9nCi9QYWdlcyAzIDAgUgovVmlld2VyUHJlZmVyZW5jZXMg
NDYgMCBSCj4+CmVuZG9iago0NiAwIG9iago8PAovVHlwZSAvVmlld2VyUHJl
ZmVyZW5jZXMKPj4KZW5kb2JqCjMxIDAgb2JqCjw8Ci9UeXBlIC9FeHRHU3Rh
dGUKL0JNIC9Ob3JtYWwKPj4KZW5kb2JqCnhyZWYKMCA0NwowMDAwMDAwMDAw
IDY1NTM1IGYNCjAwMDAwMDAwMTYgMDAwMDAgbg0KMDAwMDA5NzA1MiAwMDAw
MCBuDQowMDAwMDk2OTg4IDAwMDAwIG4NCjAwMDAwMDAyMzggMDAwMDAgbg0K
MDAwMDAwMjE5NSAwMDAwMCBuDQowMDAwMDAyMjE1IDAwMDAwIG4NCjAwMDAw
MDI0NzYgMDAwMDAgbg0KMDAwMDAxMjg4OSAwMDAwMCBuDQowMDAwMDEyOTEw
IDAwMDAwIG4NCjAwMDAwMjI5MTEgMDAwMDAgbg0KMDAwMDAyMjkzMiAwMDAw
MCBuDQowMDAwMDM0NzQxIDAwMDAwIG4NCjAwMDAwMzQ3NjMgMDAwMDAgbg0K
MDAwMDA0NjU5OCAwMDAwMCBuDQowMDAwMDQ2NjIwIDAwMDAwIG4NCjAwMDAw
NTA3NTYgMDAwMDAgbg0KMDAwMDA5MDc4NSAwMDAwMCBuDQowMDAwMDkyMDI1
IDAwMDAwIG4NCjAwMDAwOTMyNzUgMDAwMDAgbg0KMDAwMDA5NDUzMCAwMDAw
MCBuDQowMDAwMDUwNzc3IDAwMDAwIG4NCjAwMDAwNTMxOTMgMDAwMDAgbg0K
MDAwMDA1MzIxNCAwMDAwMCBuDQowMDAwMDUzNDk5IDAwMDAwIG4NCjAwMDAw
Nzg2MTEgMDAwMDAgbg0KMDAwMDA3ODYzMyAwMDAwMCBuDQowMDAwMDgzODY1
IDAwMDAwIG4NCjAwMDAwODM4ODYgMDAwMDAgbg0KMDAwMDA4OTk2NSAwMDAw
MCBuDQowMDAwMDk1Nzc4IDAwMDAwIG4NCjAwMDAwOTcxNzQgMDAwMDAgbg0K
MDAwMDA4OTk4NiAwMDAwMCBuDQowMDAwMDkwMDMyIDAwMDAwIG4NCjAwMDAw
OTAxNDUgMDAwMDAgbg0KMDAwMDA5MDIyNyAwMDAwMCBuDQowMDAwMDkwMzQz
IDAwMDAwIG4NCjAwMDAwOTA0MTIgMDAwMDAgbg0KMDAwMDA5MDUyOCAwMDAw
MCBuDQowMDAwMDkwNTg4IDAwMDAwIG4NCjAwMDAwOTA3MDQgMDAwMDAgbg0K
MDAwMDA5MTg1NiAwMDAwMCBuDQowMDAwMDkzMTAwIDAwMDAwIG4NCjAwMDAw
OTQzNTMgMDAwMDAgbg0KMDAwMDA5NTYwNSAwMDAwMCBuDQowMDAwMDk2ODIw
IDAwMDAwIG4NCjAwMDAwOTcxMjcgMDAwMDAgbg0KdHJhaWxlcgo8PAovU2l6
ZSA0NwovSW5mbyAxIDAgUgovUm9vdCAyIDAgUgovSUQgWzw2QjM1QTYwMEIz
RUIwODdDOUNDMDVENUZFRjZFQUJDMD48NkIzNUE2MDBCM0VCMDg3QzlDQzA1
RDVGRUY2RUFCQzA+XQo+PgpzdGFydHhyZWYKOTcyMjUKJSVFT0YK

--0-1254038444-1196877936=:48342
Content-Type: text/plain; name="dmesg.txt"
Content-Description: 2784873370-dmesg.txt
Content-Disposition: inline; filename="dmesg.txt"

ACPI: PCI interrupt for device 0000:00:1b.0 disabled
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ALSA /var/tmp/portage/media-sound/alsa-driver-9999/work/alsa-driver/pci/hda/hda_codec.c:2792: autoconfig: line_outs=1 (0x15/0x0/0x0/0x0/0x0)
ALSA /var/tmp/portage/media-sound/alsa-driver-9999/work/alsa-driver/pci/hda/hda_codec.c:2796:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /var/tmp/portage/media-sound/alsa-driver-9999/work/alsa-driver/pci/hda/hda_codec.c:2800:    hp_outs=1 (0x14/0x0/0x0/0x0/0x0)
ALSA /var/tmp/portage/media-sound/alsa-driver-9999/work/alsa-driver/pci/hda/hda_codec.c:2808:    inputs: mic=0x18, fmic=0x19, line=0x0, fline=0x0, cd=0x0, aux=0x0

--0-1254038444-1196877936=:48342
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0-1254038444-1196877936=:48342--
