From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000108]: OSS Seq ioctl(... SNDCTL_SEQ_OUTOFBAND ...) does not work
Date: Mon, 21 Mar 2005 03:48:24 +0100
Message-ID: <87dff135037c40e5d95f1654cd5c440c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D68A3269
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2005 03:48:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=108> 
======================================================================
Reported By:                mpkelly
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   108
Category:                   GENERIC - mpu401
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               SuSE 8.2 Pro
Kernel Version:             2.4.25
======================================================================
Date Submitted:             03-03-2004 04:13 CET
Last Modified:              03-21-2005 03:48 CET
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
 jdthood - 03-19-05 09:28 
----------------------------------------------------------------------
Submitter: Did this problem get fixed in later ALSA releases?

----------------------------------------------------------------------
 mpkelly - 03-21-05 03:48 
----------------------------------------------------------------------
I haven't tested it,but I did look at version 1.0.4 (the initial
1.0.4 release), and the code changes that I submitted were in place.
The changes were pretty simple, so I presume they work, although as
I said I didn't test them on real hardware yet.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-03-04 04:13 mpkelly        New Issue                                    
03-03-04 04:13 mpkelly        File Added: seqOOB.c                         
03-19-05 09:28 jdthood        Note Added: 0004018                          
03-21-05 03:48 mpkelly        Note Added: 0004114                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
