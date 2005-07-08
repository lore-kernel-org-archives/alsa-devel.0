From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001242]: echoaudio layla 20 doesn't compile
Date: Fri, 8 Jul 2005 12:57:35 +0200
Message-ID: <09d17617c7d11259317ca10e2f3826cd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E8E60142
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 12:57:35 +0200 (MEST)
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
Status:                     assigned
Distribution:               debian
Kernel Version:             2.4.25
======================================================================
Date Submitted:             07-08-2005 12:57 CEST
Last Modified:              07-08-2005 12:57 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-08-05 12:57 hennewou       New Issue                                    
07-08-05 12:57 hennewou       Distribution              => debian          
07-08-05 12:57 hennewou       Kernel Version            => 2.4.25          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
