From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001294]: intel8x0 does not compile properly with new compiled kernel
Date: Tue, 1 Nov 2005 15:38:34 +0100
Message-ID: <a3346e174880c7763c82195212576332@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A872EF
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:38:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1294> 
======================================================================
Reported By:                tanman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1294
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora4
Kernel Version:             2.6.12.3
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-31-2005 22:23 CEST
Last Modified:              11-01-2005 15:38 CET
======================================================================
Summary:                    intel8x0 does not compile properly with new compiled
kernel
Description: 
The module snd-8x0 produces the following errors once I compiled the kernel
linux-2.6.12.3:

dmesg
snd_intel8x0: Unknown parameter `'
snd_intel8x0: Unknown parameter `'
snd_intel8x0: Unknown parameter `'

Is there anything I have to edit in the configuration files when migrating
to the latest kernel?




======================================================================

----------------------------------------------------------------------
 jdthood - 11-01-05 15:38 
----------------------------------------------------------------------
Your module configuration would appear to be faulty.  Please file a bug
report with your GNU/Linux distributor.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-05 22:23 tanman         New Issue                                    
07-31-05 22:23 tanman         Distribution              => Fedora4         
07-31-05 22:23 tanman         Kernel Version            => 2.6.12.3        
11-01-05 15:38 jdthood        Note Added: 0006594                          
11-01-05 15:38 jdthood        Status                   new => closed       
11-01-05 15:38 jdthood        Resolution               open => not an issue
11-01-05 15:38 jdthood        Summary                  Alsa soundcard intel8xo
does not compile properly with new compiled kernel => intel8x0 does not compile
properly with new compiled kernel
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
