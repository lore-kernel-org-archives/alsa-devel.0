From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000194]: Prodigy 192 -  Eprom incorrect size?
Date: Tue,  7 Sep 2004 16:37:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907143716.BB996E01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0CEE828E
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 16:37:17 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000194
======================================================================
Reported By:                jvlake
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     194
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     confirmed
Distribution:               RedHat 9 _ 2.4.20.8
Kernel Version:             RedHat9 _ 2.4.20.8
======================================================================
Date Submitted:             04-07-2004 06:06 CEST
Last Modified:              09-07-2004 16:37 CEST
======================================================================
Summary:                    Prodigy 192 -  Eprom incorrect size?
Description: 
after compiling the driver and rebooting i get a message that the eprom is
the wrong size for my card (on startup) needless to say, I also get no
sound. I am assuming this is because this card is not a 'prodigy 7.1' but
a 'prodigy 192' even though both cards are made by Audiotrak are 24/192khz
& 7.1. to look at the cards they are almost identical. is there anyway I
can get the driver to work?
======================================================================

----------------------------------------------------------------------
 jvlake - 04-07-2004 06:09 CEST 
----------------------------------------------------------------------
oops, that would be ICE1724 not 1712, never mind same error either way.

----------------------------------------------------------------------
 perex - 04-07-2004 19:54 CEST 
----------------------------------------------------------------------
Only Prodigy 7.1 card is supported at this time.

----------------------------------------------------------------------
 tiwai - 04-16-2004 16:00 CEST 
----------------------------------------------------------------------
the board has apparently no EEPROM as well as prodigy 7.1.
you have to provide the EEPROM image.

at your own risk, you can try to change the subvendor value to the
corresponding one in prodigy.c, so that the driver believes that's
prodigy 7.1.

----------------------------------------------------------------------
 Apostolos Dimitromanolakis - 06-18-2004 17:45 CEST 
----------------------------------------------------------------------
Hmm.. If this card uses the same chips as the Prodigy that would be easy to
modify the driver. Can you send a picture of the top of the board ?

----------------------------------------------------------------------
 co2b - 09-07-2004 16:37 CEST 
----------------------------------------------------------------------
Prodigy192 uses Sigmatel STAC9460 audio codec, so Prodigy7.1 driver does
not work.
STAC9460 data sheet is here:
http://www.sigmatel.com/products/technical_docs.htm#9460

I wrote a patch for this card (it is against Linux-2.6.8-rc2).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-07-04 06:06 jvlake         New Bug                                      
04-07-04 06:06 jvlake         Distribution              => RedHat 9 _ 2.4.20.8
04-07-04 06:06 jvlake         Kernel Version            => RedHat9 _ 2.4.20.8
04-07-04 06:09 jvlake         Bugnote Added: 0000760                       
04-07-04 06:10 jvlake         Bug Monitored: jvlake                        
04-07-04 19:47 perex          Category                 PCI - ice1712 => PCI - ice1724
04-07-04 19:53 perex          Severity                 major => feature    
04-07-04 19:53 perex          Status                   new => confirmed    
04-07-04 19:54 perex          Bugnote Added: 0000763                       
04-16-04 16:00 tiwai          Bugnote Added: 0000838                       
06-18-04 17:45 Apostolos DimitromanolakisBugnote Added: 0001319                       
06-18-04 18:01 Apostolos DimitromanolakisBug Monitored: Apostolos Dimitromanolakis                    
09-07-04 16:37 co2b           Bugnote Added: 0001711                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
