From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000789]: With AZX Sound card
Date: Tue, 11 Jan 2005 16:16:55 +0100
Message-ID: <4222041a49ee2064208022d267d70f7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E6082A9
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 16:16:55 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=789> 
======================================================================
Reported By:                footcow
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   789
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.10
Resolution:                 duplicate
Duplicate:                  666
Fixed in Version:           
======================================================================
Date Submitted:             01-07-2005 00:42 CET
Last Modified:              01-11-2005 16:16 CET
======================================================================
Summary:                    With AZX Sound card
Description: 
Since Alsa v1.0.8rc2 not in v1.0.7

Alsa Start but in my dmesg I get :

ALSA /usr/src/alsa-cvs/alsa-driver/acore/pcm_native.c:1872: BUG? (err >=
0) (called from f8b19f16)
ALSA /usr/src/alsa-cvs/alsa-driver/acore/pcm_native.c:2011:
snd_pcm_hw_constraints_complete failed

I think it's under KDE when the ARTS server start ... then I have no sound
unsing ALSA sound server neighter and OSS (same message when I switch the
sound server under KDE, each time my dmesg).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000666 Simply no sound ... no line ... no mixer
======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 17:52 
----------------------------------------------------------------------
Which card model do you have?  Show the output of /proc/asound/cards.
Also, attach the content of /proc/asound/card0/codec* file.

----------------------------------------------------------------------
 footcow - 01-08-05 00:44 
----------------------------------------------------------------------
more /proc/asound/cards
0 [HDA            ]: Azalia - ICH6 HDA
                     ICH6 HDA at 0xcccf4000 irq 16

less /proc/asound/card0/codec* 
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
  Amp-Out vals: 0x00 0x00
Node 0x07 [Audio Output] wcaps 0x615: Stereo Digital Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: 0x80 0x80
  PCM: rates 0x000, bits 0x00, types 0x5
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals: 0x96 0x96
  PCM: rates 0x160, bits 0x02, types 0x0
  Connection: 9
     0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x1f 0x20
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x1e, stepsize=0x05, mute=1
  Amp-In vals: 0x94 0x94
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
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x05
Node 0x0e [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x081033f: IN OUT HP
  Pin Default 0x01011014: Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
Node 0x0f [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x02214000: HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x10 [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0833f: IN OUT HP
  Pin Default 0x02a19000: Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
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
  Pin-ctls: 0xc0: OUT HP
  Connection: 4
     0x03 0x04 0x05 0x06
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals: 0x0f

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-05 00:42 footcow        New Issue                                    
01-07-05 00:42 footcow        Distribution              => Debian          
01-07-05 00:42 footcow        Kernel Version            => 2.6.10          
01-07-05 17:52 tiwai          Note Added: 0003103                          
01-08-05 00:44 footcow        Note Added: 0003124                          
01-11-05 16:16 tiwai          Relationship added       duplicate of 0000666
01-11-05 16:16 tiwai          Duplicate ID             0 => 666            
01-11-05 16:16 tiwai          Status                   new => resolved     
01-11-05 16:16 tiwai          Resolution               open => duplicate   
01-11-05 16:16 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
