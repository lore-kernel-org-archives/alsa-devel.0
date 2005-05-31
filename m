From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000037]: no sound
Date: Tue, 31 May 2005 18:02:13 +0200
Message-ID: <fba894a998d13b7bf3fafcf6fc33b13f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3EE461B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:02:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=37> 
======================================================================
Reported By:                zoltan
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   37
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Mandrake 9.2
Kernel Version:             2.4.22-10mdksmp
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             02-04-2004 17:04 CET
Last Modified:              05-31-2005 18:02 CEST
======================================================================
Summary:                    no sound
Description: 
Takashi Iwai was assisting me with this problem. I think he is on your team
- if not, let me know and I can be more specific about the issues.

Thanks,
Zoltan.
======================================================================

----------------------------------------------------------------------
 zoltan - 02-26-04 17:03 
----------------------------------------------------------------------
ping.... and the man ponged.

I've moved that motherboard onto a WinXP box and the sound works
perfectly.

I've replaced the M/B in the Mdk box with the a newer version of the same
MSI motherboard - and rebooted Mdk - and the sound works!!! Well, mplayer
works, but aplay does not!!! Good luck figuring this one out - I'm not at
all hassled.

I suppose my final feeling is that there are probably a lot more
outstanding issues with ALSA drivers than Win drivers, but hey, as long as
you can afford to bang your head on a wall, spend the time and money
replacing hardware, it's a great system :-)

btw: I've been using I386/SCO/then Linux since 1990, so it my hassles
weren't  "Linux Newbie" hassles.

Feel free to close this bug report, or whatever floats your boat.

Thanks (sincerely) for your early efforts.

Kind regards,
Zoltan.

----------------------------------------------------------------------
 perex - 03-13-04 18:32 
----------------------------------------------------------------------
Unfortunate, we're not able to solve this bug and the user doesn't use
ALSA
on the affected system now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-04-04 17:04 zoltan         New Issue                                    
02-04-04 17:04 zoltan         File Added: asound.state                     
02-04-04 17:13 tiwai          Note Added: 0000148                          
02-04-04 17:35 zoltan         File Added: cat_log                          
02-04-04 17:36 zoltan         File Added: aplay_log                        
02-04-04 17:36 zoltan         File Added: aplay_log                        
02-04-04 17:38 zoltan         Note Added: 0000152                          
02-04-04 17:44 tiwai          Note Added: 0000153                          
02-04-04 17:53 zoltan         Note Added: 0000156                          
02-04-04 18:09 zoltan         File Added: aplay48_log                      
02-04-04 18:13 zoltan         Note Added: 0000158                          
02-04-04 19:39 tiwai          Note Added: 0000162                          
02-05-04 07:30 zoltan         File Added: alsamixer.png                    
02-05-04 07:30 zoltan         File Added: amixer_log                       
02-05-04 07:31 zoltan         File Added: proc_mod_log                     
02-05-04 07:44 zoltan         Note Added: 0000173                          
02-05-04 10:52 zoltan         Issue Monitored: zoltan                      
02-05-04 13:02 zoltan         File Added: lspci_log                        
02-05-04 13:03 zoltan         Note Added: 0000179                          
02-05-04 17:38 zoltan         Note Added: 0000183                          
02-05-04 21:25 zoltan         Note Added: 0000184                          
02-06-04 15:53 tiwai          Note Added: 0000190                          
02-06-04 17:26 zoltan         Note Added: 0000191                          
02-06-04 17:54 tiwai          Note Added: 0000192                          
02-06-04 19:05 zoltan         Note Added: 0000198                          
02-07-04 16:44 DaMouse        Note Added: 0000203                          
02-09-04 20:03 tiwai          Note Added: 0000212                          
02-09-04 20:15 zoltan         Note Added: 0000213                          
02-13-04 17:08 zoltan         Note Added: 0000237                          
02-24-04 16:56 zoltan         Note Added: 0000303                          
02-25-04 22:58 zoltan         Note Added: 0000329                          
02-26-04 10:48 tiwai          Note Added: 0000332                          
02-26-04 17:03 zoltan         Note Added: 0000356                          
03-13-04 18:32 perex          Status                   new => resolved     
03-13-04 18:32 perex          Resolution               open => suspended   
03-13-04 18:32 perex          Assigned To               => perex           
03-13-04 18:32 perex          Note Added: 0000596                          
05-31-05 18:02 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
