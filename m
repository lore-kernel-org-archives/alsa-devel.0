From: noreply@alsa-project.org
Subject: [ALSA - driver 0000155]: Crackly / sizzly recording on VIA VT82C686 AC97 since 2.6.3
Date: Fri, 16 Jul 2004 12:45:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104558.EC53D26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5790D255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:45:59 +0200 (MEST)
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


The following bug has been REOPENED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000155
======================================================================
Reported By:                sim
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     155
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Debian unstable
Kernel Version:             2.6.3 through 2.6.5-rc2
======================================================================
Date Submitted:             03-24-2004 06:03 CET
Last Modified:              07-16-2004 12:45 CEST
======================================================================
Summary:                    Crackly / sizzly recording on VIA VT82C686 AC97 since 2.6.3
Description: 
Hello,

I have a mythtv box set up and recently upgraded the kernel from
2.6.0-test9 to 2.6.4.  Everything appeared to play normally, but new
recordings since the upgrade all sound crackly.  2.6.5-rc2 and 2.6.3 also
seem to be broken.  2.6.2 works as expected.

There appear to be a large number of changes to the ALSA core between
2.6.2 and 2.6.3.  How should I attempt to track the problem down further?

Athlon 1800 XP, MSI K7 Master (MS-6330), 48 KHz stereo recording and
playback.  The problem also shows up with Audacity, and as such does not
appear to be application specific.  I can send a sample of the poor sound
recording upon request.
======================================================================

----------------------------------------------------------------------
 m9715936 - 04-10-2004 10:13 CEST 
----------------------------------------------------------------------
I upgraded from kernel 2.6.2 to 2.6.5 and I'm having the same problem.
Whenever I record something, with sox or mencoder for example, the result
sounds crackly, like listening to an fm-station not tuned in correctly.

a sample can be found at :

http://chef.studentenweb.org/public/radio2004_04_07-18_15_22.mp3

(and I tested al kinds of different mixer settings)

MSI K7T Turbo MB, VIA VT82C686B Chipset, using Mandrake 9.2 (+ cooker)

hope this can be fixed soon,

Dominique De Munck

edited on: 04-10-04 10:13

----------------------------------------------------------------------
 uli - 04-11-2004 19:28 CEST 
----------------------------------------------------------------------
Hello,

the same problem appears to me. Related to kernel 2.4.22 in alsa drivers
0.9.8 everthing works fine while in 1.0.0pre3 recordings create crack
noises.

Records are made with both broadcast2000 and audacity.

Mainboard MSI K7T Pro (MS-6330) with onboard VT82C686 AC97 Audio
Controller.


Regards,
Uli Flender

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:30 CEST 
----------------------------------------------------------------------
please check /proc/asound/card0/pcm0c/sub0/hw_params
and /proc/asound/card0/codec97#0/ac97#0-0 during the recording.

----------------------------------------------------------------------
 m9715936 - 04-23-2004 18:02 CEST 
----------------------------------------------------------------------
the requested information: 

cat /proc/asound/card0/pcm0c/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 32000 (32000/1)
period_size: 2048
buffer_size: 16384
tick_time: 1000
OSS format: S16_LE
OSS channels: 2
OSS rate: 32000
OSS period bytes: 8192
OSS periods: 8
OSS period frames: 2048

cat  /proc/asound/card0/codec97\https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000/ac97\https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000-0


0-0/0: ICEnsemble ICE1232

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : IC Ensemble/KS Waves

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 32000Hz


as an extra, some more information with a 2.6.2 kernel
http://chef.studentenweb.org/public/viaRecordingBug/viaRecordingOutput262.txt

----------------------------------------------------------------------
 tiwai - 04-23-2004 18:07 CEST 
----------------------------------------------------------------------
thanks, the hardware configuration seems ok.  both the ADC rate and
hw_params values match.

does the noise appear also when you run record via arecord (i.e.
ALSA native app)?

----------------------------------------------------------------------
 m9715936 - 04-23-2004 18:36 CEST 
----------------------------------------------------------------------
no, than the recording is ok !

Dominique

----------------------------------------------------------------------
 tiwai - 04-23-2004 18:40 CEST 
----------------------------------------------------------------------
then it's likely a bug of OSS emulation.
please make sure that the same condition (32kHz) works with arecord.
check /proc/asound...hw_params again.

----------------------------------------------------------------------
 m9715936 - 04-23-2004 18:59 CEST 
----------------------------------------------------------------------
yes, 32 khz no problem with arecord. The noise also appears at 48khz
with oss, I checked that before.
while "arecord -f S16_LE -c2 -r 32000 > alsa32khz.wav"

cat /proc/asound/card0/pcm0c/sub0/hw_params 
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 32000 (32000/1)
period_size: 4000
buffer_size: 16000
tick_time: 1000

----------------------------------------------------------------------
 sim - 06-13-2004 11:32 CEST 
----------------------------------------------------------------------
I have uploaded "patch-2.6.3-rc1-try2.11.works" which are two hunks of
patch-2.6.3-rc1 which cause the problem to occur.  Reverse-applying this
patch to 2.6.3-rc1 (or 2.6.7-rc3, for that matter) cures the crackly sound
problem.

The actual change appears to be nonsensical, at least from what I can make
from it.  Was there an intent to make "avail_min" be a number of periods
in period_size but only partially modified?

Anyway, the bug should be relatively easy to fix at this point.

----------------------------------------------------------------------
 uli - 06-20-2004 11:41 CEST 
----------------------------------------------------------------------
Hello,

reverse-applying of patch-2.6.3-rc1-try2.11.works, as in my case in kernel
2.6.7, indeed cures the problem.

Thanks + regards
Uli

----------------------------------------------------------------------
 tiwai - 07-16-2004 12:45 CEST 
----------------------------------------------------------------------
Something wrong in oss emulation...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-24-04 06:03 sim            New Bug                                      
03-24-04 06:03 sim            Distribution              => Debian unstable 
03-24-04 06:03 sim            Kernel Version            => 2.6.3 through 2.6.5-rc2
04-08-04 15:15 m9715936       Bug Monitored: m9715936                      
04-08-04 15:25 m9715936       Bugnote Added: 0000767                       
04-08-04 15:29 m9715936       Bugnote Edited: 0000767                      
04-10-04 10:13 m9715936       Bugnote Edited: 0000767                      
04-11-04 19:28 uli            Bugnote Added: 0000780                       
04-23-04 17:29 tiwai          Assigned To               => tiwai           
04-23-04 17:29 tiwai          Status                   new => assigned     
04-23-04 17:30 tiwai          Bugnote Added: 0000907                       
04-23-04 18:02 m9715936       Bugnote Added: 0000913                       
04-23-04 18:07 tiwai          Bugnote Added: 0000914                       
04-23-04 18:36 m9715936       Bugnote Added: 0000915                       
04-23-04 18:40 tiwai          Bugnote Added: 0000916                       
04-23-04 18:59 m9715936       Bugnote Added: 0000917                       
06-13-04 11:27 sim            File Added: patch-2.6.3-rc1-try2.11.works                    
06-13-04 11:32 sim            Bugnote Added: 0001303                       
06-20-04 11:41 uli            Bugnote Added: 0001324                       
06-22-04 18:41 tiwai          Resolution               open => fixed       
06-22-04 18:41 tiwai          Status                   assigned => resolved
07-16-04 12:45 tiwai          Bugnote Added: 0001450                       
07-16-04 12:45 tiwai          Resolution               fixed => reopened   
07-16-04 12:45 tiwai          Status                   resolved => feedback
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
