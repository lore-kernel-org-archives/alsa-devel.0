From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000555]: ATI IXP 150 - Does Not work majority of the time.
Date: Mon,  4 Oct 2004 18:57:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041004165704.EFC154A046@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 52E9925E
	for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2004 18:57:05 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000555
======================================================================
Reported By:                bremedios
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     555
Category:                   PCI - atiixp
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
Resolution:                 won't fix
======================================================================
Date Submitted:             09-30-2004 20:53 CEST
Last Modified:              10-04-2004 18:57 CEST
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

----------------------------------------------------------------------
 tiwai - 10-01-2004 17:03 CEST 
----------------------------------------------------------------------
What happens if you start with pci=noacpi or acpi=off?

----------------------------------------------------------------------
 bremedios - 10-01-2004 19:17 CEST 
----------------------------------------------------------------------
pci=noacpi has the result of getting the ATI IXP 150 to work.

I guess this is actually an ACPI bug then right?

----------------------------------------------------------------------
 tiwai - 10-04-2004 18:57 CEST 
----------------------------------------------------------------------
Yes, it must be an ACPI issue.   Close this bug now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-30-04 20:53 bremedios      New Bug                                      
09-30-04 20:53 bremedios      File Added: messages                         
09-30-04 20:53 bremedios      Distribution              => Fedora Core 2   
09-30-04 20:53 bremedios      Kernel Version            => 2.6.8.1         
10-01-04 17:03 tiwai          Bugnote Added: 0002000                       
10-01-04 19:17 bremedios      Bugnote Added: 0002005                       
10-04-04 18:57 tiwai          Bugnote Added: 0002014                       
10-04-04 18:57 tiwai          Resolution               open => won't fix   
10-04-04 18:57 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
