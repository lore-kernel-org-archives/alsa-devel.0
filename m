From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000298]: Unable to play S/P-DIF or surround sound
Date: Mon, 4 Apr 2005 22:29:00 +0200
Message-ID: <5f9132fbd9c943d26c0c5fa7c219af0c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1265E1CF
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 22:29:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=298> 
======================================================================
Reported By:                bhess
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   298
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Suse 9.0
Kernel Version:             2.4.21-144
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-22-2004 21:14 CEST
Last Modified:              04-04-2005 22:29 CEST
======================================================================
Summary:                    Unable to play S/P-DIF or surround sound
Description: 
I'm trying to use spdif on my VIA EPIA-V board.
 
When I test with "./speaker-test -Dsurround51 -c 6"
I'm getting the message:
ALSA lib pcm.c:1851:(snd_pcm_open_conf) 
Invalid type for PCM surround51 definition (id: surround51, value:
cards.pcm.surround51)
Playback open error: Invalid argument


My setup (output from alsamixer):
Card: VIA 82C686A/B rev40
Chip: VIA Technologies VIA1612A                    

But this chip is built into the south bridge VT8231 of my VIA EPIA-V.


The info files look this way:
/proc/asound/card0/pcm0p/info   /proc/asound/card0/pcm0p/sub0/info        

card: 0                         card: 0                                   

device: 0                       device: 0                                 

subdevice: 0                    subdevice: 0                              

stream: PLAYBACK                stream: PLAYBACK                          

id: VIA 82C686A/B rev40         id: VIA 82C686A/B rev40                   

name: VIA 82C686A/B rev40       name: VIA 82C686A/B rev40                 

subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0     
     subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
                    

class: 0                        class: 0                                  

subclass: 0                     subclass: 0                               

subdevices_count: 1             subdevices_count: 1                       

subdevices_avail: 1             subdevices_avail: 1                       

                                                                          


It seems that alsa tries to open the definition file cards.VIA686A, which
is not
provided by alsa. When I add the line "VIA686A cards.VIA8233A" to
aliases.conf, 
the command

./speaker-test -Dsurround51 -c 2 

works fine.

Yet, the next command yields

./speaker-test -Dsurround51 -c 4
Playback device is surround51
Stream parameters are 44100Hz, S16_LE, 4 channels
Sine wave rate is 440.0000Hz
Channels count (4) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument


How can I fix this?

Cheers
Beat
======================================================================

----------------------------------------------------------------------
 tiwai - 05-27-04 11:47 
----------------------------------------------------------------------
could you try 1.0.5?

----------------------------------------------------------------------
 bhess - 05-28-04 19:51 
----------------------------------------------------------------------
It's working with 1.0.5rc1!

So far, I was able to play two channel output
./speaker-test -Dspdif -c2
Playback device is spdif
Stream parameters are 44100Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
period_size=1200, buffer_size=4800
  - Front Left
  - Front Right
  - Front Left




When I try 4 channels, I get 

./speaker-test -Dspdif -c4
Playback device is spdif
Stream parameters are 44100Hz, S16_LE, 4 channels
Sine wave rate is 440.0000Hz
Channels count (4) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument


I suppose this is a limit of my sound chip, isn't it?

Thanks for your help

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-04 21:14 bhess          New Issue                                    
05-22-04 21:14 bhess          Distribution              => Suse 9.0        
05-22-04 21:14 bhess          Kernel Version            => 2.4.21-144      
05-24-04 15:05 tiwai          Note Added: 0001186                          
05-24-04 21:50 bhess          Note Added: 0001197                          
05-25-04 12:43 tiwai          Note Added: 0001203                          
05-26-04 11:42 bhess          Note Added: 0001246                          
05-26-04 13:34 tiwai          Note Added: 0001250                          
05-26-04 19:54 bhess          Note Added: 0001260                          
05-27-04 11:47 tiwai          Note Added: 0001263                          
05-28-04 19:51 bhess          Note Added: 0001271                          
04-04-05 22:29 jdthood        Status                   new => resolved     
04-04-05 22:29 jdthood        Resolution               open => fixed       
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
