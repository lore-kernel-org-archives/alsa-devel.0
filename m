From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000975]: snd-hda-intel, no sound, no master control
Date: Tue, 31 May 2005 18:03:43 +0200
Message-ID: <fc75f6cfb63122a9cf580f566e2675d5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B7F9E1B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=975> 
======================================================================
Reported By:                dirk-loesche
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   975
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Suse 9.2
Kernel Version:             2.6.11.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-08-2005 21:57 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    snd-hda-intel, no sound, no master control
Description: 
No sound.

alsaconf:
I cant hear test sound.

alsamixer:
Card: HDA Intel                                                           
                                                         
Chip: Realtek ALC260                                                      
                                                         View: Playback   
                                                                          
                                       Item: Headphone

Headphon PCM Line CD Mic PC Speak Capture to 100 and unmutem
Master not presend!
======================================================================

----------------------------------------------------------------------
 dirk-loesche - 03-09-05 15:44 
----------------------------------------------------------------------
Soundmixer by WindowsXP
Master 
Wave 
SW Synt 
SPDIF 
CD Player
PC Speaker
Microphon

By Alsamixer no Master

xmms play sound - i cant hear
CD and Mic silent



----------------------------------------------------------------------
 tiwai - 03-09-05 17:13 
----------------------------------------------------------------------
Some bugs have been already fixed on CVS.

This controller has no real "Master" volume.  The volume for headphone and
front line-out are separate.  This is not a bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-08-05 21:57 dirk-loesche   New Issue                                    
03-08-05 21:57 dirk-loesche   Distribution              => Suse 9.2        
03-08-05 21:57 dirk-loesche   Kernel Version            => 2.6.11.1        
03-08-05 22:08 dirk-loesche   Issue Monitored: dirk-loesche                    
03-08-05 22:45 dirk-loesche   Issue End Monitor: dirk-loesche                   

03-09-05 15:42 dirk-loesche   Note Added: 0003827                          
03-09-05 15:44 dirk-loesche   Note Edited: 0003827                         
03-09-05 17:13 tiwai          Status                   new => resolved     
03-09-05 17:13 tiwai          Resolution               open => fixed       
03-09-05 17:13 tiwai          Assigned To               => tiwai           
03-09-05 17:13 tiwai          Note Added: 0003828                          
03-09-05 17:13 tiwai          Assigned To              tiwai =>            
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
