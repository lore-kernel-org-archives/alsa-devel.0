From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000609]: No Mixer control for Ouput on CMI9880
Date: Sun, 12 Dec 2004 14:01:54 +0100
Message-ID: <02fd9bf55504aae4376d2de5daf3b8a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5DFB22AF
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2004 14:01:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=609> 
======================================================================
Reported By:                Grazy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   609
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8
======================================================================
Date Submitted:             10-27-2004 00:10 CEST
Last Modified:              12-12-2004 14:01 CET
======================================================================
Summary:                    No Mixer control for Ouput on CMI9880
Description: 
The CMI9880 chip on my MotherBoard is detect by the snd-azx module.
But there is only one mixer control for "Capture" and two mute switch for
"Line" and "Mic". But nothing to control the output volume.
======================================================================

----------------------------------------------------------------------
 cltien - 11-08-04 21:02 
----------------------------------------------------------------------
The Windows driver modify the DMA buffer directly, the driver also do SRC
conversion there.

I once post patch like this, but it was rejected because ALSA team doen't
accept DMA modification like this. I modify the core/pcm_lib.c and found
that only OSS application can work well in this way, ALSA application
still don't have mixer.

I suggest that forget the mixer and tune the speaker volume.

----------------------------------------------------------------------
 jdthood - 12-12-04 14:01 
----------------------------------------------------------------------
Bug also reported at http://bugs.debian.org/281546

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-04 00:10 Grazy          New Issue                                    
10-27-04 00:10 Grazy          Distribution              => Debian          
10-27-04 00:10 Grazy          Kernel Version            => 2.6.8           
10-27-04 02:36 cltien         Note Added: 0002270                          
11-08-04 09:22 madsend        Note Added: 0002310                          
11-08-04 09:25 madsend        Issue Monitored: madsend                     
11-08-04 21:02 cltien         Note Added: 0002313                          
12-12-04 14:01 jdthood        Note Added: 0002814                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
