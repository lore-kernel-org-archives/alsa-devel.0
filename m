From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001991]: make errors
Date: Mon, 10 Apr 2006 17:04:22 +0200
Message-ID: <ea56c274e2be447e38db92fbb7d67522@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64AB5184
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 17:04:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1991> 
======================================================================
Reported By:                stan senuta
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1991
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake-9.2
Kernel Version:             2.6.16
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             04-02-2006 14:27 CEST
Last Modified:              04-10-2006 17:04 CEST
======================================================================
Summary:                    make errors
Description: 
I have the kernel-built snd-via82.ko module which will only play a sound
file for about one or two seconds and then stops. Therefore I tried to
build the alsa-driver- 1.0.10 module but it fails at the "make" 

My hope is that the alsa-driver-1.0.10 has a more up to date snd-via82xx
module
======================================================================

----------------------------------------------------------------------
 tiwai - 04-10-06 17:04 
----------------------------------------------------------------------
ALSA 1.0.10 doesn't work with 2.6.15 or later kernel.  It was released
before 2.6.15.  Use the later version of ALSA.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-06 14:27 stan senuta    New Issue                                    
04-02-06 14:27 stan senuta    File Added: alsa-make-error                    
04-02-06 14:27 stan senuta    Distribution              => Mandrake-9.2    
04-02-06 14:27 stan senuta    Kernel Version            => 2.6.16          
04-10-06 17:04 tiwai          Status                   assigned => resolved
04-10-06 17:04 tiwai          Resolution               open => won't fix   
04-10-06 17:04 tiwai          Note Added: 0009202                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
