From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000267]: Cannot Auto load module
Date: Tue, 22 Mar 2005 15:04:58 +0100
Message-ID: <4856f2d80867ba9e0a33ed91503c3696@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D47A8287
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 15:04:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=267> 
======================================================================
Reported By:                skmrr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   267
Category:                   OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             05-10-2004 07:46 CEST
Last Modified:              03-22-2005 15:04 CET
======================================================================
Summary:                    Cannot Auto load module
Description: 
I have an intel D845GLLY board. Compilation and instalation went fine and
the card works when driver is loaded (but the master volume control has no
effect). Also I cannot autoload the modules by changing modules.conf.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 15:06 
----------------------------------------------------------------------
"Autoloading" as configured via "alias sound-*" lines in the module
loader configuration file occurs when the snd module is loaded.

This does not look like an ALSA bug.  I think the report can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-10-04 07:46 skmrr          New Issue                                    
03-19-05 15:06 jdthood        Note Added: 0004048                          
03-22-05 15:04 jdthood        Status                   new => closed       
03-22-05 15:04 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
