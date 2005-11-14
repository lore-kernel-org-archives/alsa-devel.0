From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001242]: echoaudio layla 20 doesn't compile
Date: Mon, 14 Nov 2005 10:30:40 +0100
Message-ID: <fb5d9581ee0d68344044225710f9f61f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4EC019E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 10:30:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1242> 
======================================================================
Reported By:                hennewou
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1242
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               debian
Kernel Version:             2.4.25
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             07-08-2005 12:57 CEST
Last Modified:              11-14-2005 10:30 CET
======================================================================
Summary:                    echoaudio layla 20 doesn't compile
Description: 
Hi, 


I tried to compile alsa-driver for echoaudio layla20:

./configure --with-cards=layla20 --with-sequencer=yes;make;make install

Allthough I see the file pci/echoaudio/layla20.c in the alsa-driver tree,
I allways get the same error for all latest versions (1.0.9 series):

checking for which soundcards to compile driver for... configure: error:
Unsupported soundcard layla20


Greetings Hendrik

======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 10:30 
----------------------------------------------------------------------
Try 1.0.10rc3.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-08-05 12:57 hennewou       New Issue                                    
07-08-05 12:57 hennewou       Distribution              => debian          
07-08-05 12:57 hennewou       Kernel Version            => 2.4.25          
11-14-05 10:30 perex          Status                   assigned => resolved
11-14-05 10:30 perex          Resolution               open => unable to
duplicate
11-14-05 10:30 perex          Note Added: 0006706                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
