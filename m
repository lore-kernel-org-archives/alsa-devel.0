From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000857]: intel8x0m does not work on asus a3n laptop
Date: Sun, 3 Apr 2005 01:49:10 +0200
Message-ID: <2b26e84cf68c3b0fedf8ba30be119f60@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A541C206
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 01:49:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=857> 
======================================================================
Reported By:                mart
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   857
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               slackware 10
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-29-2005 16:43 CET
Last Modified:              04-03-2005 01:49 CEST
======================================================================
Summary:                    intel8x0m does not work on asus a3n laptop
Description: 
with this laptop, the sound by intel8x0 works ok, but the modem with the 
alsa-driver intel8x0m and slmodemd 2.9.10 does not.
slmodemd starts ok, it opens the alsa device hw:1 that is tje modem, but
when i try to dial a number (i tried with kppp and minicom) the modem does
dial, but after a while it quits with a NO ANSWER error.
making some exprtiments, i found that when i connect under windows, if i
listen to the phone connected to the same line, i can hear the tones
gererated by the modem, but when i dial under linux i can't hear anything,
so i think this is a driver issue, the driver that can't make the modem
produce any sound.

this is what lspci tells me on that modem:
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000509 Conexant Moden &quot;not ready&quot;
related to          0000890 no dialtone with modem &amp; strange lo...
======================================================================

----------------------------------------------------------------------
 metal - 03-24-05 20:25 
----------------------------------------------------------------------
I have similar trouble on roverbook w510L. Errors in log:
semaphore is not ready [0x1][0x701300]
codec_write 1: semaphore is not ready for register 0x54
lspci | grep Modem:
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)
It don't work with kernel 2.6.10, 2.6.11.
This modem work with kernel 2.4.29 and slamr driver from Smart Link Ltd.

----------------------------------------------------------------------
 sashak - 04-03-05 01:49 
----------------------------------------------------------------------
Don't think it is same - slamr does not work with conexant codec. It is
different problem here.
But "not ready semaphore" should be fixed by this patch:

Index: alsa-kernel/pci/intel8x0m.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0m.c,v
retrieving revision 1.30
diff -u -b -B -r1.30 intel8x0m.c
--- alsa-kernel/pci/intel8x0m.c 8 Mar 2005 16:35:32 -0000       1.30
+++ alsa-kernel/pci/intel8x0m.c 2 Apr 2005 23:38:46 -0000
@@ -500,6 +500,8 @@
                        res = 0xffff;
                }
        }
+       if (reg == AC97_GPIO_STATUS)
+               iagetword(chip, 0); /* clear semaphore */
        return res;
 }


Regards,
Sasha.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-05 16:43 mart           New Issue                                    
01-29-05 16:43 mart           Distribution              => slackware 10    
01-29-05 16:43 mart           Kernel Version            => 2.6.10          
01-29-05 16:44 mart           Issue Monitored: mart                        
02-03-05 21:55 mart           Note Added: 0003494                          
02-03-05 23:21 sashak         Note Added: 0003495                          
02-04-05 13:10 mart           Note Added: 0003501                          
03-02-05 14:12 perex          Relationship added       related to 0000509  
03-02-05 15:19 perex          Relationship added       related to 0000890  
03-24-05 20:25 metal          Note Added: 0004200                          
04-03-05 01:49 sashak         Note Added: 0004301                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
