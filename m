From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000955]: CN-126 - USB 5.1 Audio adapter
Date: Thu, 22 Sep 2005 14:56:02 +0200
Message-ID: <d9b77c7278c9f2eedd441bcabee32ca9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 48F60146
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 14:56:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=955> 
======================================================================
Reported By:                mano1979
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   955
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.1
Kernel Version:             2.6.10.3
======================================================================
Date Submitted:             03-02-2005 00:13 CET
Last Modified:              09-22-2005 14:56 CEST
======================================================================
Summary:                    CN-126 - USB 5.1 Audio adapter
Description: 
I am in really need of a driver for this card. It needs to support 5.1
surround and speaker setup....... well like the original software.

Please let me know if you're able to make it.

Regards, 

Armand Blaaker
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 03-02-05 15:07 
----------------------------------------------------------------------
Create a file named .asoundrc in your home directory (or a file named
/etc/asound.conf if is hould be available for all users) and copy the
lines from
"pcm.umpix" to the last "}" into it.

The configure your applications to use device name "upmix" instead of
"default" or "hw:?".

----------------------------------------------------------------------
 jdthood - 09-22-05 14:56 
----------------------------------------------------------------------
mano1979: Were you able to solve this problem with the advice provided?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 00:13 mano1979       New Issue                                    
03-02-05 00:13 mano1979       Distribution              => Mandrake 10.1   
03-02-05 00:13 mano1979       Kernel Version            => 2.6.10.3        
03-02-05 00:14 mano1979       Issue Monitored: mano1979                    
03-02-05 09:28 Clemens LadischNote Added: 0003762                          
03-02-05 12:34 mano1979       Note Added: 0003763                          
03-02-05 12:44 Clemens LadischNote Added: 0003764                          
03-02-05 12:46 mano1979       Note Added: 0003765                          
03-02-05 12:48 mano1979       Note Added: 0003766                          
03-02-05 12:58 Clemens LadischNote Added: 0003767                          
03-02-05 13:05 mano1979       Note Added: 0003769                          
03-02-05 14:14 Clemens LadischNote Added: 0003773                          
03-02-05 14:19 mano1979       Note Added: 0003774                          
03-02-05 15:07 Clemens LadischNote Added: 0003777                          
03-03-05 11:44 perex          View Status              private => public   
09-22-05 14:56 jdthood        Note Added: 0006337                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
