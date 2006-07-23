From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001404]: (Apparently) no microphone
	support
Date: Sun, 23 Jul 2006 19:08:22 +0200
Message-ID: <d06ad0a95f10bf62a9ef1801997d7445@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8B5424C
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 19:08:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1404> 
======================================================================
Reported By:                Twey
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1404
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 4
Kernel Version:             2.6.13-homegrown
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-08-2005 18:40 CEST
Last Modified:              07-23-2006 19:08 CEST
======================================================================
Summary:                    (Apparently) no microphone support
Description: 
My SB Live! 24-Bit has no microphone-related channels.  Using any mixer
(tried: alsamixer, kmix, gnome-volume-control), it seems not to support
microphones.
Audacity shows very small (pixel-size) distortions in the recording graph
at times.  I presume this means that the input is being received, but is
too miniscule to make a difference.  I can't do anything about this; there
are no appropriate sliders or "mic boost" in any mixer application.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-02-06 20:45 
----------------------------------------------------------------------
Any improvement with the 1.0.11-rc2 release?

----------------------------------------------------------------------
 jcdutton - 07-23-06 19:08 
----------------------------------------------------------------------
No feedback for over 3 months so closing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-05 18:40 Twey           New Issue                                    
09-08-05 18:40 Twey           Distribution              => Fedora Core 4   
09-08-05 18:40 Twey           Kernel Version            => 2.6.13-homegrown
09-08-05 18:43 Twey           Issue Monitored: Twey                        
09-08-05 18:46 rlrevell       Note Added: 0006074                          
09-08-05 18:55 Twey           Note Added: 0006075                          
09-08-05 19:11 Twey           Note Added: 0006079                          
09-10-05 10:41 jcdutton       Note Added: 0006110                          
09-10-05 10:41 jcdutton       Status                   assigned => feedback
09-10-05 10:46 Twey           Note Added: 0006112                          
12-07-05 20:58 Twey           Note Added: 0006947                          
12-08-05 10:59 Twey           Note Edited: 0006947                         
01-02-06 20:45 rlrevell       Note Added: 0007389                          
07-23-06 19:08 jcdutton       Status                   feedback => closed  
07-23-06 19:08 jcdutton       Note Added: 0011201                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
