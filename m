From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001498]: error: unknown field `owner'
Date: Tue, 25 Oct 2005 10:58:10 +0200
Message-ID: <d9096c788eeaffea763df64c5c7e370b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD6D7173
	for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2005 10:58:10 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1498> 
======================================================================
Reported By:                eric
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1498
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             10-25-2005 10:58 CEST
Last Modified:              10-25-2005 10:58 CEST
======================================================================
Summary:                    error: unknown field `owner'
Description: 
compilation problem with kernel 2.6.8.1

with alsa 10RC2 => cvs

10RC1 no problems

sample error:

In file included from /usr/src/cvs/alsa-driver/pci/via82xx.c:1:
/usr/src/cvs/alsa-driver/alsa-kernel/pci/via82xx.c:2481: error: unknown
field `owner' specified in initializer
/usr/src/cvs/alsa-driver/alsa-kernel/pci/via82xx.c:2481: attention :
initialisation d'un type pointeur incompatible
make[3]: *** [/usr/src/cvs/alsa-driver/pci/via82xx.o] Erreur 1
make[2]: *** [/usr/src/cvs/alsa-driver/pci] Erreur 2
make[1]: *** [_module_/usr/src/cvs/alsa-driver] Erreur 2
make[1]: Leaving directory `/usr/src/linux-2.6.8.1

Thanks 

eric
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-05 10:58 eric           New Issue                                    
10-25-05 10:58 eric           Kernel Version            => 2.6.8.1         
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
