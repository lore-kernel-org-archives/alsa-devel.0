From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000617]: Front / rear out of sync
Date: Tue, 7 Dec 2004 15:38:42 +0100
Message-ID: <9455ce5d46f11b706889e6fa902500a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CA9B5383
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 15:38:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=617> 
======================================================================
Reported By:                henkie_
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   617
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.0
Kernel Version:             2.4.26
======================================================================
Date Submitted:             10-30-2004 18:20 CEST
Last Modified:              12-07-2004 15:38 CET
======================================================================
Summary:                    Front / rear out of sync
Description: 
When using the config specified below the sound gets out of sync (front and
rear sound) in xmms. The higher cpu-usage is the faster the sound goes
out-of-sync. When using mplayer in combo with this config, cpu usage goes
up, and the image of the movie halts but sound keeps playing. Without this
config the cpu-usage is around 20%. Tested on P4 2.8GHz.  
In alsa <1.0  the front and rear sound was duplicated, is it possible to
reimplement that behaviour again?

pcm.ch40dup {
        type route
        slave.pcm surround40
        slave.channels 4
        ttable.0.0 1
        ttable.1.1 1
        ttable.0.2 1
        ttable.1.3 1
}
======================================================================

----------------------------------------------------------------------
 tiwai - 12-06-04 20:53 
----------------------------------------------------------------------
Could you try another one (config2.diff)?

The patches are already merged into ALSA CVS, BTW.

----------------------------------------------------------------------
 darkbrain - 12-07-04 15:38 
----------------------------------------------------------------------
ok perfect!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-04 18:20 henkie_        New Issue                                    
10-30-04 18:20 henkie_        Distribution              => SuSE 9.0        
10-30-04 18:20 henkie_        Kernel Version            => 2.4.26          
11-10-04 12:43 tiwai          Note Added: 0002368                          
11-10-04 22:37 henkie_        Note Added: 0002379                          
11-29-04 15:13 darkbrain      Note Added: 0002636                          
12-02-04 00:53 darkbrain      Note Added: 0002672                          
12-02-04 02:02 henkie_        Note Added: 0002673                          
12-02-04 12:17 tiwai          Note Added: 0002678                          
12-02-04 14:32 lemoncurry     Note Added: 0002680                          
12-02-04 14:55 tiwai          Note Added: 0002681                          
12-02-04 14:55 tiwai          File Added: cs46xx-front-dup.diff                 
  
12-02-04 14:56 tiwai          File Added: cs46xx-front-dup-config.diff          
         
12-02-04 15:53 lemoncurry     Note Added: 0002685                          
12-02-04 19:18 tiwai          Note Added: 0002688                          
12-04-04 15:08 darkbrain      Note Added: 0002716                          
12-06-04 20:53 tiwai          Note Added: 0002733                          
12-06-04 20:54 tiwai          File Added: cs46xx-front-dup-config2.diff         
          
12-07-04 15:38 darkbrain      Note Added: 0002748                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
