From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000205]: Any MIDI access hard locks the system.
Date: Sat, 31 Dec 2005 04:05:03 +0100
Message-ID: <1f807d23b1df3382ae9e94431f799d42@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 504F215D
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 04:05:03 +0100 (MET)
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
Status:                     closed
Distribution:               gentoo
Kernel Version:             gentoo-dev-sources-2.6.4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-13-2004 00:32 CEST
Last Modified:              12-31-2005 04:05 CET
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
 jdthood - 04-01-05 22:51 
----------------------------------------------------------------------
Submitter: Has there been any improvement in more recent ALSA releases?

----------------------------------------------------------------------
 rlrevell - 12-31-05 04:05 
----------------------------------------------------------------------
No response

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
12-31-05 04:05 rlrevell       Status                   new => closed       
12-31-05 04:05 rlrevell       Note Added: 0007335                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
