From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001192]: Microphone doesn't work in record and/or Skype
Date: Thu, 4 Aug 2005 13:59:30 +0200
Message-ID: <0062189c3bfa3bc6427ea9984317697b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7020202
	for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2005 13:59:30 +0200 (MEST)
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
Last Modified:              08-04-2005 13:59 CEST
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
 dino - 08-04-05 08:36 
----------------------------------------------------------------------
How can I patch the file? Can any one tell me what to do!
And which file I must patch in ma system?

----------------------------------------------------------------------
 schorpp - 08-04-05 13:59 
----------------------------------------------------------------------
patch -p[n] < cmipci-mic-boost2.diff

you need alsa driver sources in cvs version and linux kernel sources
installed(?).

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
