From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000014]: No sound from external speakers (laptop)
Date: Mon, 21 Feb 2005 09:16:28 +0100
Message-ID: <69586d6559796a473ed28cb32aceb674@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 05355161
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 09:16:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14> 
======================================================================
Reported By:                user74
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   14
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sid updated
Kernel Version:             2.4.24-ck1
======================================================================
Date Submitted:             01-29-2004 20:15 CET
Last Modified:              02-21-2005 09:16 CET
======================================================================
Summary:                    No sound from external speakers (laptop)
Description: 
On my laptop (acer272xv) I can't use external output with my Creative 2.1,
because I can't hear anything.
I've tryied with other external speaker and with other releases of
alsa-driver, but there's no difference.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000664 ac97_quirk with SIS 7012 [ALC202] don't...
======================================================================

----------------------------------------------------------------------
 jorge2 - 02-04-05 18:03 
----------------------------------------------------------------------
I've tried your patch on top of 2.6.11-rc2-mm2-vivid1 patchset but there're
no good news: sound didn't work with external speakers.
Here is the output for files in /proc:
************************
[/proc/asound/card0/codec97#0/ac97#0-0]
0-0/0: Realtek ALC202 rev 0

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : Mic
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz
************************

[/proc/asound/card0/codec97#0/ac97#0-0+regs]

************************

0:00 = 5980
0:02 = 0707
0:04 = 0000
0:06 = 001f
0:08 = 0000
0:0a = 001e
0:0c = 0015
0:0e = 000e
0:10 = 1111
0:12 = 1212
0:14 = 0a0a
0:16 = 0707
0:18 = 0808
0:1a = 0505
0:1c = 0505
0:1e = 0000
0:20 = 2200
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0607
0:2a = 05c5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = 0000
0:36 = 8080
0:38 = 8080
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
0:6a = 0000
0:6c = 0000
0:6e = 0003
0:70 = 0211
0:72 = 6aa9
0:74 = 0063
0:76 = 0000
0:78 = 0003
0:7a = 57c4
0:7c = 414c
0:7e = 4740

Thanks a lot.

----------------------------------------------------------------------
 dale - 02-21-05 09:16 
----------------------------------------------------------------------
Hi tiwai,

Have tried the patch with 2.6.10-gentoo-r6 and unfortunately there is
still no output through the headphones.

thanks,

Dale

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-04 20:15 user74         New Issue                                    
01-29-04 20:15 user74         File Added: details.txt                      
01-30-04 12:44 tiwai          Note Added: 0000049                          
01-30-04 17:56 sparkyva       Note Added: 0000063                          
01-30-04 17:56 sparkyva       Issue Monitored: sparkyva                    
01-30-04 20:41 sparkyva       Note Added: 0000070                          
01-30-04 22:01 jorge2         Note Added: 0000071                          
02-02-04 19:37 jorge2         Note Added: 0000119                          
02-04-04 20:00 tiwai          Note Added: 0000165                          
02-04-04 20:01 tiwai          Note Added: 0000166                          
02-04-04 20:52 jorge2         Note Added: 0000169                          
02-04-04 20:52 jorge2         Note Added: 0000170                          
02-04-04 20:53 jorge2         Note Deleted: 0000169                        
02-05-04 13:52 matsgora       Note Added: 0000181                          
02-05-04 14:05 dale           Note Added: 0000182                          
02-26-04 13:07 rocco          Note Added: 0000347                          
02-26-04 18:16 matsgora       Note Added: 0000358                          
02-26-04 18:20 tiwai          Note Added: 0000359                          
03-01-04 10:31 dale           Note Added: 0000401                          
03-05-04 19:49 tiwai          Note Added: 0000513                          
03-05-04 20:37 jorge2         Note Added: 0000515                          
03-06-04 18:20 matsgora       Note Added: 0000520                          
03-07-04 16:30 dale           Note Added: 0000524                          
03-09-04 15:15 tiwai          Note Added: 0000547                          
03-09-04 18:12 matsgora       Note Added: 0000551                          
06-08-04 20:25 jorge2         Note Added: 0001296                          
06-15-04 15:00 mcbridematt    Note Added: 0001308                          
11-22-04 18:48 tiwai          Relationship added       has duplicate 0000664
02-02-05 14:25 dale           Note Added: 0003488                          
02-04-05 13:18 tiwai          Note Added: 0003504                          
02-04-05 13:19 tiwai          File Added: ac97-alc-fix.diff                    
02-04-05 18:03 jorge2         Note Added: 0003512                          
02-05-05 13:27 jorge2         Issue Monitored: jorge2                      
02-21-05 09:16 dale           Note Added: 0003678                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
