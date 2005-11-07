From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001192]: Microphone doesn't work in record and/or Skype
Date: Mon, 7 Nov 2005 20:55:56 +0100
Message-ID: <662891fd5e1a43bd015c3b285097c6b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65D651A2
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2005 20:56:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1192> 
======================================================================
Reported By:                iljaguaro
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1192
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian Testing "Etch"
Kernel Version:             kernel-image-2.6.11-1-k7
======================================================================
Date Submitted:             06-15-2005 11:38 CEST
Last Modified:              11-07-2005 20:55 CET
======================================================================
Summary:                    Microphone doesn't work in record and/or Skype
Description: 
The microphone input doesnt work well, the volume are too low and the noisy
is to high, when you record it.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000183 Mic boost boosts mic playback and not r...
related to          0000653 poor microphone recording quality on pc...
======================================================================

----------------------------------------------------------------------
 schorpp - 08-04-05 13:59 
----------------------------------------------------------------------
patch -p[n] < cmipci-mic-boost2.diff

you need alsa driver sources in cvs version and linux kernel sources
installed(?).

----------------------------------------------------------------------
 thorstenhirsch - 11-07-05 20:55 
----------------------------------------------------------------------
Problem is solved since alsa 1.0.10rc1 / kernel 2.6.13

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-05 11:38 iljaguaro      New Issue                                    
06-15-05 11:38 iljaguaro      Distribution              => Debian Testing "Etch"
06-15-05 11:38 iljaguaro      Kernel Version            =>
kernel-image-2.6.11-1-k7
06-24-05 08:11 iljaguaro      Note Added: 0005203                          
06-24-05 15:00 tiwai          Note Added: 0005224                          
06-24-05 15:01 tiwai          File Added: cmipci-mic-boost2.diff                
   
06-26-05 11:46 iljaguaro      Note Added: 0005262                          
06-26-05 23:21 sst4           Note Added: 0005269                          
06-27-05 15:57 tiwai          Relationship added       related to 0000183  
06-27-05 15:58 tiwai          Relationship added       related to 0000653  
07-16-05 19:58 mlehto         Note Added: 0005501                          
07-16-05 20:11 mlehto         Issue Monitored: mlehto                      
08-04-05 08:36 dino           Note Added: 0005640                          
08-04-05 13:59 schorpp        Note Added: 0005647                          
11-07-05 20:55 thorstenhirsch Note Added: 0006617                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
