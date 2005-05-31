From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000836]: Intel HDA (C-Media 9880) - alsamixer/gamix - no slider control for Surround/Center/LFE/Side
Date: Tue, 31 May 2005 18:03:37 +0200
Message-ID: <c949b95257537867e1a458f553a171ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E1B31BF
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=836> 
======================================================================
Reported By:                jbrsubscribe
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   836
Category:                   PCI - azx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               Suse
Kernel Version:             2.6.8-24.10-smp
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-19-2005 18:19 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    Intel HDA (C-Media 9880) - alsamixer/gamix - no
slider control for Surround/Center/LFE/Side
Description: 
Unable to set volume control for Surround/Center/LFE/Side due to the fact
that the sliders for these entities do not function in alsamixer and
gamix. The sliders cannot be manipulated. The only functional sliders are
PCM, PC Speaker and the two (2) Capture sliders.
In KAMix, KMix and QAMix the sliders for Surround/Center/LFE/Side do not
appear at all.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-11-05 00:50 
----------------------------------------------------------------------
Can this be closed now?

----------------------------------------------------------------------
 tiwai - 03-11-05 12:13 
----------------------------------------------------------------------
Yes, let's close this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-19-05 18:19 jbrsubscribe   New Issue                                    
01-19-05 18:19 jbrsubscribe   File Added: aadebug                          
01-19-05 18:19 jbrsubscribe   Distribution              => Suse            
01-19-05 18:19 jbrsubscribe   Kernel Version            => 2.6.8-24.10-smp 
01-19-05 18:27 jbrsubscribe   Issue Monitored: jbrsubscribe                    
01-19-05 18:36 tiwai          Status                   new => resolved     
01-19-05 18:36 tiwai          Resolution               open => not an issue
01-19-05 18:36 tiwai          Assigned To               => tiwai           
01-19-05 18:36 tiwai          Note Added: 0003311                          
01-19-05 18:36 tiwai          Assigned To              tiwai =>            
01-20-05 01:07 jbrsubscribe   Status                   resolved => feedback
01-20-05 01:07 jbrsubscribe   Resolution               not an issue => reopened
01-20-05 01:07 jbrsubscribe   Note Added: 0003320                          
01-20-05 01:51 jbrsubscribe   Note Added: 0003321                          
01-20-05 11:52 1g0R           Note Added: 0003325                          
01-20-05 18:42 jbrsubscribe   Note Added: 0003328                          
01-20-05 19:11 tiwai          Note Added: 0003331                          
01-21-05 00:30 jbrsubscribe   Note Added: 0003335                          
01-21-05 05:56 1g0R           Note Added: 0003338                          
01-21-05 08:16 mab            Note Added: 0003339                          
01-21-05 11:08 1g0R           Note Added: 0003340                          
01-21-05 12:04 tiwai          Note Added: 0003343                          
01-21-05 12:05 tiwai          Note Added: 0003344                          
01-21-05 16:55 mab            Note Added: 0003348                          
01-21-05 17:26 tiwai          Note Added: 0003349                          
01-21-05 22:08 1g0R           Note Added: 0003370                          
01-22-05 09:04 mab            Note Added: 0003373                          
01-22-05 09:06 mab            Note Edited: 0003373                         
01-22-05 12:33 1g0R           Note Added: 0003374                          
01-22-05 21:30 mab            Note Added: 0003378                          
01-22-05 21:43 mab            Note Edited: 0003378                         
01-23-05 02:43 1g0R           Note Added: 0003385                          
01-23-05 11:52 1g0R           Note Added: 0003387                          
01-24-05 12:18 tiwai          Note Added: 0003391                          
01-24-05 13:46 1g0R           Note Added: 0003392                          
01-24-05 14:40 jbrsubscribe   Note Added: 0003393                          
01-24-05 18:36 jbrsubscribe   Note Added: 0003394                          
01-24-05 18:55 1g0R           Note Added: 0003395                          
01-24-05 20:04 1g0R           Note Added: 0003396                          
01-25-05 12:19 1g0R           Note Added: 0003398                          
01-25-05 15:07 tiwai          Note Added: 0003399                          
01-25-05 15:11 tiwai          Note Added: 0003400                          
01-25-05 15:29 1g0R           Note Added: 0003406                          
03-11-05 00:50 jdthood        Note Added: 0003877                          
03-11-05 12:13 tiwai          Status                   feedback => resolved
03-11-05 12:13 tiwai          Resolution               reopened => fixed   
03-11-05 12:13 tiwai          Assigned To               => tiwai           
03-11-05 12:13 tiwai          Note Added: 0003885                          
03-11-05 12:13 tiwai          Assigned To              tiwai =>            
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
