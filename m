From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000641]: Bug in WM8770 init on aureon
Date: Mon, 15 Nov 2004 20:09:10 +0100
Message-ID: <4e9c7d7c20cb72a7e964094e1b444364@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3C62728A
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2004 20:09:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=641> 
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   641
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-11-2004 00:03 CET
Last Modified:              11-15-2004 20:09 CET
======================================================================
Summary:                    Bug in WM8770 init on aureon
Description: 
On aureon cards the ADC on WM8770 is initialized to AIN6L/AIN5R, although
the comment states AC'97.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-15-04 20:09 
----------------------------------------------------------------------
Applied to CVS.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-04 00:03 ungod          New Issue                                    
11-11-04 00:03 ungod          File Added: aureon-wm-init-fix.diff               
    
11-15-04 20:09 tiwai          Status                   new => resolved     
11-15-04 20:09 tiwai          Resolution               open => fixed       
11-15-04 20:09 tiwai          Assigned To               => tiwai           
11-15-04 20:09 tiwai          Note Added: 0002418                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
