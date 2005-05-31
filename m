From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000888]: Mic IN is not working with kernel 2.6.10 on Asus A8V Deluxe
Date: Tue, 31 May 2005 18:04:09 +0200
Message-ID: <57182c03b0d55bbd9f17373bdca2a5e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 05C7A1B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:04:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=888> 
======================================================================
Reported By:                pv2c
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   888
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             02-06-2005 18:09 CET
Last Modified:              05-31-2005 18:04 CEST
======================================================================
Summary:                    Mic IN is not working with kernel 2.6.10 on Asus A8V
Deluxe
Description: 
After upgrade from kernel 2.6.9 to 2.6.10 the mic in stopped to work on my
Asus A8V Deluxe motherboard integrated soundcard. I'm using alsa kernel
module via82xx and it seems that after adding support for revision 8237 it
stops to work. So I obfuscated the
#define VIA_REV_8237        0x60
to a fake value and the mic started to work again.
======================================================================

----------------------------------------------------------------------
 pv2c - 02-09-05 13:25 
----------------------------------------------------------------------
I'm terribly sorry, for wasting Your time! Please discard this bugreport.
The problem was only in mixer settings which weren't restored after the
upgrade.

----------------------------------------------------------------------
 tiwai - 02-09-05 17:16 
----------------------------------------------------------------------
No problem, now closing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-05 18:09 pv2c           New Issue                                    
02-06-05 18:09 pv2c           Distribution              => Gentoo          
02-06-05 18:09 pv2c           Kernel Version            => 2.6.10          
02-06-05 18:13 pv2c           Note Added: 0003526                          
02-09-05 11:46 tiwai          Note Added: 0003541                          
02-09-05 13:25 pv2c           Note Added: 0003552                          
02-09-05 17:16 tiwai          Status                   new => resolved     
02-09-05 17:16 tiwai          Resolution               open => not an issue
02-09-05 17:16 tiwai          Assigned To               => tiwai           
02-09-05 17:16 tiwai          Note Added: 0003559                          
02-09-05 17:16 tiwai          Assigned To              tiwai =>            
05-31-05 18:04 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
