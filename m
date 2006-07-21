From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002296]: AV710 - Only 2 channels on
	Optical Out
Date: Fri, 21 Jul 2006 20:10:47 +0200
Message-ID: <0bcbc685807bb7e40854076dec32a05f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A104234
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 20:10:48 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2296> 
======================================================================
Reported By:                Mobian
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2296
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r7
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             07-21-2006 06:35 CEST
Last Modified:              07-21-2006 20:10 CEST
======================================================================
Summary:                    AV710 - Only 2 channels on Optical Out
Description: 
Despite having tried every asound.conf file I could find on the Internet
that is supposed to work with this card, I can only get 2 channels (front
left and front right) on the optical output of this card.

I tested this with a simple call to speaker-test -c5 in hopes of testing
5.1 features, but I only hear sound on the front left and front right
speakers.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-21-06 20:10 
----------------------------------------------------------------------
It's correct behavior.  SPDIF is basically for two linear PCM channels.

What you want is AC3 encoding.  You can try a52 plugin included in
alsa-plugins for real-time 5.1 encoding.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-06 06:35 Mobian         New Issue                                    
07-21-06 06:35 Mobian         Distribution              => Gentoo          
07-21-06 06:35 Mobian         Kernel Version            => 2.6.15-gentoo-r7
07-21-06 20:10 tiwai          Status                   new => resolved     
07-21-06 20:10 tiwai          Resolution               open => not an issue
07-21-06 20:10 tiwai          Assigned To               => tiwai           
07-21-06 20:10 tiwai          Note Added: 0011153                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
