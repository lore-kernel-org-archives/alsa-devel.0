From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000674]: sound modules loaded, unmuted channels, progressbar moving STILL no output
Date: Wed, 24 Nov 2004 18:02:30 +0100
Message-ID: <639f9941bc22a472a44b4736a3b77906@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B4D572E3
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 18:02:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=674> 
======================================================================
Reported By:                IceRAM
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   674
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               ArchLinux
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-24-2004 13:12 CET
Last Modified:              11-24-2004 18:02 CET
======================================================================
Summary:                    sound modules loaded, unmuted channels, progressbar
moving STILL no output
Description: 
I can't get any sound out of the integrated sound card, even though I've
tried everything possible (I think - oh, I haven't tried Windows, yet)
======================================================================

----------------------------------------------------------------------
 IceRAM - 11-24-04 16:31 
----------------------------------------------------------------------
You might be right... it does seem to have some kind of a little bit louder
hummm while playing.

I have a background humm (loud speakers) even if it's not playing,
probably because of interference. It also hummms when moving the mouse or
using the keyboard.

----------------------------------------------------------------------
 tiwai - 11-24-04 18:02 
----------------------------------------------------------------------
Please attach the contents of /proc/asound/card0/codec97#0/* files, too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 13:12 IceRAM         New Issue                                    
11-24-04 13:12 IceRAM         File Added: asound.state                     
11-24-04 13:12 IceRAM         Distribution              => ArchLinux       
11-24-04 13:12 IceRAM         Kernel Version            => 2.6.9           
11-24-04 13:13 IceRAM         File Added: .asoundrc                        
11-24-04 13:17 IceRAM         File Added: modprobe.conf                    
11-24-04 13:19 IceRAM         Note Added: 0002560                          
11-24-04 13:19 IceRAM         File Added: lsmod.txt                        
11-24-04 13:20 IceRAM         Issue Monitored: IceRAM                      
11-24-04 15:36 IceRAM         File Added: lspci_v.txt                      
11-24-04 15:39 IceRAM         Note Added: 0002568                          
11-24-04 16:07 pzad           Note Added: 0002569                          
11-24-04 16:31 IceRAM         Note Added: 0002570                          
11-24-04 18:02 tiwai          Note Added: 0002576                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
