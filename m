From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001181]: ice1724: Invalid EEPROM version 1
Date: Fri, 8 Jul 2005 19:14:30 +0200
Message-ID: <245164efa920cb9412d0e7cccd12e992@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 30A2917A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 19:14:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1181> 
======================================================================
Reported By:                bjl667
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1181
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2005.0
Kernel Version:             2.6.12-rc4-love2
======================================================================
Date Submitted:             06-10-2005 22:28 CEST
Last Modified:              07-08-2005 19:14 CEST
======================================================================
Summary:                    ice1724: Invalid EEPROM version 1
Description: 
 Upon starting alsa, in dmesg I get:
 EcX / # dmesg | grep ice
 ice1724: Invalid EEPROM version 1

 EcX / # cat /proc/asound/cards
 0 [AV710          ]: ICE1724 - Chaintech AV-710
                      Chaintech AV-710 at 0xa000, irq 16

 I can play music in XMMS.. Then close it after that my sound stops
working I gotta restart alsasound to make it work again. I dunno wtf it is
my card is a Chaintech AV-710 (ENVY24HT-S)

 From what it seems this is another version of the Chaintech card..
======================================================================

----------------------------------------------------------------------
 tiwai - 07-08-05 12:08 
----------------------------------------------------------------------
Try to specify the model module option, for example, model=k8x800.
See ALSA-Configuration.txt for details.

----------------------------------------------------------------------
 bjl667 - 07-08-05 19:14 
----------------------------------------------------------------------
Yes I tried those options before, I'm still having problems using the alsa
part of the driver. Alsa oss works but only partially, I setup dmixer
as-well and I'm still not getting good results.  I included what it tells
me when I try using alsa itself instead of oss, under xmms.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-10-05 22:28 bjl667         New Issue                                    
06-10-05 22:28 bjl667         Distribution              => Gentoo 2005.0   
06-10-05 22:28 bjl667         Kernel Version            => 2.6.12-rc4-love2
06-14-05 01:56 bjl667         Note Added: 0005014                          
06-15-05 22:35 bjl667         Note Added: 0005047                          
06-16-05 00:00 bjl667         Note Edited: 0005047                         
06-17-05 22:48 bjl667         Note Added: 0005081                          
06-18-05 12:24 bjl667         Note Edited: 0005081                         
06-18-05 12:26 bjl667         Note Deleted: 0005014                        
06-20-05 02:41 bjl667         Note Edited: 0005047                         
06-25-05 02:12 bjl667         Note Added: 0005255                          
06-30-05 21:12 bjl667         Note Edited: 0005255                         
07-04-05 08:46 bjl667         Note Added: 0005381                          
07-05-05 04:15 bjl667         Note Added: 0005389                          
07-05-05 04:16 bjl667         Note Deleted: 0005047                        
07-06-05 21:44 bjl667         Note Deleted: 0005389                        
07-06-05 21:56 bjl667         Note Edited: 0005381                         
07-08-05 12:08 tiwai          Note Added: 0005414                          
07-08-05 19:14 bjl667         Note Added: 0005434                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
