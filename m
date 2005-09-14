From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000466]: tumbler_init_client error after waking
Date: Wed, 14 Sep 2005 15:56:03 +0200
Message-ID: <7052ce65385882e553c2692a19f11c70@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D8B38191
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 15:56:05 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=466> 
======================================================================
Reported By:                schwab
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   466
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-26-2004 22:36 CEST
Last Modified:              09-14-2005 15:56 CEST
======================================================================
Summary:                    tumbler_init_client error after waking
Description: 
After waking up the driver is unable to restore the sound settings.  I have
to explicitly load the settings to make sound working again.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-27-04 19:37 
----------------------------------------------------------------------
Can you try mm tree?  Many ppc fixes are there.

----------------------------------------------------------------------
 schwab - 10-21-04 23:24 
----------------------------------------------------------------------
With 2.6.9 I still get the same messages on wakeup, but at least the sound
works afterwards.

----------------------------------------------------------------------
 jdthood - 09-14-05 15:56 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-26-04 22:36 schwab         New Issue                                    
08-27-04 19:37 tiwai          Note Added: 0001647                          
10-21-04 23:24 schwab         Note Added: 0002225                          
09-14-05 15:56 jdthood        Note Added: 0006164                          
09-14-05 15:56 jdthood        Summary                  tumbler_init_client error
=> tumbler_init_client error after waking
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
