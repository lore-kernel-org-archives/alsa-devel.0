From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000754]: parameter mpu_port dissapeared from 1.0.6 to 1.0.7 midi device is ot detected
Date: Wed, 29 Dec 2004 17:26:57 +0100
Message-ID: <38155ae0b2c35ed95b44f42732df859b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EA16E207
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 17:26:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=754> 
======================================================================
Reported By:                jmfrank
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   754
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian/GNU Linux
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-28-2004 23:56 CET
Last Modified:              12-29-2004 17:26 CET
======================================================================
Summary:                    parameter mpu_port dissapeared from 1.0.6 to 1.0.7
midi device is ot detected
Description: 
Dear Developer,
this is my first filed bug ever, so I might not have done everything
correct.
I never got midi running on my p4p800 Deluxe mainboard also it worked on a
P4C800 Deluxe Board with the same configuration. Difference is a 865 to
875 in Chip-Version.
Now Midi isn't detected anymore since the midi support is gone completly,
without an update in the documentation.

This no I do not hear any sound issue. I want to access a midi-keyboard.
I am willing to do testing for you.

Many thanks for your assistance.

Johannes Frank
======================================================================

----------------------------------------------------------------------
 tiwai - 12-29-04 14:18 
----------------------------------------------------------------------
Try snd-mpu401 module additionally.  If ACPI entry is found, it can probe
automatically.  If not, specify the midi i/o port address explicitly.

----------------------------------------------------------------------
 jmfrank - 12-29-04 17:26 
----------------------------------------------------------------------
Thank you it loaded sucessfully. And now the port is there.

This solves the issue. You should update the intel8x0 documentation
though.

Again many thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 23:56 jmfrank        New Issue                                    
12-28-04 23:56 jmfrank        Distribution              => Debian/GNU Linux
12-28-04 23:56 jmfrank        Kernel Version            => 2.6.9           
12-29-04 14:18 tiwai          Note Added: 0002999                          
12-29-04 17:26 jmfrank        Note Added: 0003002                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
