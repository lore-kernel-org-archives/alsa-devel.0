From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000205]: Any MIDI access hard locks the system.
Date: Fri, 1 Apr 2005 22:51:01 +0200
Message-ID: <e283e05e37d616a0dc3a300120fe3196@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1537D235
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 22:51:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=205> 
======================================================================
Reported By:                wsippel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   205
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             gentoo-dev-sources-2.6.4
======================================================================
Date Submitted:             04-13-2004 00:32 CEST
Last Modified:              04-01-2005 22:51 CEST
======================================================================
Summary:                    Any MIDI access hard locks the system.
Description: 
On AMD64, everytime an application tries to access the MIDI port of my
Terratec EWX24/96, my system crashes.
It doesn't matter if that particular app is 32bit or 64bit - I checked eg
Bristol (32bit) and Rosegarden-4 (64bit).
This is very easy to verify using JACK with qjackctl: starting an
application that doesn't enumerate the MIDI ports at startup (eg
fluidsynth) works, but, as soon as I connect the application to the MIDI
port of my EWX24/96, the system locks. There's no warning, no message, no
entry in dmesg, nada. Routing MIDI to another application instead of a
hardware port works without problems...
======================================================================

----------------------------------------------------------------------
 wsippel - 04-13-04 03:05 
----------------------------------------------------------------------
I just tried kernel 2.6.5 with ALSA 1.04. Crashes, too...
Is it possible to disable the MIDI ports for a single device (I don't use
any external MIDI devices, anyway)?

----------------------------------------------------------------------
 jdthood - 04-01-05 22:51 
----------------------------------------------------------------------
Submitter: Has there been any improvement in more recent ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-04 00:32 wsippel        New Issue                                    
04-13-04 00:32 wsippel        Distribution              => gentoo          
04-13-04 00:32 wsippel        Kernel Version            =>
gentoo-dev-sources-2.6.4
04-13-04 00:33 wsippel        Issue Monitored: wsippel                     
04-13-04 03:05 wsippel        Note Added: 0000785                          
04-01-05 22:51 jdthood        Note Added: 0004292                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
