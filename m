From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002125]: quiet sound only through headphones
Date: Wed, 17 May 2006 17:41:10 +0200
Message-ID: <ab64c6665c1933e5905522806a2c242b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8205E1A0
	for <alsa-devel@alsa-project.org>; Wed, 17 May 2006 17:41:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2125> 
======================================================================
Reported By:                wodz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2125
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu Dapper Drake
Kernel Version:             2.6.15; 2.6.16.14
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             05-15-2006 11:07 CEST
Last Modified:              05-17-2006 17:41 CEST
======================================================================
Summary:                    quiet sound only through headphones
Description: 
I have problem getting to work soundcard in my shiny new notebook.
The card is recognized as atiixp but output is only available through
headphones (and rather quiet). I have googled a bit and there seems to
be quite popular problem but on intel's boards. I have tried alsa
drivers from 2.6.15 kernel (ubuntu dapper) as well as 1.0.11 from
alsa-project.org.
======================================================================

----------------------------------------------------------------------
 wodz - 05-17-06 15:06 
----------------------------------------------------------------------
This seems to be dupplication of bug:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1162

I don't know how I missed this. Apparently disabling acpi at boottime with
acpi=off makes sound work correctly so this is not alsa bug but rather
ACPI problem.

----------------------------------------------------------------------
 rlrevell - 05-17-06 17:41 
----------------------------------------------------------------------
Upstream ACPI bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-15-06 11:07 wodz           New Issue                                    
05-15-06 11:07 wodz           Distribution              => Ubuntu Dapper Drake
05-15-06 11:07 wodz           Kernel Version            => 2.6.15; 2.6.16.14
05-16-06 10:44 wodz           Note Added: 0009835                          
05-16-06 10:44 wodz           Issue Monitored: wodz                        
05-17-06 15:06 wodz           Note Added: 0009849                          
05-17-06 17:41 rlrevell       Status                   assigned => closed  
05-17-06 17:41 rlrevell       Note Added: 0009856                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
