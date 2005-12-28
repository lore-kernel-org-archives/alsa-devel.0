From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001181]: ice1724: Invalid EEPROM version 1
Date: Wed, 28 Dec 2005 21:54:49 +0100
Message-ID: <24dc5673bf454a7401ae1aa63d6cd2da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B4E4D190
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 21:54:49 +0100 (MET)
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
Last Modified:              12-28-2005 21:54 CET
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
 bjl667 - 07-08-05 19:51 
----------------------------------------------------------------------
Yes I tried those options before, I'm still having problems using the alsa
part of the driver. Alsa oss works but only partially, I setup dmixer
as-well and I'm still not getting good results.  I included what it tells
me when I try using alsa itself instead of oss, under xmms.

 I tried a few more options (I know this isn't my card but look):
[ 3336.376279] ice1724: Using board model Albatron K8X800 Pro II 

 Its not giving me a warning about a invalid version of the EEPROM using
this why?  My sound problems still persist..



----------------------------------------------------------------------
 robhancock - 12-28-05 21:54 
----------------------------------------------------------------------
I think the "invalid EEPROM version" thing can likely be ignored.
Supposedly ICE1712 cards should use EEPROM version 1 and ICE1724 cards
should use version 2, but on many ICE1724 cards (including Chaintech
AV-710) the EEPROM version indicates version 1. I don't think this really
affects anything.

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
07-08-05 19:14 bjl667         File Added: xmms-snap.jpg                    
07-08-05 19:51 bjl667         Note Edited: 0005434                         
07-08-05 19:51 bjl667         Note Edited: 0005434                         
12-28-05 21:54 robhancock     Note Added: 0007181                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
