From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001052]: Riptide/Context Audio Drivers
Date: Fri, 8 Jul 2005 14:57:32 +0200
Message-ID: <adc05781f64fcb866b002e2a8c55cc28@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9B43517C
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 14:57:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1052> 
======================================================================
Reported By:                JKnife
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1052
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-13-2005 21:59 CEST
Last Modified:              07-08-2005 14:57 CEST
======================================================================
Summary:                    Riptide/Context Audio Drivers
Description: 
there is a set but its only for the 2.4 kernel.
i would like you toinclude them in alsa.
the 2.4 drivers can be found here
http://www.linuxant.com/drivers/
======================================================================

----------------------------------------------------------------------
 nokos - 06-27-05 18:35 
----------------------------------------------------------------------
I have made a patch against alsa-1.0.9b
(http://euclid.math.brandeis.edu/~gruberp/riptide-alsa-1.0.9b.patch.gz)

It compiles (at least for me), but I cannot test it since my Riptide chip
is at least 2k km away for the next few weeks.

Also I'm not sure if I put everything into the right places ;)

As far as I understand the request_firmware stuff asks hotplug to find a
firmware named riptide-fw ... make sure it finds the riptide.hex file from
the linuxant driver package under that name.

----------------------------------------------------------------------
 tiwai - 07-08-05 14:57 
----------------------------------------------------------------------
Can anyone test the patch?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 21:59 JKnife         New Issue                                    
04-13-05 22:01 JKnife         Note Added: 0004479                          
06-06-05 10:51 perex          Assigned To              perex =>            
06-06-05 10:51 perex          Category                 ISA - GUS (classic, max,
extreme, interwave) => OTHERS
06-08-05 15:15 tiwai          Note Added: 0004932                          
06-08-05 23:25 JKnife         Note Added: 0004976                          
06-15-05 14:41 nokos          Note Added: 0005027                          
06-23-05 12:07 tiwai          Note Added: 0005176                          
06-23-05 15:10 nokos          Note Added: 0005187                          
06-23-05 15:21 tiwai          Note Added: 0005188                          
06-23-05 15:26 tiwai          Note Added: 0005189                          
06-23-05 15:35 nokos          Note Added: 0005190                          
06-24-05 15:09 tiwai          Note Added: 0005226                          
06-26-05 22:48 JKnife         Note Added: 0005268                          
06-27-05 18:35 nokos          Note Added: 0005285                          
07-08-05 14:57 tiwai          Note Added: 0005430                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
