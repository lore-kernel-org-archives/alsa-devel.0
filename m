From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000354]: Line-In Dead - Setting "Default PhoneJacks" in Linux
Date: Fri, 24 Sep 2004 13:33:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113334.032C5101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 44BA8208
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:35:09 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000354
======================================================================
Reported By:                Quantum
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     354
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             Gentoo-2.6.5-r1
======================================================================
Date Submitted:             06-30-2004 20:35 CEST
Last Modified:              09-24-2004 13:33 CEST
======================================================================
Summary:                    Line-In Dead - Setting "Default PhoneJacks" in Linux
Description: 
Another full day of research. 
 
 It's clear now that my mobo (MSI6712 KT4V Via8235) has several audio
modes. If the optional S-panel is added, front speakers are the normal
Line-Out and the others are on the S-panel. I do not have the S-panel
though, and only need 2 channels and LineIn. LineIn is silent; really need
this for recording. 
 
 There's a mode MSI calls "Default Phonejack". If enabled, the built-in
jacks Mic/LineIn/LineOut are what you'd expect. If disabled though,
LineOut is normal, LineIn is RearOut (4-channel) and Mic is sub/center
(6-channel). 
 
 Since my Mic and LineOut work but LineIn does not, it appears the mobo
defaults to 4 channel, NON-Default Phonejack. So I must set that Default
Phonejack bit in order to get LineIn; I'm sure it's a register setting in
the mobo. 
 
 All that appears to do that is a Winduhs utility, only for Winduhs. 
 
 Tried all Alsa dxs_support options (only clean up the intermod
distortion?) and ac97_quirk options (incl. 4) to no avail.. Sound out is
fine; But I need to feed in sound through LineIn. 
 
 Can you advise? 
======================================================================

----------------------------------------------------------------------
 Quantum - 06-30-2004 21:13 CEST 
----------------------------------------------------------------------
More: in alsamixer, Line is the only capture device.  I can control volume
of Surround, Center, and Line, but not Line In.  Nothing is muted.

So it seems clear that I am in 4-speaker mode ("Default Phonejack").

----------------------------------------------------------------------
 Quantum - 06-30-2004 21:31 CEST 
----------------------------------------------------------------------
# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650 rev 2

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz
SPDIF In Status  : Not Locked
#

# cat /proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 = 5980
0:02 = 0505
0:04 = 0000
0:06 = 0005
0:08 = 0000
0:0a = 0004
0:0c = 0006
0:0e = 0045
0:10 = 0506
0:12 = 0505
0:14 = 0505
0:16 = 0505
0:18 = 0606
0:1a = 0404
0:1c = 8000
0:1e = 0000
0:20 = 2000
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 05c7
0:2a = 05c5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = 0000
0:36 = 0605
0:38 = 0505
0:3a = 0824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 520f
0:6c = 0000
0:6e = 0014
0:70 = 0211
0:72 = 00a0
0:74 = 0043
0:76 = 0001
0:78 = 8102
0:7a = 57c7
0:7c = 414c
0:7e = 4720
#

----------------------------------------------------------------------
 pzad - 07-01-2004 09:40 CEST 
----------------------------------------------------------------------
mute this "Duplicate Front"
mute this "Line-In As Surround"

----------------------------------------------------------------------
 Quantum - 07-01-2004 17:02 CEST 
----------------------------------------------------------------------
Oh my gosh, it works!  Thank you.

Apparently alsamixer actually controls the hardware, and not just the
driver?

People are buying seperate soundcards instead of using on-board sound
because of this problem.  I'll advise Gentoo users, at least.

edited on: 07-01-04 17:02

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 20:35 Quantum        New Bug                                      
06-30-04 20:35 Quantum        Distribution              => Gentoo          
06-30-04 20:35 Quantum        Kernel Version            => Gentoo-2.6.5-r1 
06-30-04 21:13 Quantum        Bugnote Added: 0001365                       
06-30-04 21:27 Quantum        File Added: asound.state                     
06-30-04 21:31 Quantum        Bugnote Added: 0001366                       
07-01-04 09:40 pzad           Bugnote Added: 0001369                       
07-01-04 16:28 Quantum        Bugnote Added: 0001371                       
07-01-04 17:02 Quantum        Bugnote Edited: 0001371                      
07-02-04 14:29 pzad           Assigned To               => pzad            
07-02-04 14:29 pzad           Resolution               open => not a bug   
07-02-04 14:29 pzad           Status                   new => resolved     
09-24-04 13:33 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
