From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000555]: ATI IXP 150 - Does Not work majority of the time.
Date: Tue, 9 Nov 2004 16:42:23 +0100
Message-ID: <6930b3d6700ad56671eba24048764c70@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A421C176
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:42:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=555> 
======================================================================
Reported By:                bremedios
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   555
Category:                   PCI - atiixp
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             09-30-2004 20:53 CEST
Last Modified:              11-09-2004 16:42 CET
======================================================================
Summary:                    ATI IXP 150 - Does Not work majority of the time.
Description: 
Majority of the time (approx 70%) the board boots and reports timeout
errors.  In these cases the sound driver fails to load, thus trying to use
any sound applications results in failure.

Trying to unload and reload the modules when it fails does not seem to
help.

Shutting down and Starting up seems to eventually fix the problem.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000556 ATI IXP 150 - Does Not work majority of...
======================================================================

----------------------------------------------------------------------
 bremedios - 10-01-04 19:17 
----------------------------------------------------------------------
pci=noacpi has the result of getting the ATI IXP 150 to work.

I guess this is actually an ACPI bug then right?

----------------------------------------------------------------------
 tiwai - 10-04-04 18:57 
----------------------------------------------------------------------
Yes, it must be an ACPI issue.   Close this bug now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-30-04 20:53 bremedios      New Issue                                    
09-30-04 20:53 bremedios      File Added: messages                         
09-30-04 20:53 bremedios      Distribution              => Fedora Core 2   
09-30-04 20:53 bremedios      Kernel Version            => 2.6.8.1         
10-01-04 16:39 tiwai          Relationship added       has duplicate 0000556
10-01-04 17:03 tiwai          Note Added: 0002000                          
10-01-04 19:17 bremedios      Note Added: 0002005                          
10-04-04 18:57 tiwai          Status                   assigned => resolved
10-04-04 18:57 tiwai          Resolution               open => won't fix   
10-04-04 18:57 tiwai          Note Added: 0002014                          
11-09-04 16:42 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
