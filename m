From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001726]: Front and Rear channels swap after first play when playing Surround40 on au8830
Date: Fri, 17 Feb 2006 04:28:09 +0100
Message-ID: <bbd6e2e32ff16df819ee6424cbc2344a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9B3071E1
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2006 04:28:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1726
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             01-08-2006 17:41 CET
Last Modified:              02-17-2006 04:28 CET
======================================================================
Summary:                    Front and Rear channels swap after first play when
playing Surround40 on au8830
Description: 
The front and rear channels are correct for playing Surround40 only at the
first time after the driver is loaded. 

The front and rear channels (Surround40) always swapped afterward using
speaker-test or xine. 

Playing stereo sound is OK.


 speaker-test -c4 -D hw:0,0
 
speaker-test 1.0.11rc2
 
Playback device is hw:0,0
Stream parameters are 48000Hz, S16_LE, 4 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 8192
Period size range from 1 to 512
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 512
was set buffer_size = 8192
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
Time per period = 11.856821
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left

======================================================================

----------------------------------------------------------------------
 ponchick - 02-17-06 03:35 
----------------------------------------------------------------------
I try aplay and cannot reproduce channel swapping. I think this doesn't
mean that bug is just in speaker-test. When I run speaker-test I interrupt
it with ^C. At this moment driver can be in some state that leads to
swapping channels on next run.
I believe this bugs could be closed. If someone can reproduce "random"
channel swapping in app other then speaker-test there should be separate
bugreport.
About resource exhausting - I post complete logs. Before is just
initializing logs, similar to
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 19 (level, low) -> IRQ 225
Vortex: init.... <6>done.
Only interrupts and PCI address are differ. If you want more research I
think you should open new bug.
P.S. If you think that I should test another issues with au88x0 cards you
can mail me to lkabanov at mail dot ru.

----------------------------------------------------------------------
 Raymond - 02-17-06 04:28 
----------------------------------------------------------------------
Steps to reproduce the problem with alsa-1.0.11rc3 for au8830 (STAC9708)

1) use alsamixer to turn "Sigmatel Surround Playback Switch" off, it mix
the front and rear channels

numid=19,iface=MIXER,name='Sigmatel Surround Playback Switch'
; type=BOOLEAN,access=rw---,values=1
: values=off

2) aplay -D hw:0,0 out1lq.wav ( you should hear the sound only from left
speaker of out1 at first run )

3) aplay -D hw:0,0 out1lq.wav ( Do the sound come out from left speaker of
out2  with alsa-1.0.11rc3 on second run? )

There may be some difference in MX300, since Win9x can detect one/two
jacks are plugged into out1 and out2 using GPIO

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-06 17:41 Raymond        New Issue                                    
01-08-06 17:41 Raymond        Distribution              => Fedora Core 1   
01-08-06 17:41 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
01-27-06 16:45 Raymond        File Added: au88x0_surround40.patch               
    
02-04-06 06:26 Raymond        Note Added: 0007912                          
02-10-06 05:36 ponchick       Note Added: 0007987                          
02-10-06 06:32 Raymond        Note Added: 0007991                          
02-10-06 10:50 ponchick       Note Added: 0007998                          
02-10-06 11:25 Raymond        Note Added: 0008000                          
02-10-06 13:49 Raymond        Note Added: 0008003                          
02-10-06 13:56 Raymond        Note Edited: 0008003                         
02-12-06 07:48 Raymond        Note Edited: 0008003                         
02-12-06 10:12 Raymond        Note Edited: 0008000                         
02-16-06 05:37 ponchick       Note Added: 0008085                          
02-16-06 08:12 Raymond        Note Added: 0008088                          
02-16-06 10:12 Raymond        Note Added: 0008090                          
02-16-06 10:28 Raymond        Note Edited: 0008090                         
02-16-06 16:07 Raymond        Note Added: 0008097                          
02-17-06 03:35 ponchick       Note Added: 0008104                          
02-17-06 04:28 Raymond        Note Added: 0008105                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
