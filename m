From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000556]: ATI IXP 150 - Does Not work majority of the time.
Date: Fri,  1 Oct 2004 16:39:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041001143939.BEDAC2D0C1@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 35E2E226
	for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2004 16:39:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000556
======================================================================
Reported By:                bremedios
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     556
Category:                   PCI - atiixp
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
Resolution:                 fixed
======================================================================
Date Submitted:             09-30-2004 20:53 CEST
Last Modified:              10-01-2004 16:39 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-30-04 20:53 bremedios      New Bug                                      
09-30-04 20:53 bremedios      File Added: messages                         
09-30-04 20:53 bremedios      Distribution              => Fedora Core 2   
09-30-04 20:53 bremedios      Kernel Version            => 2.6.8.1         
10-01-04 16:39 tiwai          duplicate_id             0 => 555            
10-01-04 16:39 tiwai          Resolution               open => fixed       
10-01-04 16:39 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
