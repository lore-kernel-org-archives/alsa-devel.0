From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000661]: starting an applicaiton trying to access sound device locks device exclusive
Date: Sun, 21 Nov 2004 15:41:16 +0100
Message-ID: <3d45193193731f750e9b291ca81dbc6b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A859E206
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2004 15:41:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=661> 
======================================================================
Reported By:                soloturn99
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   661
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               debian sid
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-21-2004 15:41 CET
Last Modified:              11-21-2004 15:41 CET
======================================================================
Summary:                    starting an applicaiton trying to access sound
device locks device exclusive
Description: 
an application should not be by default be allowed to take the sound device
exlusively. if you start more than one applications, it should be possible
to hear one of them or both, but the application must not block.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-21-04 15:41 soloturn99     New Issue                                    
11-21-04 15:41 soloturn99     Distribution              => debian sid      
11-21-04 15:41 soloturn99     Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
