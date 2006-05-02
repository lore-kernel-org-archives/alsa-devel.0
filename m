From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002090]: snd_config_search_definition: Documentation of return value wrong
Date: Tue, 2 May 2006 17:49:22 +0200
Message-ID: <fd52b7a17bed645c151bcc51e88b9b1d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E8C419F
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 17:49:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2090> 
======================================================================
Reported By:                lurchi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   2090
Category:                   0_general
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-02-2006 08:16 CEST
Last Modified:              05-02-2006 17:49 CEST
======================================================================
Summary:                    snd_config_search_definition: Documentation of
return value wrong
Description: 
The return value is documented as:
\return Zero if successful, otherwise a negative error code.

But the code reads:
return snd_config_expand(...)
which has the following documentation:
\return A non-negative value if successful, otherwise a negative error
code.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-06 17:49 
----------------------------------------------------------------------
Fixed on Hg repo.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-02-06 08:16 lurchi         New Issue                                    
05-02-06 17:49 tiwai          Status                   new => resolved     
05-02-06 17:49 tiwai          Resolution               open => fixed       
05-02-06 17:49 tiwai          Assigned To               => tiwai           
05-02-06 17:49 tiwai          Note Added: 0009560                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
