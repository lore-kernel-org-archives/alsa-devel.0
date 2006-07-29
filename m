From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002307]: I have sound but can't use a
	working microphone
Date: Sat, 29 Jul 2006 15:39:04 +0200
Message-ID: <c7128307c99fe510d79d1ba7a0797fd0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ABA81181
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 15:39:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2307> 
======================================================================
Reported By:                Fred
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2307
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Dapper Drake
Kernel Version:             2.6.15-26
======================================================================
Date Submitted:             07-27-2006 23:39 CEST
Last Modified:              07-29-2006 15:39 CEST
======================================================================
Summary:                    I have sound but can't use a working microphone
Description: 
Everything is working but the microphone simply doesn't work.
It seems really weird because the microphone seems to work : I hear myself
and I can do Larsen. But no application wants to record something
(sound-recorder, skype, gnome-sound-recorder). (and I know the microphone
is working on another PC)

Furthermore, I know alsa is working because when I switch to Mic2, I can't
hear myself and I can't do Larsen anymore.

======================================================================

----------------------------------------------------------------------
 jaime - 07-29-06 12:27 
----------------------------------------------------------------------
Fred,

You might find a work-around in here somewhere:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2076

----------------------------------------------------------------------
 Fred - 07-29-06 15:39 
----------------------------------------------------------------------
you were right,
Thanks a lot

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-27-06 23:39 Fred           New Issue                                    
07-27-06 23:39 Fred           Distribution              => Ubuntu Dapper Drake
07-27-06 23:39 Fred           Kernel Version            => 2.6.15-26       
07-29-06 12:27 jaime          Note Added: 0011301                          
07-29-06 15:39 Fred           Note Added: 0011307                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
