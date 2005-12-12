From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001642]: System lockup when recording
Date: Mon, 12 Dec 2005 01:01:11 +0100
Message-ID: <bb300e0d9bba6d870629b7d734a9d7a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26AEE141
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2005 01:01:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1642> 
======================================================================
Reported By:                oryn
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1642
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             12-12-2005 00:31 CET
Last Modified:              12-12-2005 01:01 CET
======================================================================
Summary:                    System lockup when recording
Description: 
When I try to open a usb device for recording it locks up the system
I have to power cycle the system to recover.
It makes no difference what application I use and whether it wants to open
the alsa device directly or via the oss emulation.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-12-05 01:01 
----------------------------------------------------------------------
Try recording from a text console (not X) and see if an Oops or kernel
panic appears on the screen.  If so then try to capture it with a digital
camera and attach it to this bug report.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-05 00:31 oryn           New Issue                                    
12-12-05 00:31 oryn           Distribution              => Debian          
12-12-05 00:31 oryn           Kernel Version            => 2.6.14.3        
12-12-05 01:01 rlrevell       Note Added: 0006981                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
