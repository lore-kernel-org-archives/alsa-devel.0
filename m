From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000305]: sound is locked up after suspend/resume (APM)
Date: Tue, 22 Mar 2005 15:02:27 +0100
Message-ID: <3ef7844e765b3da3323b6cef812bc6a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B51AA287
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 15:02:27 +0100 (MET)
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


The issue 0000226 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305> 
======================================================================
Reported By:                klausr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   305
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             Debian kernel 2.6.5-4-686
======================================================================
Date Submitted:             05-25-2004 14:49 CEST
Last Modified:              01-17-2005 10:57 CET
======================================================================
Summary:                    sound is locked up after suspend/resume (APM)
Description: 
Until recently I was running oss driver cs46xx without a problem. I could
suspend in the middle of playback and xmms would keep playing after resume
as if nothing happend at all.
After switching to the 2.6 kernel, currently running 2.6.5, I also
switched to ALSA beeing the new sound architecture of choice.
Unforunately now when I suspend and resume my notebook sound stops working
at all. Sometimes unloading all ALSA modules helps, sometimes even that is
not possible anymore.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000226 Sound hangs after APM resume
======================================================================

----------------------------------------------------------------------
 tiwai - 05-25-04 15:02 
----------------------------------------------------------------------
try ALSA 1.0.5-rc1.

----------------------------------------------------------------------
 klausr - 05-25-04 15:31 
----------------------------------------------------------------------
Ups, I'm running Debian testing which should be Sarge and not Woody.

Will try 1.0.5-rc1. Do I need only the new kernel modules or also the
utils/libs etc.?

----------------------------------------------------------------------
 klausr - 05-25-04 15:59 
----------------------------------------------------------------------
just compiled 1.0.5-rc1 (configure, make, make install) and rebooted

after reboot I see this message in syslog

May 25 15:34:58 sagitta kernel: ALSA
/home/klaus/download/alsa/alsa-driver-1.0.5
rc1/alsa-kernel/pci/cs46xx/cs46xx_lib.c:3944: Activating CLKRUN hack for
Thinkpa
d.

Unfortunately suspend/resume still stops sound.

After closing xmms, rmmod snd_cs46xx, modprobe snd_cs46xx and
/etc/init.d/alsa start (to restore alsa mixer settings) I can run xmms
again and hear sound.

----------------------------------------------------------------------
 tiwai - 05-25-04 16:05 
----------------------------------------------------------------------
did you update alsa-lib, too?

----------------------------------------------------------------------
 klausr - 05-25-04 16:56 
----------------------------------------------------------------------
Just did configure; make install on alsa-lib-1.0.5rc1. Not sure if that did
it, though. How can I check which libs are used?

One other thing, probably not related (but who knows).

When I close the notebook I can hear some distortion. It sounds like a
"hang" for about half a second and then the music continues. Same happens
on opening the notebook.

edited on: 05-25-04 16:56

----------------------------------------------------------------------
 tiwai - 05-28-04 17:08 
----------------------------------------------------------------------
the installation procedure looks ok.

which xmms output plugin is used?  if it's ALSA plugin, try
OSS plugin, or vice versa.
Do you have any kernel message related with ALSA after suspend/resume?

----------------------------------------------------------------------
 klausr - 05-29-04 09:36 
----------------------------------------------------------------------
sound hangs with both output plugins, alsa and oss. in both cases sound is
back after closing xmms, unloading snd-cs46xx module and loading it
again.

one difference though. with alsa output plugin when i press pause in xmms
to pause music pressing pause again does not work. the playing just does
not start. i have to press play, then the playing starts again but from
the beginning of the title.

with oss output plugin it works as expected. pressing pause pauses
playing. pressing pause again resumes playing at the position it was when
pausing.

regards
klaus

----------------------------------------------------------------------
 jdthood - 01-17-05 10:57 
----------------------------------------------------------------------
> one difference though. with alsa output plugin when i press pause in xmms
to
> pause music pressing pause again does not work.

This is probably a separate bug.  See
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=495, for example.

Note that this bug (re: snd-cs46xx not working after suspend-'n'-resume)
can probably be merged with ALSA bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=226.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 14:49 klausr         New Issue                                    
05-25-04 14:49 klausr         Kernel Version            => Debian kernel
2.6.5-4-686
05-25-04 15:02 tiwai          Note Added: 0001213                          
05-25-04 15:31 klausr         Note Added: 0001215                          
05-25-04 15:59 klausr         Note Added: 0001217                          
05-25-04 16:02 klausr         Issue Monitored: klausr                      
05-25-04 16:05 tiwai          Note Added: 0001218                          
05-25-04 16:44 klausr         Note Added: 0001220                          
05-25-04 16:56 klausr         Note Edited: 0001220                         
05-27-04 08:49 klausr         Issue End Monitor: klausr                    
05-28-04 17:08 tiwai          Note Added: 0001269                          
05-29-04 09:36 klausr         Note Added: 0001276                          
01-17-05 10:57 jdthood        Note Added: 0003226                          
03-22-05 15:02 jdthood        Relationship added       has duplicate 0000226
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
