From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000860]: Wrong detection of opl3 device
Date: Tue, 31 May 2005 18:04:11 +0200
Message-ID: <6a18be197f458991a54f289c8d8cec0f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 643B61B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:04:11 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=860> 
======================================================================
Reported By:                theli
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   860
Category:                   ISA - als100
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.10-ck4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-29-2005 18:20 CET
Last Modified:              05-31-2005 18:04 CEST
======================================================================
Summary:                    Wrong detection of opl3 device
Description: 
driver als100.c has
        acard->devmpu = pnp_request_card_device(card, id->devs[1].id,
acard->dev);
        acard->devopl = pnp_request_card_device(card, id->devs[2].id,
acard->devmpu);
in "static int __devinit snd_card_als100_pnp".

so search for opl device starts from devmpu...
and in my MF1000 opl device is 00:01.03
and opl3 is 00:01.01 so it can't be found that way ...
and devopl is NULL :(

but opl3 works when changed above code to 

        acard->devmpu = pnp_request_card_device(card, id->devs[1].id,
acard->dev);
        acard->devopl = pnp_request_card_device(card, id->devs[2].id,
acard->dev);

(search of opl3 starts from acard->dev )
and that should work in any case

PS: sorry for my english.
PPS: don't even know does anyone else use such old sound card.
PPPS: was fighting with alsa for weeks trying to get opl3 working before
decided to look in sources.
======================================================================

----------------------------------------------------------------------
 theli - 02-07-05 16:13 
----------------------------------------------------------------------
well i've added signed-off-by and description in patch...
but .... well, my english is far from perfect :)

(hm, wonder why i can't delete attachment, uploaded by me?)

----------------------------------------------------------------------
 Clemens Ladisch - 02-07-05 16:21 
----------------------------------------------------------------------
Applied to CVS, thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-05 18:20 theli          New Issue                                    
01-29-05 18:20 theli          Kernel Version            => 2.6.10-ck4      
01-29-05 18:42 theli          Issue Monitored: theli                       
01-29-05 19:43 theli          Note Added: 0003439                          
02-05-05 19:53 theli          File Added: als100_opl3_fix.patch                 
  
02-05-05 19:54 theli          Note Added: 0003523                          
02-07-05 10:50 Clemens LadischNote Added: 0003529                          
02-07-05 16:06 theli          File Added: als100_opl3_fixx.patch                
   
02-07-05 16:13 theli          Note Added: 0003531                          
02-07-05 16:21 Clemens LadischStatus                   new => resolved     
02-07-05 16:21 Clemens LadischResolution               open => fixed       
02-07-05 16:21 Clemens LadischAssigned To               => Clemens Ladisch 
02-07-05 16:21 Clemens LadischNote Added: 0003532                          
02-07-05 16:21 Clemens LadischAssigned To              Clemens Ladisch =>  
05-31-05 18:04 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
