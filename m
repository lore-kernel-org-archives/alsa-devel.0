From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000613]: Getting configure error
Date: Tue, 31 May 2005 18:04:02 +0200
Message-ID: <cce482780a70bf87e03a6d3b8361b401@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BFCD01CA
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:04:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=613> 
======================================================================
Reported By:                glower0617
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   613
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Mandrake
Kernel Version:             2.6.8.1-10MDK
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-28-2004 07:22 CEST
Last Modified:              05-31-2005 18:04 CEST
======================================================================
Summary:                    Getting configure error
Description: 
checking how to run the C++ preprocessor... /lib/cpp
configure: error: C++ preprocessor "/lib/cpp" fails sanity check
See `config.log' for more details.
make: *** No targets specified and no makefile found.  Stop.
make: *** No rule to make target `install'.  Stop.

======================================================================

----------------------------------------------------------------------
 perex - 02-22-05 09:40 
----------------------------------------------------------------------
Appearently, you don't have installed gcc package in your system.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-28-04 07:22 glower0617     New Issue                                    
10-28-04 07:22 glower0617     Distribution              => Mandrake        
10-28-04 07:22 glower0617     Kernel Version            => 2.6.8.1-10MDK   
02-22-05 09:40 perex          Status                   assigned => resolved
02-22-05 09:40 perex          Resolution               open => fixed       
02-22-05 09:40 perex          Note Added: 0003688                          
05-31-05 18:04 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
