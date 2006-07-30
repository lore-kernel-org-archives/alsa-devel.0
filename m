From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002077]: emu10k1 will not use S24_LE
Date: Sun, 30 Jul 2006 18:22:18 +0200
Message-ID: <130b2f6499b675542f6f9cc8cc38883d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A67BE166
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 18:22:18 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2077> 
======================================================================
Reported By:                braininajar
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2077
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               gentoo
Kernel Version:             2.6.16
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-26-2006 21:51 CEST
Last Modified:              07-30-2006 18:22 CEST
======================================================================
Summary:                    emu10k1 will not use S24_LE
Description: 
The Audigy2 is a 24-bit, 96k card. It will handle 24 bit, 96k samples. For
some reason or other, the emu10k1 driver will not let it
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-26-06 22:20 
----------------------------------------------------------------------
Please provide output from:
cat /proc/asound/cards
cat /proc/asound/version

24bit is not supported on all Audigy cards in linux yet.
The 24bit is a special mode that bypassed the DSP.
Unfortunately, the bypass method is different one almost every Audigy
card, so until all the different methods are supported, it will not work
on all Audigy cards.

Also 24bit capture on a PC sound card is next to pointless due to computer
noise introduced and low quality codecs and front end components. You
might get 18bits of real quality, but I doubt even that.

There are exceptions to that in the really expensive professional sound
capture devices that also have a PC interface, but very few of them work
with Linux. E.g. the EMU1212m.

James

----------------------------------------------------------------------
 jcdutton - 07-30-06 18:22 
----------------------------------------------------------------------
Closed due to lack of feedback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 21:51 braininajar    New Issue                                    
04-26-06 21:51 braininajar    Distribution              => gentoo          
04-26-06 21:51 braininajar    Kernel Version            => 2.6.16          
04-26-06 22:07 pzad           Note Added: 0009524                          
04-26-06 22:20 jcdutton       Note Added: 0009525                          
07-18-06 14:38 jcdutton       Status                   new => assigned     
07-18-06 14:38 jcdutton       Assigned To               => jcdutton        
07-30-06 18:22 jcdutton       Status                   assigned => closed  
07-30-06 18:22 jcdutton       Note Added: 0011324                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
