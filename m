From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001171]: via8235 alc650f - miss "Line-In As Surround" "Mic As Center/LFE"
Date: Wed, 8 Jun 2005 14:13:57 +0200
Message-ID: <37ead06cb21f46c704b116a7b20ee2b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C84D31E7
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 14:13:57 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1171> 
======================================================================
Reported By:                norbert
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1171
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-08-2005 14:10 CEST
Last Modified:              06-08-2005 14:13 CEST
======================================================================
Summary:                    via8235 alc650f - miss "Line-In As Surround" "Mic As
Center/LFE"
Description: 
I miss the 

"Line-In As Surround"

"Mic As Center/LFE"

buttons.

It worked before, see bug 0000043.
(kernel 2.6.11.11 / alsa 1.0.9a)

I'll give more info if needed.
Norbert
======================================================================

----------------------------------------------------------------------
 norbert - 06-08-05 14:13 
----------------------------------------------------------------------
I'm not sure if this is related, but dmesg gives me lot of this:

ALSA
/hdb3/tmp/DL/i386/my/manual/alsa/alsa-driver-1.0.9a/alsa-kernel/pci/via82xx.c:796:
zero position is read

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 14:10 norbert        New Issue                                    
06-08-05 14:13 norbert        Note Added: 0004917                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
