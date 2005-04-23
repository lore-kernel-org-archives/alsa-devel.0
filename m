From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001067]: sound partially working on medion laptop
Date: Sat, 23 Apr 2005 02:22:46 +0200
Message-ID: <870716ea945d4b7d3401db23e1cb8b30@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D953515E
	for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2005 02:22:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1067> 
======================================================================
Reported By:                fab31
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1067
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu 5.04
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-19-2005 23:47 CEST
Last Modified:              04-23-2005 02:22 CEST
======================================================================
Summary:                    sound partially working on medion laptop
Description: 
I have a medion laptop with an hda intel card, I have 3 outputs for 5.1    
                                                
(works well), one output for spdif (not tested), two inputs (not          
                                                 
tested) AND one output for headphones (no sound) and 2 internal speakers  
                                                 
+ 1 bass stuff (no sound).                                                
                                                 
                                                                          
                                                 
I don't even have console beep on the two last...                         
                                                 
I can do sniffing, try reverse-engenering etc... I kept XP for now so I   
                                                 
may sniff something ? I need someone to point me the way, I can't stand   
                                                 
having no sound on those speakers...                                      
                                                 
                                                                          
                                                 In fact, I never got 5.1
cards so I can't say but when I play some
sound, only the "Front"  and "Surround" are outputing a sound, Center
don't do nothing too... The sound seems to have been "bass cut", I can
ear only Trebbles...

Here is a screenshot of my mixer:
http://fab.gnux.info/mixer/mixer.png

======================================================================

----------------------------------------------------------------------
 fab31 - 04-23-05 02:22 
----------------------------------------------------------------------
Under WinXP there is a control tool which permits to switch between:
                                                     
- headphones                                
- 2 Channels                             
- 4 channels                             
- 6 channels (with a checkbox for "subwoofer on the last 2 channels")
                                         
I can hear the sound "jumping" while I change the settings, I think
something is send to the card to switch his settings, is it possible to
sniff some data ?                        
                                         
The card has 2 jack on the side, with headphone OUT and mic IN.
At rear there is 3 OUT jack : Front, Surround and Center plus one
optical (Input only ?) and one more "Audio In".
                                         
Under Linux (with the latest alsa driver) the headphone out and the
Center out outputs nothing at all, nor the Speakers.
                                         
Under WinXP when I plug the headphones on the headphones output, the
speakers shut off automatically (with little delay).
                                                  
The chip is Realtek ALC880.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-05 23:47 fab31          New Issue                                    
04-19-05 23:47 fab31          Distribution              => ubuntu 5.04     
04-19-05 23:47 fab31          Kernel Version            => 2.6.11          
04-23-05 02:22 fab31          Note Added: 0004563                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
