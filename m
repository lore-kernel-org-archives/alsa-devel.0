From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001490]: unresolved symbol copy_to_user_fromio_R602c96f0 ; unresolved symbol copy_from_user_toio_Rce3ca308
Date: Wed, 26 Oct 2005 18:56:59 +0200
Message-ID: <ce0a6b09cf13041ef7a59b4be022fc7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 99EE9183
	for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2005 18:56:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1490> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1490
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-21-2005 15:06 CEST
Last Modified:              10-26-2005 18:56 CEST
======================================================================
Summary:                    unresolved symbol copy_to_user_fromio_R602c96f0 ;
unresolved symbol copy_from_user_toio_Rce3ca308
Description: 
Starting from alsa-1.0.10rc2 and CVS on kernel 2.4.22-1.2199.nptl

/etc/init.d/alsasound start

unresolved symbol copy_to_user_fromio_R602c96f0 

unresolved symbol copy_from_user_toio_Rce3ca308
======================================================================

----------------------------------------------------------------------
 nickh - 10-26-05 18:01 
----------------------------------------------------------------------
I see the same error after building on a CentOS 3.5 system.  The kernel RPM
version is 2.4.21-32.

----------------------------------------------------------------------
 tiwai - 10-26-05 18:56 
----------------------------------------------------------------------
Already fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-05 15:06 Raymond        New Issue                                    
10-21-05 15:06 Raymond        Distribution              => Fedora Core 1   
10-21-05 15:06 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
10-24-05 17:14 Raymond        Note Added: 0006522                          
10-25-05 18:42 nickh          Issue Monitored: nickh                       
10-26-05 18:01 nickh          Note Added: 0006559                          
10-26-05 18:56 tiwai          Status                   new => resolved     
10-26-05 18:56 tiwai          Resolution               open => fixed       
10-26-05 18:56 tiwai          Assigned To               => tiwai           
10-26-05 18:56 tiwai          Note Added: 0006560                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
