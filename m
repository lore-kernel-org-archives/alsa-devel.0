From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001369]: Rear left/right channels swapped with center/lfe
Date: Tue, 1 Nov 2005 15:35:57 +0100
Message-ID: <800617aac8c28b72d31810b38525ef11@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3CFD2156
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 15:35:57 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001501.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1369> 
======================================================================
Reported By:                ukr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1369
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4 (but latest stable versions of kernel,
alsa-driver and alsa-lib installed as mentioned earlier)
Kernel Version:             Linux 2.6.12.5 (compiled with SMP support with gcc
4.0)
======================================================================
Date Submitted:             08-25-2005 11:00 CEST
Last Modified:              11-01-2005 15:35 CET
======================================================================
Summary:                    Rear left/right channels swapped with center/lfe
Description: 
The rear left and right channel outputs have been swapped with center and
lfe respectively. speaker-test (alsa-utils-1.0.9) confirms this. I'm using
alsa-lib-1.0.9 with alsa-driver-1.0.9b.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001501 intel8x0 surround channels missing and ...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-25-05 11:00 ukr            New Issue                                    
08-25-05 11:00 ukr            File Added: asound.state                     
08-25-05 11:00 ukr            Distribution              => Fedora Core 4 (but
latest stable versions of kernel, alsa-driver and alsa-lib installed as
mentioned earlier)
08-25-05 11:00 ukr            Kernel Version            => Linux 2.6.12.5
(compiled with SMP support with gcc 4.0)
11-01-05 15:35 jdthood        Relationship added       related to 0001501  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
