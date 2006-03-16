From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000108]: OSS Seq ioctl(... SNDCTL_SEQ_OUTOFBAND ...) does not work
Date: Thu, 16 Mar 2006 08:29:55 +0100
Message-ID: <a6c3290947b488be8f9c7087bcb7214c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07A5E1FB
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 08:29:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=108> 
======================================================================
Reported By:                mpkelly
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   108
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               SuSE 8.2 Pro
Kernel Version:             2.4.25
Resolution:                 fixed
Fixed in Version:           1.0.4
======================================================================
Date Submitted:             03-03-2004 04:13 CET
Last Modified:              03-16-2006 08:29 CET
======================================================================
Summary:                    OSS Seq ioctl(... SNDCTL_SEQ_OUTOFBAND ...) does not
work
Description: 

This problem shows up in the OSS compatibility layer.
The test case involves using an external MIDI keyboard
connected to an Audigy2 via a MIDI cable plugged into
the "joystick" port.  External MIDI modules are also 
connected in the MIDI cable chain.

The goal is to have a software program perform a "soft"
MIDI THROUGH operation; read the data in from /dev/music,
and insert the MIDI events into the MIDI output stream,
where they go out onto the output cable, and on to external
MIDI modules.


NOTE: This setup has worked for me for well over a year,
and worked fine with ALSA 0.9.6.


All else being working, performing the following call:

  ioctl(fd,SNDCTL_SEQ_OUTOFBAND,buf);

does not work. No midi events get put into any queue.
I've used print statements to verify that the data
being passed into the ioctl() is correct (it is coming
directly from a read() from /dev/music, and has always
worked, in 0.9.6).

The last version of ALSA I ran was 0.9.6, and it worked there.  I then
upgraded to 1.0.2c, which did not work.  
Today I tried 1.0.3, which also does not work.

The problem first showed up in the JAZZ midi sequencer, 
which is using the OSS compatibility layer.  I also have
a small test case that shows the problem.

======================================================================

----------------------------------------------------------------------
 mpkelly - 03-21-05 03:48 
----------------------------------------------------------------------
I haven't tested it,but I did look at version 1.0.4 (the initial
1.0.4 release), and the code changes that I submitted were in place.
The changes were pretty simple, so I presume they work, although as
I said I didn't test them on real hardware yet.

----------------------------------------------------------------------
 rlrevell - 03-16-06 08:29 
----------------------------------------------------------------------
Should be fixed

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-04 04:13 mpkelly        New Issue                                    
03-03-04 04:13 mpkelly        File Added: seqOOB.c                         
03-19-05 09:28 jdthood        Note Added: 0004018                          
03-21-05 03:48 mpkelly        Note Added: 0004114                          
03-16-06 08:29 rlrevell       Status                   new => resolved     
03-16-06 08:29 rlrevell       Fixed in Version          => 1.0.4           
03-16-06 08:29 rlrevell       Resolution               open => fixed       
03-16-06 08:29 rlrevell       Assigned To               => rlrevell        
03-16-06 08:29 rlrevell       Note Added: 0008590                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
