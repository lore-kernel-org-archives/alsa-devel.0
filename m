From: noreply@alsa-project.org
Subject: [ALSA - driver 0000251]: No sound on emu10k1 with OSS emulation
Date: Fri, 16 Jul 2004 13:01:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110137.238B826008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 618F9244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:01:37 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000251
======================================================================
Reported By:                croiset
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     251
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Redhat 7.2
Kernel Version:             2.4.7-10
======================================================================
Date Submitted:             05-03-2004 14:44 CEST
Last Modified:              07-16-2004 13:01 CEST
======================================================================
Summary:                    No sound on emu10k1 with OSS emulation
Description: 
when I want to play a file with the oss emulation, the player is playing
correctly the mixer is OK but I have no sound on the output of the card.
This was working correctly on alsa-driver 0.9.0rc3
======================================================================

----------------------------------------------------------------------
 tiwai - 05-03-2004 18:33 CEST 
----------------------------------------------------------------------
please explain more details.

which OSS apps?
any other blocking process like sound daemon?
do you get sounds from ALSA native apps?

----------------------------------------------------------------------
 croiset - 05-03-2004 18:51 CEST 
----------------------------------------------------------------------
I use nas http://radscan.com/nas.html

I didn't test with native alsa apps, because we only use the oss
emulation. We use the analog output.

For your information the intel8x0 was not working with oss emulation (no
sound) and now with 1.0.4 the problem is solved for me.

The card is:
0 [card0          ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! at 0x8400, irq 10

There is no deamon which block the device except nas when we launch it
:-).

----------------------------------------------------------------------
 tiwai - 05-03-2004 19:02 CEST 
----------------------------------------------------------------------
try aplay to play something whether you get sounds.
if it's silent, it must be a problem of mixer configuration.

----------------------------------------------------------------------
 croiset - 05-05-2004 13:46 CEST 
----------------------------------------------------------------------
It's impossible to me to makes this test, because the production machine
don't have aplay.
But when I make this with trhe 1.0.4 : cat /proc/asound/card0/oss_mixer
VOLUME "Master" 0
BASS "Tone Control - Bass" 0
TREBLE "Tone Control - Treble" 0
SYNTH "Music" 0
PCM "PCM" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "Wave" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "Aux" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958 Coaxial" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "Phone" 0
PHONEOUT "Master Mono" 0
VIDEO "Video" 0
RADIO "" 0
MONITOR "" 0
-----------------

But when I use xmixer the PCM and the Master volume are not at 0.


-----------------
cat /proc/asound/card0/emu10k1
EMU10K1

Card                  : Creative
Internal TRAM (words) : 0x2000
External TRAM (words) : 0x8000

Effect Send Routing   : A=0, B=1, C=2, D=3

Captured FX Outputs   :
  Output 00 [PCM Left]
  Output 12 [MIDI Reverb]

All FX Outputs        :
  Output 00 [PCM Left]
  Output 01 [PCM Right]
  Output 02 [PCM Surround Left]
  Output 03 [PCM Surround Right]
  Output 04 [MIDI Left]
  Output 05 [MIDI Right]
  Output 06 [PCM Center]
  Output 07 [PCM LFE]
  Output 08 [???]
  Output 09 [???]
  Output 10 [???]
  Output 11 [???]
  Output 12 [MIDI Reverb]
  Output 13 [MIDI Chorus]
  Output 14 [???]
  Output 15 [???]
  Output 16 [???]
  Output 17 [???]
  Output 18 [ADC Left / CDROM S/PDIF Left]
  Output 19 [ADC Right / CDROM S/PDIF Right]
  Output 20 [MIC / Zoom Video Left]
  Output 21 [Zoom Video Right]
  Output 22 [S/PDIF Left]
  Output 23 [S/PDIF Right]
  Output 24 [???]
  Output 25 [???]
  Output 26 [???]
  Output 27 [???]
  Output 28 [???]
  Output 29 [???]
  Output 30 [???]
  Output 31 [???]

S/PDIF Output 0
Professional Mode     : no
Not Audio Data        : no
Copyright             : yes
Emphasis              : none
Mode                  : 0
Category Code         : 0x12
Generation Status     : original
Source Mask           : 0
Channel Number        : left
Sample Rate           : 48000Hz
Clock Accuracy        : 1000ppm

S/PDIF Output 1
Professional Mode     : no
Not Audio Data        : no
Copyright             : yes
Emphasis              : none
Mode                  : 0
Category Code         : 0x12
Generation Status     : original
Source Mask           : 0
Channel Number        : left
Sample Rate           : 48000Hz
Clock Accuracy        : 1000ppm

S/PDIF Output 2/3
Professional Mode     : no
Not Audio Data        : no
Copyright             : yes
Emphasis              : none
Mode                  : 0
Category Code         : 0x12
Generation Status     : original
Source Mask           : 0
Channel Number        : left
Sample Rate           : 48000Hz
Clock Accuracy        : 1000ppm

CD-ROM S/PDIF
Professional Mode     : yes
Not Audio Data        : yes
Copyright             : yes
Emphasis              : 7
Mode                  : 3
Category Code         : 0x7f
Generation Status     : original
Source Mask           : 15
Channel Number        : 15
Sample Rate           : 15Hz
Clock Accuracy        : unknown
S/PDIF Locked         : off
Rate Locked           : off
Estimated Sample Rate : 0x0

General purpose S/PDIF
Professional Mode     : yes
Not Audio Data        : yes
Copyright             : yes
Emphasis              : 7
Mode                  : 3
Category Code         : 0x7f
Generation Status     : original
Source Mask           : 15
Channel Number        : 15
Sample Rate           : 15Hz
Clock Accuracy        : unknown
S/PDIF Locked         : off
Rate Locked           : off
Estimated Sample Rate : 0x0

Zoomed Video
Rate Locked           : off
Estimated Sample Rate : 0x0
---------------

----------------------------------------------------------------------
 tiwai - 05-05-2004 13:55 CEST 
----------------------------------------------------------------------
hmm, no other ALSA application at all?

how can you set up the ALSA mixer setting?
OSS mixer emulation isn't enough sometimes.

anyway, attach the content of /etc/asound.state if you have.
the files above don't help much...

----------------------------------------------------------------------
 croiset - 05-05-2004 15:02 CEST 
----------------------------------------------------------------------
I found what was happened.

The file /etc/modules.conf was not correctly configured !! when I clean it
and and reload correctly the modules everything is OK on 1.0.4.

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss <<<<this line was missing
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-4 snd-pcm-oss <<<<this line was exist
alias sound-service-0-5 snd-pcm-oss <<<<this line was exist
alias sound-service-0-8 snd-seq-oss <<<<this line was missing
alias sound-service-0-12 snd-pcm-oss

The bug could be closed.

sorry.

----------------------------------------------------------------------
 tiwai - 05-05-2004 15:06 CEST 
----------------------------------------------------------------------
ok now closing this bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-03-04 14:44 croiset        New Bug                                      
05-03-04 14:44 croiset        Distribution              => Redhat 7.2      
05-03-04 14:44 croiset        Kernel Version            => 2.4.7-10        
05-03-04 18:33 tiwai          Bugnote Added: 0001027                       
05-03-04 18:51 croiset        Bugnote Added: 0001028                       
05-03-04 19:02 tiwai          Bugnote Added: 0001031                       
05-05-04 13:46 croiset        Bugnote Added: 0001055                       
05-05-04 13:55 tiwai          Bugnote Added: 0001056                       
05-05-04 15:02 croiset        Bugnote Added: 0001057                       
05-05-04 15:06 tiwai          Bugnote Added: 0001058                       
05-05-04 15:06 tiwai          Assigned To               => tiwai           
05-05-04 15:06 tiwai          Resolution               open => not a bug   
05-05-04 15:06 tiwai          Status                   new => resolved     
07-16-04 13:01 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
