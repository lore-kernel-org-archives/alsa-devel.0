From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000617]: Front / rear out of sync
Date: Mon, 29 Nov 2004 15:13:17 +0100
Message-ID: <70fcab582f306efd52a118c21581ce29@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5E37A292
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 15:13:17 +0100 (MET)
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
Last Modified:              11-29-2004 15:13 CET
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
 henkie_ - 11-10-04 22:37 
----------------------------------------------------------------------
I have this chipset according to "lspci"
Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear
SoundFusion Audio Accelerator] (rev 01)
And i am pretty sure 0.90rc3 (not the only one though) duplicated the
sound, so front and rear were exactly the same. In the windows-driver
(atleast 3 years back, havent checked lately) this was also an option. 
And yes, it was automatically enabled.

----------------------------------------------------------------------
 darkbrain - 11-29-04 15:13 
----------------------------------------------------------------------
It's true i tried alsa driver version 0.9.0b10 (in debian stable) and the
signal is duplicated. From witch version this feature was disabled? I
don't want to test every version to find it!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-30-04 18:20 henkie_        New Issue                                    
10-30-04 18:20 henkie_        Distribution              => SuSE 9.0        
10-30-04 18:20 henkie_        Kernel Version            => 2.4.26          
11-10-04 12:43 tiwai          Note Added: 0002368                          
11-10-04 22:37 henkie_        Note Added: 0002379                          
11-29-04 15:13 darkbrain      Note Added: 0002636                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
