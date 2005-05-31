From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Tue, 31 May 2005 16:41:16 +0200
Message-ID: <abd5b6855a8686920c93f7bdd1a3d9f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 740C1186
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 16:41:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              05-31-2005 16:41 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 parente - 05-31-05 16:10 
----------------------------------------------------------------------
This is the result of "cat /proc/asound/card0/pcm0p/sub0/*" for alsa 1.0.9
final during gnome-speech playback with clipped output.

access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 11025 (11025/1)
period_size: 512
buffer_size: 16384
tick_time: 1000
OSS format: S16_LE
OSS channels: 1
OSS rate: 11025
OSS period bytes: 1024
OSS periods: 32
OSS period frames: 512
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Intel ICH
name: Intel ICH5
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
64
state: RUNNING
trigger_time: 1117548261.000456634
tstamp      : 1117548263.000204585
delay       : 16044
avail       : 340
avail_max   : 15883
-----
hw_ptr      : 19284
appl_ptr    : 35328
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

And here is the result of the cat command while running the same
gnome-speech test under alsa 1.0.9rc3 with Roger Mach's patch.

access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 11025 (11025/1)
period_size: 512
buffer_size: 16384
tick_time: 1000
OSS format: S16_LE
OSS channels: 1
OSS rate: 11025
OSS period bytes: 1024
OSS periods: 32
OSS period frames: 512
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Intel ICH
name: Intel ICH5
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
64
state: RUNNING
trigger_time: 1117548454.000182497
tstamp      : 1117548455.000644206
delay       : 11518
avail       : 4866
avail_max   : 15883
-----
hw_ptr      : 16130
appl_ptr    : 27648
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

----------------------------------------------------------------------
 perex - 05-31-05 16:41 
----------------------------------------------------------------------
Please, try oss-optr-fix3.patch . It should be the final and right fix.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-01-04 16:18 minmax         New Issue                                    
10-01-04 16:18 minmax         Distribution              => Debian unstable 
10-01-04 16:18 minmax         Kernel Version            => vanilla 2.6.7   
10-02-04 10:52 minmax         Issue Monitored: minmax                      
04-09-05 16:09 jdthood        Note Added: 0004406                          
04-09-05 16:22 minmax         Note Added: 0004410                          
05-13-05 15:20 gk4            Note Added: 0004646                          
05-13-05 15:24 perex          Note Added: 0004647                          
05-13-05 15:26 tiwai          Note Added: 0004648                          
05-13-05 19:35 gk4            Note Added: 0004651                          
05-13-05 19:38 tiwai          Note Added: 0004652                          
05-13-05 19:48 gk4            Note Added: 0004655                          
05-15-05 15:50 tiwai          Note Added: 0004663                          
05-16-05 16:08 gk4            Note Added: 0004676                          
05-19-05 15:28 parente        Note Added: 0004693                          
05-20-05 00:38 minmax         Note Added: 0004698                          
05-26-05 17:27 Roger Mach     Note Added: 0004738                          
05-27-05 10:56 perex          Note Added: 0004742                          
05-27-05 11:03 perex          File Added: fix2.patch                       
05-27-05 11:04 perex          Note Added: 0004743                          
05-27-05 15:41 parente        Note Added: 0004752                          
05-30-05 09:51 perex          Note Added: 0004798                          
05-31-05 14:04 parente        Note Added: 0004831                          
05-31-05 15:54 perex          Status                   new => assigned     
05-31-05 15:54 perex          Assigned To               => perex           
05-31-05 15:55 perex          Note Added: 0004833                          
05-31-05 16:10 parente        Note Added: 0004834                          
05-31-05 16:38 perex          File Added: oss-optr-fix3.patch                   

05-31-05 16:41 perex          Note Added: 0004837                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
