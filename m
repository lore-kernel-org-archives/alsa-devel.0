From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000541]: Tascam US-122 drivers fails with jackd
Date: Tue, 30 Aug 2005 12:27:03 +0200
Message-ID: <5f5130b6d9dcab94775e88fe74da2852@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E99F5207
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:27:03 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=541> 
======================================================================
Reported By:                roswel
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   541
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             Linux 2.6.9-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-25-2004 16:11 CEST
Last Modified:              08-30-2005 12:27 CEST
======================================================================
Summary:                    Tascam US-122 drivers fails with jackd
Description: 
When i start jackd everything seems allright, but if i try to play some
audio through jack, like for example with alsaplayer or ardour, nothing
happen.
======================================================================

----------------------------------------------------------------------
 roswel - 09-26-04 22:22 
----------------------------------------------------------------------
That work now! :) I use CONFIG_USB_BANDWIDTH, but if i force 16bit mode,
that work. I will rebuilt a kernel without it!

Thank very much for your help, and you quick answer! :)

----------------------------------------------------------------------
 jdthood - 08-30-05 12:27 
----------------------------------------------------------------------
Fix was to reconfigure kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-04 16:11 roswel         New Issue                                    
09-25-04 16:11 roswel         Distribution              => Debian          
09-25-04 16:11 roswel         Kernel Version            => Linux 2.6.9-rc2 
09-25-04 16:12 roswel         Issue Monitored: roswel                      
09-25-04 16:22 karsten        Note Added: 0001910                          
09-26-04 12:47 roswel         Note Added: 0001920                          
09-26-04 15:48 karsten        Note Added: 0001923                          
09-26-04 20:55 roswel         Note Added: 0001924                          
09-26-04 22:09 karsten        Note Added: 0001926                          
09-26-04 22:22 roswel         Note Added: 0001928                          
08-30-05 12:27 jdthood        Status                   assigned => resolved
08-30-05 12:27 jdthood        Resolution               open => fixed       
08-30-05 12:27 jdthood        Note Added: 0005976                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
