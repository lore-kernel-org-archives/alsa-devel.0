From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000666]: Simply no sound ... no line ... no mixer
Date: Sat, 11 Dec 2004 17:40:57 +0100
Message-ID: <2d9785caf90c1df58574f7d8484b0ce6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E97FD38B
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2004 17:40:57 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=666> 
======================================================================
Reported By:                footcow
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   666
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-23-2004 01:31 CET
Last Modified:              12-11-2004 17:40 CET
======================================================================
Summary:                    Simply no sound ... no line ... no mixer
Description: 
I have compiled the last release : 1.0.7 stable.
But I do not have any sound, no line ... no mixer ... :(

I have an AsusTek P5GD2 motherboard with lspci -v :
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 813d
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at cccf4000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70]
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 [0091]


The snd_azx module is well loaded :
lsmod : 
snd_azx                30920  1
snd_pcm                95112  1 snd_azx
snd_timer              25476  1 snd_pcm
snd                    54500  5 snd_azx,snd_pcm,snd_timer
snd_page_alloc         10120  1 snd_pcm

If I run alsamixer I get this :
$ alsamixer
No mixer elems found

If I run alsamixergui, I get 3 columns:
Line is emplty and can't change
Same for Mic
I can only move values for a third column called Capt.

======================================================================

----------------------------------------------------------------------
 footcow - 12-10-04 22:08 
----------------------------------------------------------------------
So to answer your first question:
I get this message in dmesg only with the starting script of Alsa from
Debian.
Seems to be something like : (I 'll not copy all the script except if you
need it)
alsactl restore 2>&1

So I have get the last CVS update. Hope all your patch were applied on
it.

In dmesg after start Linux I get this now :
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/azx.c:789: azx_pcm_prepare:
bufsize=0x79f4, fragsize=0x116c, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x6, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x6, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/azx.c:789: azx_pcm_prepare:
bufsize=0x79f4, fragsize=0x116c, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x6, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x6, stream=0x0, channel=0, format=0x0
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/azx.c:789: azx_pcm_prepare:
bufsize=0x79f4, fragsize=0x116c, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/azx.c:789: azx_pcm_prepare:
bufsize=0x79f4, fragsize=0x116c, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
ALSA /usr/src/alsa-cvs/alsa-driver/pci/azx/hda_codec.c:455:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11

Now Alsamixer is starting ...
I get this on the screen :
Card: ICH6 HDA                                                            
                                                                          
                                                      
Chip: C-Media CMI9880                                                     
                                                                          
                                                      
View: Playback                                                            
                                                                          
                                                      
Item: PCM                                                                 
                                                                          
                                                      

And 4 draw bars :
PCM
Surround
Center
LFE
+
2 Input So but without bar
I can't change any parameters anywhere.
If I go to Input So and change one parameter I get a Seg Fault.
I'll upload you a snapshot of what I get.

the contents of /proc/asound/card0/codec#0 have changed I have now :
Codec: C-Media CMI9880
Address: 0
Vendor Id: 0x434d4980
Subsystem Id: 0x0
Revision Id: 0x90002
Default PCM: rates 0x540, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x00 0x00
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x00 0x00
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x00 0x00
Node 0x06 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
Node 0x07 [Audio Output] wcaps 0x615: Stereo Digital Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
  PCM: rates 0x000, bits 0x00, types 0x5
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals: 0x80 0x80
  PCM: rates 0x160, bits 0x02, types 0x0
  Connection: 9
     0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x1f 0x20
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals: 0x80 0x80
  PCM: rates 0x160, bits 0x02, types 0x0
  Connection: 9
     0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x1f 0x20
Node 0x0a [Audio Input] wcaps 0x100791: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x0
  Connection: 1
     0x13
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01014010: Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x03
Node 0x0c [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01813000: Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x04
Node 0x0d [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01a19000: Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
  Connection: 1
     0x05
Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x081033f: IN OUT HP
  Pin Default 0x01011014: Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
    0x06
Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x82214100: HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x82a19100: Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0863: IN
  Pin Default 0x19330000: CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x12 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01450000: SPDIF Out at Ext Rear
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x07
Node 0x13 [Pin Complex] wcaps 0x400281: Stereo Digital
  Pincap 0x0830: IN OUT
  Pin Default 0x41150000: Speaker at Ext Rear
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x00:
Node 0x14 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x19 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01016012: Line Out at Ext Rear
    Conn = 1/8, Color = Orange
  Pin-ctls: 0xc0: OUT HP
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x20 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x01012016: Line Out at Ext Rear
    Conn = 1/8, Color = Grey
  Pin-ctls: 0x00:
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals: 0x0f

And ... I still do have any sound.
How can I help you then ?
I don't know if you could be interesting about this offer, but I can give
you an access to this PC from the Internet for making all the test you
need on it ! ... Just ask.

Thanks for your work !

----------------------------------------------------------------------
 tiwai - 12-11-04 17:40 
----------------------------------------------------------------------
The Oops with the Input is fixed in the very latest CVS.
There is no h/w playback volume on this codec chip!

To playback, make sure that you unmute the volume.  Press 'M' on the
corresponding volume.  "PCM" controls only the front output, BTW.  It
should be "Front", but named as "PCM" because many apps prefer this name.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 01:31 footcow        New Issue                                    
11-23-04 01:31 footcow        Distribution              => Debian          
11-23-04 01:31 footcow        Kernel Version            => 2.6.9           
11-23-04 21:49 footcow        Note Added: 0002530                          
12-08-04 19:54 tiwai          Note Added: 0002791                          
12-08-04 23:56 footcow        Note Added: 0002795                          
12-09-04 11:27 tiwai          Note Added: 0002799                          
12-09-04 11:33 tiwai          File Added: hda-query-fix.diff                    
12-09-04 11:34 tiwai          Note Added: 0002800                          
12-09-04 12:11 tiwai          Note Added: 0002801                          
12-09-04 12:12 tiwai          File Added: hda-loopback-fix.diff                 
  
12-09-04 12:12 tiwai          File Added: hda-proc-amp.diff                    
12-10-04 22:08 footcow        Note Added: 0002808                          
12-10-04 22:08 footcow        File Added: alsamix.png                      
12-11-04 17:40 tiwai          Note Added: 0002811                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
