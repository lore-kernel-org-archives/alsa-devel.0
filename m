From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000499]: no sound through line in
Date: Thu, 13 Jan 2005 17:23:44 +0100
Message-ID: <fd1fb20024c50120520b282a14b4165f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D457B309
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 17:23:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=499> 
======================================================================
Reported By:                hombergp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   499
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               SuSE 9.1
Kernel Version:             2.6.5-108
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-13-2004 18:03 CEST
Last Modified:              01-13-2005 17:23 CET
======================================================================
Summary:                    no sound through line in
Description: 
Since I upgraded to SuSE 9.1 with alsa 1.0.3
I cannot use the line in (external mini jackplug)
input anymore.
No sound is reproduced through this line in interface.
I used the line input before under SuSE 8.2 successfully.

======================================================================

----------------------------------------------------------------------
 hombergp - 09-13-04 19:49 
----------------------------------------------------------------------
Consider problem resolved. Resolution: Unmute the line input.
More specificalities on this problem:
GNome alsa mixer determines my device as Realtek ALC650 rev 3
And it shows a lot more features than I was used to under my previous os.
Do not know if I can connect them all.

----------------------------------------------------------------------
 tiwai - 01-13-05 17:23 
----------------------------------------------------------------------
Closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-13-04 18:03 hombergp       New Issue                                    
09-13-04 18:03 hombergp       Distribution              => SuSE 9.1        
09-13-04 18:03 hombergp       Kernel Version            => 2.6.5-108       
09-13-04 18:03 hombergp       Issue Monitored: hombergp                    
09-13-04 18:04 hombergp       Issue End Monitor: hombergp                    
09-13-04 19:45 hombergp       Note Added: 0001754                          
09-13-04 19:49 hombergp       Note Added: 0001755                          
01-13-05 17:23 tiwai          Status                   new => resolved     
01-13-05 17:23 tiwai          Resolution               open => not an issue
01-13-05 17:23 tiwai          Assigned To               => tiwai           
01-13-05 17:23 tiwai          Note Added: 0003192                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
