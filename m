From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000758]: Full duplex is not working in OSS emulation.
Date: Wed, 29 Dec 2004 17:59:33 +0100
Message-ID: <4e7a1df9d02f294a34f55cc1e08a6c9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E7D214C
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 17:59:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=758> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   758
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Redhat 7.2
Kernel Version:             2.4.7
======================================================================
Date Submitted:             12-29-2004 10:15 CET
Last Modified:              12-29-2004 17:59 CET
======================================================================
Summary:                    Full duplex is not working in OSS emulation.
Description: 
If I play something with one player, I am unable to record something on the
same device.
The same thing ispossible with the other cards I have.
======================================================================

----------------------------------------------------------------------
 croiset - 12-29-04 17:56 
----------------------------------------------------------------------
For the RO and WO only I am sure because I play and record via a symlink,
so I change the symlink to a new card and restart the two processes and it
works ! For the recorder and nas I am sure, I verify in my logs in the
debug mode.

I have this kind of information (if you need some more information do not
hesitate :

# cat /proc/asound/card0/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 512
buffer_size: 16384
tick_time: 10000
OSS format: S16_LE
OSS channels: 2
OSS rate: 44100
OSS period bytes: 2048
OSS periods: 32
OSS period frames: 512

------------
# cat /proc/asound/card0/pcm0p/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 1
xfer_align: 1
start_threshold: 1
stop_threshold: 16384
silence_threshold: 528
silence_size: 528
boundary: 1073741824

--------------
# cat /proc/asound/card0/pcm0c/sub0/hw_params
closed

--------------
# cat /proc/asound/card0/pcm0c/sub0/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: Digi96 IEC958
name: Digi96 IEC958
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

------------------------
# cat /proc/asound/card0/pcm0c/sub0/sw_params
closed

------------------------
# cat /proc/asound/card0/pcm0c/sub0/status
closed

----------------------------------------------------------------------
 croiset - 12-29-04 17:59 
----------------------------------------------------------------------
I forget one important i think.

# cat /proc/asound/card0/pcm0p/sub0/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Digi96 IEC958
name: Digi96 IEC958
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 10:15 croiset        New Issue                                    
12-29-04 10:15 croiset        Distribution              => Redhat 7.2      
12-29-04 10:15 croiset        Kernel Version            => 2.4.7           
12-29-04 14:17 tiwai          Note Added: 0002998                          
12-29-04 14:54 croiset        Note Added: 0003000                          
12-29-04 17:39 tiwai          Note Added: 0003004                          
12-29-04 17:56 croiset        Note Added: 0003005                          
12-29-04 17:59 croiset        Note Added: 0003006                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
