From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001105]: Hidden volumes
Date: Tue, 18 Jul 2006 14:45:55 +0200
Message-ID: <4a8c53c2f663edcdadda1cab4dbd019c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1A331AC
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:45:55 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1105> 
======================================================================
Reported By:                Yota_VGA
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1105
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.8-gentoo-r9
======================================================================
Date Submitted:             05-13-2005 20:05 CEST
Last Modified:              07-18-2006 14:45 CEST
======================================================================
Summary:                    Hidden volumes
Description: 
With my system (Sound blaster live! player 1024, linux kernel
2.6.8-gentoo-r9) some volumes don't compare at startup. But if I play a
sound this magically compare in the mixer. And if I change some of this
volumes and re-play a song this rechange to previous values.
======================================================================

----------------------------------------------------------------------
 rlrevell - 05-29-05 23:48 
----------------------------------------------------------------------
What are you using to play the sounds?  Some apps like mplayer seem to
remember the last volume you set with the mplayer volume control, then
grab the master volume or PCM control on startup and set it to that. 
Unfortunately they don't always restore it to the previous value.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-05 20:05 Yota_VGA       New Issue                                    
05-13-05 20:05 Yota_VGA       Distribution              => gentoo          
05-13-05 20:05 Yota_VGA       Kernel Version            => 2.6.8-gentoo-r9 
05-13-05 22:42 Yota_VGA       Issue Monitored: Yota_VGA                    
05-13-05 22:42 Yota_VGA       Issue End Monitor: Yota_VGA                    
05-29-05 23:48 rlrevell       Note Added: 0004792                          
07-18-06 14:45 jcdutton       Status                   new => assigned     
07-18-06 14:45 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
