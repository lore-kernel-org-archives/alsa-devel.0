From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000758]: Full duplex is not working in OSS emulation.
Date: Wed, 14 Sep 2005 16:16:46 +0200
Message-ID: <5f23ba12048a7f96f75f442eccf60905@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D02071A3
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:16:46 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000521.
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
Last Modified:              09-14-2005 16:16 CEST
======================================================================
Summary:                    Full duplex is not working in OSS emulation.
Description: 
If I play something with one player, I am unable to record something on the
same device.
The same thing ispossible with the other cards I have.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000521 Jack + Alsa not working in full duplex,...
======================================================================

----------------------------------------------------------------------
 tiwai - 12-29-04 14:17 
----------------------------------------------------------------------
I guess the first OSS app opens the file with O_RW?

----------------------------------------------------------------------
 croiset - 12-29-04 14:54 
----------------------------------------------------------------------
I use nas for playing. This application open the device in write mode
only.

cf nas.conf option : readwrite "no"  # for open(device, O_WRONLY|O_SYNC,
0666);
This exact configuration is working with all cards I have except the RME
96/8.

The recorder open the device like that : open(_opt->device,
O_RDONLY|O_NONBLOCK )

----------------------------------------------------------------------
 tiwai - 12-29-04 17:39 
----------------------------------------------------------------------
Hmm, I don't see problems in rme96.c.
Could you check whether the devices are really opened in O_WRONLY and
O_RDONLY?  Maybe strace can show better.
Also, you can check /proc/asound/card0/pcm*/sub0/* files as the current
state, too.

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
subname: subdevice #0
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
 croiset - 12-29-04 18:18 
----------------------------------------------------------------------
I forget one important i think. NAS use the dsp in playback mode I don't
record anything (PS : I want to record in analog mode).

# cat /proc/asound/card0/pcm0p/sub0/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Digi96 IEC958
name: Digi96 IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0



----------------------------------------------------------------------
 croiset - 01-03-05 16:30 
----------------------------------------------------------------------
I made some more tests and the error after an ioctl.

line_fd = open(_opt->device, O_RDONLY|O_NONBLOCK )
-> ok
fcntl(line_fd,F_SETFD,FD_CLOEXEC)
-> ok
ioctl(line_fd, SNDCTL_DSP_SETFRAGMENT, &frag)
-> ok
ioctl(line_fd, SNDCTL_DSP_SETFMT, &afmt)
-> return -1 errno = 16 (Device or resource busy)
ioctl(line_fd, SNDCTL_DSP_CHANNELS,    &channels)
-> return -1 errno = 16 (Device or resource busy)
ioctl(line_fd, SNDCTL_DSP_SPEED,       &rate)
-> return -1 errno = 16 (Device or resource busy)
read(line_fd, audio_data, size)
-> return -1 errno = 16 (Device or resource busy)

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
12-29-04 18:05 croiset        Note Edited: 0003006                         
12-29-04 18:18 croiset        Note Edited: 0003006                         
01-03-05 16:30 croiset        Note Added: 0003067                          
09-14-05 16:16 jdthood        Relationship added       related to 0000521  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
