From: Valentin Rodriguez <valemie@yahoo.com.sg>
Subject: Speaker Sound on acer travelmate c202 with ALC260
	using test model
Date: Sun, 19 Nov 2006 22:25:21 +0800 (CST)
Message-ID: <623662.42914.qm@web30415.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I managed to get speaker sound on my acer travelmate
c202 tablet pc using the test model. Except for hard
disk and memory size, the c202 is the same as the c204
discussed earlier as unable to get sound on the
built-in speaker. I think the key to having speaker
sound on this model is to  have the "mono" control
enabled on this "acer" model. Only GPIO pin 0 have to
be on to get sound. All the other GPIO pins can remain
off. Below are some data that I hope can help you in
your investigation. Please let me know if I can be of
further help.


lspci -vv
00:1b.0 Audio device: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) High
 Definition Audio Controller (rev 04)
 Subsystem: Acer Incorporated [ALI] Unknown device
007b

amixer scontrols
Simple mixer control 'PCM',0
Simple mixer control 'CD',0
Simple mixer control 'Mono',0
Simple mixer control 'Capture',0
Simple mixer control 'Capture',1
Simple mixer control 'Beep',0
Simple mixer control 'GPIO pin 0',0
Simple mixer control 'GPIO pin 1',0
Simple mixer control 'GPIO pin 2',0
Simple mixer control 'GPIO pin 3',0
Simple mixer control 'HP-OUT loopback',0
Simple mixer control 'HP-OUT pin mode',0
Simple mixer control 'Input Source',0
Simple mixer control 'Input Source',1
Simple mixer control 'LINE-OUT loopback',0
Simple mixer control 'LINE-OUT pin mode',0
Simple mixer control 'LINE1',0
Simple mixer control 'LINE1 pin mode',0
Simple mixer control 'LINE2',0
Simple mixer control 'LINE2 pin mode',0
Simple mixer control 'LOUT1',0
Simple mixer control 'LOUT2',0
Simple mixer control 'MIC1',0
Simple mixer control 'MIC1 pin mode',0
Simple mixer control 'MIC2',0
Simple mixer control 'MIC2 pin mode',0
Simple mixer control 'SPDIF',0

cat /proc/asound/card0/codec#0
Codec: Realtek ALC260
Address: 0
Vendor Id: 0x10ec0260
Subsystem Id: 0x1025110d
Revision Id: 0x100400
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03,
mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x8
0 0x80] [0x80 0x80]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x12 0x13 0x14 0x15 0x16 0x0f 0x10*
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03,
mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x8
0 0x80] [0x80 0x80] [0x80 0x80]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x07 0x0f 0x10*
Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x19
Node 0x07 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03,
mute=1
  Amp-In vals:  [0xc1 0xc1] [0xbd 0xbd] [0x80 0x80]
[0xc1 0xc1] [0x29 0x29] [0x4
1 0x41] [0x80 0x80] [0x80 0x80]
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In
Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03,
mute=0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In
Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03,
mute=0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x07
Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In
Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-In vals:  [0x80] [0x80]
  Amp-Out caps: ofs=0x23, nsteps=0x41, stepsize=0x03,
mute=0
  Amp-Out vals:  [0x28]
  Connection: 2
     0x02 0x07
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x0121411f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x08
Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x09
Node 0x11 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0xb7031110: [Fixed] Line Out at Oth
Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0a
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0xb7a31130: [Fixed] Mic at Oth Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0b
Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x0c
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0xc1811c31: [Both] Line In at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x0d
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0xb7831133: [Fixed] Line In at Oth
Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0xb7831132: [Fixed] Line In at Oth
Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x0814: OUT Detect
  Pin Default 0xb7431120: [Fixed] SPDIF Out at Oth
Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x19 [Pin Complex] wcaps 0x400280: Mono Digital
  Pincap 0x0824: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x1a [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x1b [Volume Knob Widget] wcaps 0x600080: Mono

Regards,
Val


		
__________________________________ 
Yahoo! Movies - Search movie info and celeb profiles and photos. 
http://sg.movies.yahoo.com/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
