From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000508]: JACK connecting to SPDIF failes!
Date: Wed, 16 Mar 2005 22:25:21 +0100
Message-ID: <c97fcc8fc08edc33a5b137edfa405fb3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 759BEFE
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 22:25:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=508> 
======================================================================
Reported By:                hothead
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   508
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-20-2004 13:25 CEST
Last Modified:              03-16-2005 22:25 CET
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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
