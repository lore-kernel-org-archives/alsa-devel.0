From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000317]: Use a real SSL certificate issuer
Date: Tue, 9 Nov 2004 16:40:02 +0100
Message-ID: <410f04f599796b7283ffeb61e4baacae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B3E452B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:40:02 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=317> 
======================================================================
Reported By:                sehh
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   317
Category:                   OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-31-2004 02:57 CEST
Last Modified:              11-09-2004 16:40 CET
======================================================================
Summary:                    Use a real SSL certificate issuer
Description: 
I noticed that you use your own issued SSL certificate. Its
wise to avoid the commercialised and blood-drinking root
certificates which charge a fortune for a certification.

There is one solution thought, there is a non-profit
certificate authority which issues certificates free
of charge. We've used them for many of our web sites
with great success.

The url is:

http://www.cacert.org/


======================================================================

----------------------------------------------------------------------
 sehh - 05-31-04 14:55 
----------------------------------------------------------------------
Superb!

----------------------------------------------------------------------
 perex - 09-29-04 14:28 
----------------------------------------------------------------------
Once again, thanks. I've changed the certificate now. It works great.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-04 02:57 sehh           New Issue                                    
05-31-04 11:50 perex          Status                   new => assigned     
05-31-04 11:50 perex          Assigned To               => perex           
05-31-04 11:53 perex          Note Added: 0001282                          
05-31-04 14:55 sehh           Note Added: 0001283                          
09-29-04 14:28 perex          Status                   assigned => resolved
09-29-04 14:28 perex          Resolution               open => fixed       
09-29-04 14:28 perex          Note Added: 0001971                          
11-09-04 16:40 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
