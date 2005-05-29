From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001105]: Hidden volumes
Date: Sun, 29 May 2005 23:48:04 +0200
Message-ID: <385dde7b1ff541b9b44c6be10a52c5fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C05E1A4
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 23:48:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1105> 
======================================================================
Reported By:                Yota_VGA
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1105
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.8-gentoo-r9
======================================================================
Date Submitted:             05-13-2005 20:05 CEST
Last Modified:              05-29-2005 23:48 CEST
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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
