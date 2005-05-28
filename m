From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000724]: No apparent support for Creative Sounblaster 24 bit.
Date: Sat, 28 May 2005 20:07:11 +0200
Message-ID: <41beb4461c6966778f1513990bd9fccc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 93F311F6
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 20:07:11 +0200 (MEST)
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


The following issue requires your FEEDBACK.
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
Status:                     feedback
Distribution:               Fedora Core1, Core2 and Suse 9.2
Kernel Version:             2.6.9 2.4.28 2.6.8
======================================================================
Date Submitted:             12-13-2004 09:21 CET
Last Modified:              05-28-2005 20:07 CEST
======================================================================
Summary:                    No apparent support for Creative Sounblaster 24 bit.
Description: 
No apparent support for Creative Sounblaster 24 bit.

Fedora does not find any sound device.

Susi finds a device but can't activate it.
======================================================================

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

----------------------------------------------------------------------
 jcdutton - 05-28-05 20:07 
----------------------------------------------------------------------
The ca0106 is supported. And after alsa-driver 1.0.9, it will have capture
support as well.
It does not support the sample rate of 44100, so you have to resample it
to 48000 in order to play the sound.
Either use the alsa device "plug:front" so that alsa does the resampling
for you, or use an application that can resample the sound. e.g. xine.


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
05-28-05 20:07 jcdutton       Note Added: 0004775                          
05-28-05 20:07 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
