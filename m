From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002296]: AV710 - Only 2 channels on
	Optical Out
Date: Mon, 24 Jul 2006 17:23:34 +0200
Message-ID: <773257406946a9e541692d555da7118f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D4F2A23B
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Jul 2006 17:23:34 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Status:                     feedback
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r7
======================================================================
Date Submitted:             07-21-2006 06:35 CEST
Last Modified:              07-24-2006 17:23 CEST
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
 Mobian - 07-21-06 21:53 
----------------------------------------------------------------------
Ah, good to know this is the correct behavior.  Can you please point me in
the right direction on how to configure the a52 plugin?  I searched the
ALSA Wiki and googled it and am coming up with nothing.  I would really
appreciate any direction you could provide, this is positively driving me
mad.... Thanks!

----------------------------------------------------------------------
 Mobian - 07-24-06 17:23 
----------------------------------------------------------------------
OK, I finally have true AC3 and DTS passthrough working on this soundcard. 
I used the attached asound.conf that sets up the default as "type dmix". 
For some reason, I still don't get speaker-test to play through all 5
speakers, but playing movies that are in Dolby Digital or DTS all do
exactly as they should with my external DD/DTS stereo decoder.  Anyhow,
hope this helps someone else later.

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
07-21-06 21:53 Mobian         Status                   resolved => feedback
07-21-06 21:53 Mobian         Resolution               not an issue => reopened
07-21-06 21:53 Mobian         Note Added: 0011156                          
07-21-06 21:53 Mobian         Issue Monitored: Mobian                      
07-24-06 17:23 Mobian         Note Added: 0011211                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
