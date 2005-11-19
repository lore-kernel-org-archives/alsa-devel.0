From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001577]: No sound in ALSA in linux-2.6.13
Date: Sat, 19 Nov 2005 08:54:43 +0100
Message-ID: <ab44d0e77b844cf96f931e17b87636ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D62117B
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2005 08:54:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1577> 
======================================================================
Reported By:                mohamed uvais
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1577
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             11-19-2005 08:54 CET
Last Modified:              11-19-2005 08:54 CET
======================================================================
Summary:                    No sound in ALSA in linux-2.6.13
Description: 
I am using linux-2.6.13 PXA27x(ARM) ,This is having ALSA,After i installed
this kernel to my board,I couldn't able to play any music.IF i play the
any audio file then i could receive the continous print like below,
    write 4096 bytes(wrote 4096 bytes)
I have checked the drivers/asound directory also.Its fine.
Also i gave one printk in the sound/arm/pxa2xx-pcm.c file in irq
function,After that i received the continuous print of that added one.I
think the problem is repeated irq & no sound.What is the solution for this
one.
Here i attached the drivers/asound directory results.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-19-05 08:54 mohamed uvais  New Issue                                    
11-19-05 08:54 mohamed uvais  File Added: capture                          
11-19-05 08:54 mohamed uvais  Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
