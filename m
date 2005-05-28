From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000724]: No apparent support for Creative Sounblaster 24 bit.
Date: Sat, 28 May 2005 20:02:53 +0200
Message-ID: <87d087b58a124c44295addfe18fa19c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A99F1F0
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 20:02:53 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=724> 
======================================================================
Reported By:                sjberryman
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   724
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core1, Core2 and Suse 9.2
Kernel Version:             2.6.9 2.4.28 2.6.8
======================================================================
Date Submitted:             12-13-2004 09:21 CET
Last Modified:              05-28-2005 20:02 CEST
======================================================================
Summary:                    No apparent support for Creative Sounblaster 24 bit.
Description: 
No apparent support for Creative Sounblaster 24 bit.

Fedora does not find any sound device.

Susi finds a device but can't activate it.
======================================================================

----------------------------------------------------------------------
 pzad - 12-13-04 10:07 
----------------------------------------------------------------------
Support for SB Live 24 bit was added to ALSA only recently and is available
only in ALSA CVS. Only analog outputs work for now.

----------------------------------------------------------------------
 sjberryman - 01-19-05 09:08 
----------------------------------------------------------------------
I have tested the last three driver releases 1.0.8rc1 1.0.8rc2  1.0.8 from
the alsa project.
The SB live 24 bit card was detected on boot but did not work when
detection attempted by the Fedora core2 system-config-soundcard.

The output was 

The following audio device was detected

Vendor: Creative Labs
Model: SB Audigy LS
Module: snd-ca0106


Tested with 2.6.9-1.11_FC2smp and 2.6.9-1.6_FC2smp

----------------------------------------------------------------------
 tiwai - 01-19-05 14:27 
----------------------------------------------------------------------
If you get an entry in /proc/asound/cards after loading snd-ca0106, it
means that ALSA is basically working.  The other is the problem of Fedora.

----------------------------------------------------------------------
 nadavkav - 01-22-05 22:15 
----------------------------------------------------------------------
I'm using fc3 (devel), i got the 1.0.8 versions from cvs , compiled,
installed , loaded the module (alsaconf - configured it) and i have it
working.
actually... partially.

i looked into the sources (ca0106.c) and saw that recording/midi/other
features are not implemented yet. it is only playbacking.

i'd like to help make it work so i emailed the developer (james) that i
wish to help. 

 :-)

----------------------------------------------------------------------
 fmoraes - 01-22-05 23:20 
----------------------------------------------------------------------
If you want to add MIDI support, you can try adapting the code in the
emu10k1x.c driver, which should be very similar to the ca0106 driver.

----------------------------------------------------------------------
 Kane32 - 01-25-05 22:39 
----------------------------------------------------------------------
Aparently only 48.000Hz output works properly with this card (with 44.000Hz
the sound is stuttering), is this going to be fixed soon?
It would also be nice to use all speakers from my 7.1-soundsystem, will
this be implemented?

----------------------------------------------------------------------
 nadavkav - 01-26-05 13:18 
----------------------------------------------------------------------
i was emailing with james (who wrote the driver); and he wrote to me that
the mic/line-in and midi is not going to be implemented soon because the
info he got from creative is not enough to figure it all out.

----------------------------------------------------------------------
 sHINOBI - 02-08-05 23:32 
----------------------------------------------------------------------
Hello, I have K8N SLI Platinum motherboard with integrated SB Live 24 bit.
I tried the drivers 1.0.8, but with no luck. There is a following log in
messages:

kernel: AC'97 0 does not respond - RESET
kernel: AC'97 0 access is not valid [0x0], removing mixer.
kernel: CA0106: probe of 0000:01:0d.0 failed with error -5

Does anyone has an idea what should be wrong or how can I debug it
further?

I use Fedora Core 3 and the latest devel kernel. The soundcard is detected
(the same way as sjberryman) but /proc/asound/cards is empty.

----------------------------------------------------------------------
 pzad - 02-09-05 07:25 
----------------------------------------------------------------------
This card probably doesn't have AC97 too.
Search ca0106 driver for line
if ((chip->serial != 0x10061102) && (chip->serial != 0x10071102) ) { /*
The SB0410 and SB0413 do not have an ac97 chip. */

and add chip->serial of your card there too.

----------------------------------------------------------------------
 sHINOBI - 02-09-05 08:57 
----------------------------------------------------------------------
Errm, to be honest I'm not sure with the chip->serial number. I guess it
should be listed with lspci -nvv command. Relevant part is:

01:0d.0 Class 0401: 1102:0007
        Subsystem: 1462:1009
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at de00 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

BTW should be the James notified about this card?

----------------------------------------------------------------------
 sjberryman - 05-28-05 16:06 
----------------------------------------------------------------------
I have once again tested the latest alsa driver release 1.0.9 with FC3
kernel  2.6.11-1.27_FC3 on a Dell 


Tried to set it up according to the instructions in the soundcards link.

When I run the config-system-sound utility I get 

"
amixer: Unable to find simple control 'Master',0

amixer: Unable to find simple control 'PCM',0

Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin (-Dplug:hw:0,0)
"

When I try to play an mp3 file using mpg321 I get

"
Playing MPEG stream from two_out_of_three_aint_bad.mp3 ...
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
"

and of course I still get no sound.


The /proc/asound/cards file contains

0 [CA0106         ]: CA0106 - CA0106
                     Live! 7.1 24bit [SB0413] at 0xc8e0 irq 3



Is this card really supported as indicated by the alsa souncards list?
Am I doing something wrong?

How can I fix it or get more information so someone can?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-13-04 09:21 sjberryman     New Issue                                    
12-13-04 09:21 sjberryman     Distribution              => Fedora Core1, Core2
and Suse 9.2
12-13-04 09:21 sjberryman     Kernel Version            => 2.6.9 2.4.28 2.6.8
12-13-04 09:26 sjberryman     Issue Monitored: sjberryman                    
12-13-04 10:07 pzad           Note Added: 0002821                          
12-16-04 18:28 tiwai          Status                   new => resolved     
12-16-04 18:28 tiwai          Resolution               open => not an issue
12-16-04 18:28 tiwai          Assigned To               => tiwai           
12-16-04 18:28 tiwai          Assigned To              tiwai =>            
01-19-05 09:08 sjberryman     Status                   resolved => feedback
01-19-05 09:08 sjberryman     Resolution               not an issue => reopened
01-19-05 09:08 sjberryman     Note Added: 0003263                          
01-19-05 14:27 tiwai          Note Added: 0003266                          
01-22-05 22:15 nadavkav       Note Added: 0003379                          
01-22-05 23:20 fmoraes        Note Added: 0003381                          
01-25-05 22:39 Kane32         Note Added: 0003411                          
01-26-05 13:18 nadavkav       Note Added: 0003416                          
02-08-05 23:26 sHINOBI        Issue Monitored: sHINOBI                     
02-08-05 23:32 sHINOBI        Note Added: 0003534                          
02-09-05 07:25 pzad           Note Added: 0003535                          
02-09-05 08:57 sHINOBI        Note Added: 0003536                          
02-09-05 13:25 nadavkav       Issue Monitored: nadavkav                    
02-09-05 13:25 nadavkav       Issue End Monitor: nadavkav                    
05-28-05 16:06 sjberryman     Note Added: 0004774                          
05-28-05 20:02 jcdutton       Status                   feedback => assigned
05-28-05 20:02 jcdutton       Assigned To               => jcdutton        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
