From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000574]: bad sound reproduction
Date: Tue, 18 Jan 2005 07:55:36 +0100
Message-ID: <c0d9eeaeed633385ea063d5d4600ff4b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8ADEC268
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 07:55:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=574> 
======================================================================
Reported By:                nicola
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   574
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               fedora core 2
Kernel Version:             kernel 2.6.5-1.358
======================================================================
Date Submitted:             10-09-2004 15:03 CEST
Last Modified:              01-18-2005 07:55 CET
======================================================================
Summary:                    bad sound reproduction
Description: 
Sound isn't reproduced rigth way, sound play and stop, play and stop. I
can't hear a fluid sound, the only way to hear sound is moving continously
the mouse. 
I can't hear system sounds, totem (and xine based programs) doesn't
reproduce fluid sounds, while mplayer and helix can (but sometimes stream
is shifted on).

======================================================================

----------------------------------------------------------------------
 tiwai - 10-11-04 12:10 
----------------------------------------------------------------------
Did you try boot options related with ACPI?  Try pci=noacpi or pci=off.

----------------------------------------------------------------------
 rounin - 01-18-05 07:55 
----------------------------------------------------------------------
The same issue occurs on the HP/compaq nx9110 laptop. Turning off ACPI is
obviously not really an option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 15:03 nicola         New Issue                                    
10-09-04 15:03 nicola         Distribution              => fedora core 2   
10-09-04 15:03 nicola         Kernel Version            => kernel 2.6.5-1.358
10-11-04 12:10 tiwai          Note Added: 0002074                          
01-18-05 07:55 rounin         Note Added: 0003241                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
