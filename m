From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000508]: JACK connecting to SPDIF failes!
Date: Fri, 8 Jul 2005 10:34:45 +0200
Message-ID: <248eccaac24ba41a5f83f50ca89f565c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 25DB5186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:45 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=508> 
======================================================================
Reported By:                hothead
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   508
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-20-2004 13:25 CEST
Last Modified:              07-08-2005 10:34 CEST
======================================================================
Summary:                    JACK connecting to SPDIF failes!
Description: 
Trying to connect trough alsa to the spdif output on an
nforce2 soundchip via JACK failes with the following error message:

13:16:14.915 /usr/bin/jackd -R -dalsa -dhw:0,2 -r48000 -p1024 -n2 -S -i2
-o2
13:16:14.936 JACK was started with PID=12828 (0x321c).
jackd 0.98.1
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
loading driver ..
apparent rate = 48000
creating alsa driver ...
hw:0,2|hw:0,2|1024|2|48000|2|2|nomon|swmeter|-|16bit
ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D2c failed: No
such file or directory
jackd: pcm.c:690: snd_pcm_nonblock: Assertion `pcm' failed.
13:16:14.994 JACK was stopped successfully.
13:16:16.966 Could not connect to JACK server as client.
======================================================================

----------------------------------------------------------------------
 hothead - 09-20-04 14:55 
----------------------------------------------------------------------
Thanks mistatapas!

It was my fault.
hw:0,2 is just for playback.
You have to specify hw:0,0 for capture and hw:0,2 for playback when
starting JACK.

'jackd -d alsa -d hw:0,2 -P -S -C hw:0,0'

 
You might see the following output:

bash-2.05b$ jackd -d alsa -d hw:0,2 -P -S -C hw:0,0
jackd 0.98.1
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

loading driver ..
creating alsa driver ...
hw:0,2|hw:0,0|1024|2|48000|0|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods

----------------------------------------------------------------------
 jdthood - 03-16-05 22:25 
----------------------------------------------------------------------
It would appear that this report can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-20-04 13:25 hothead        New Issue                                    
09-20-04 14:05 mistatapas     Note Added: 0001785                          
09-20-04 14:55 hothead        Note Added: 0001786                          
09-20-04 14:56 hothead        Issue Monitored: hothead                     
03-16-05 22:25 jdthood        Note Added: 0003967                          
03-17-05 08:15 perex          Status                   new => resolved     
03-17-05 08:15 perex          Resolution               open => not an issue
03-17-05 08:15 perex          Assigned To               => perex           
03-17-05 08:15 perex          Assigned To              perex =>            
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
