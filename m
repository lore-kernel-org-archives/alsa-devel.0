From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001484]: Sound works only after volume change
Date: Thu, 20 Oct 2005 11:00:48 +0200
Message-ID: <2b6daf5ac84194179efd3186ecefb856@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6A42717B
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2005 11:00:48 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0000442.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1484> 
======================================================================
Reported By:                kyromaster
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1484
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13.2-2-default
======================================================================
Date Submitted:             10-19-2005 14:11 CEST
Last Modified:              10-20-2005 10:59 CEST
======================================================================
Summary:                    Sound works only after volume change
Description: 
Much information about this bug is available on
https://bugzilla.novell.com/show_bug.cgi?id=118711
but here is the report again.

I have a ES1988 Allegro-1 soundcard (reported by YaST). When I start my
system
the sound doesn´t work. But when I
change the volume via kmix or another ALSA mixer(no matter whether up or
down) sound starts to work
correctly until I shutdown my system.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000442 alsactl no loading pcm volume properly.
======================================================================

----------------------------------------------------------------------
 jdthood - 10-20-05 10:59 
----------------------------------------------------------------------
Another report of this:

    http://bugzilla.ubuntu.com/show_bug.cgi?id=17825

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-19-05 14:11 kyromaster     New Issue                                    
10-19-05 14:11 kyromaster     Kernel Version            => 2.6.13.2-2-default
10-20-05 10:59 jdthood        Note Added: 0006501                          
10-20-05 11:00 jdthood        Relationship added       related to 0000442  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
