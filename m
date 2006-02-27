From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001618]: No Sound on Acer with Intel ICH6 HDA and Realtek ALC260
Date: Mon, 27 Feb 2006 21:20:18 +0100
Message-ID: <d485791bcd3532c87c28b268852b9439@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 201C6178
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 21:20:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618> 
======================================================================
Reported By:                robertw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1618
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12-10-686
======================================================================
Date Submitted:             12-04-2005 21:24 CET
Last Modified:              02-27-2006 21:20 CET
======================================================================
Summary:                    No Sound on Acer with Intel ICH6 HDA and Realtek
ALC260
Description: 
I can load the snd-hda-intel module and play a file via aplay or xmms or
play a cd without any error, but I cannot hear anything neither via the
build-in speakers nor via headphones. All volume controllers are at 70%
and unmuted, except for PCM, because there is no mute/unmute-button.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001517 No sound on hda-intel on Acer TravelMat...
======================================================================

----------------------------------------------------------------------
 er-ku - 02-27-06 00:41 
----------------------------------------------------------------------
jwoithe:

Sure, I don't mind delaying it a day or two. I would very much appreciate
someone to review what I've came up with (at least from a programmer's
PoV). Especially the Fujitsu and test models. If you feel my changes to
your models aren't correct, you're absolutely free to cut them out. :)

A few more things:
* AndyP's subvendor/subdevice ID's seem to taken from
/proc/asound/card0/codec#0, not from lspci. I don't know why those ID's
differ, but at least for me autodetection didn't work with 0x1025 0x160d
(i have those numbers in my codec#0 file too). The correct ID's (at least
for my laptop; taken from lspci) are already in my patch, and I suppose
those ID's will suit to a lot of other Acer users too.
* replacing lobstaj's 0x01's with your 0x0f's doesn't seem to help at all,
so I think it should stay as 0x01;
* It would be interesting to play GPIO pins a bit more. How do I do that?



----------------------------------------------------------------------
 grattemedi - 02-27-06 21:20 
----------------------------------------------------------------------
hy, i have a acer 1641 with the same chipset ALC260. I read your notes, and
i'd like to try your drivers. I 've downloaded the new ALSA driver source
package  alsa-driver-1.0.11rc3. Could you explain me how to compile your
changes i found in the 2006-02-26.tar.bz2 on the cvs ? thanks

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 21:24 robertw        New Issue                                    
12-04-05 21:24 robertw        Distribution              => Ubuntu 5.10     
12-04-05 21:24 robertw        Kernel Version            => 2.6.12-10-686   
12-05-05 07:12 jwoithe        Note Added: 0006908                          
12-05-05 19:35 timmy          Note Added: 0006914                          
12-06-05 15:52 tiwai          Note Added: 0006925                          
12-06-05 18:10 robertw        Note Added: 0006930                          
12-06-05 20:07 tiwai          Note Added: 0006934                          
12-06-05 20:08 tiwai          File Added: alc-cvs-fix.diff                    
12-06-05 20:09 tiwai          Note Added: 0006935                          
12-06-05 22:51 robertw        Note Added: 0006938                          
12-07-05 14:59 tiwai          Note Added: 0006941                          
12-07-05 15:00 tiwai          File Added: alc-cvs-fix2.diff                    
12-07-05 23:10 robertw        Note Added: 0006952                          
12-08-05 17:19 tiwai          Note Added: 0006957                          
12-08-05 22:01 robertw        File Added: codec#0                          
12-08-05 22:02 robertw        File Added: codec#1                          
12-08-05 22:03 robertw        File Added: asound.state                     
12-08-05 22:05 robertw        Note Added: 0006963                          
12-09-05 15:09 tiwai          Note Added: 0006966                          
12-09-05 16:35 robertw        Note Added: 0006967                          
12-09-05 17:03 tiwai          Note Added: 0006969                          
12-09-05 17:17 robertw        Note Added: 0006970                          
12-14-05 13:22 mytux          Issue Monitored: mytux                       
12-19-05 02:11 rlrevell       Note Added: 0007077                          
01-02-06 21:55 robertw        Note Added: 0007391                          
01-04-06 17:29 tiwai          Note Added: 0007441                          
01-04-06 22:00 robertw        Note Added: 0007453                          
01-04-06 22:16 robertw        Note Edited: 0007453                         
01-11-06 23:38 lobstaj        Note Added: 0007572                          
01-11-06 23:48 rlrevell       Note Added: 0007573                          
01-12-06 00:20 lobstaj        Note Added: 0007575                          
01-12-06 00:26 rlrevell       Note Added: 0007576                          
01-12-06 01:16 mytux          Note Added: 0007577                          
01-12-06 01:20 mytux          Note Edited: 0007577                         
01-12-06 14:13 robertw        Note Added: 0007586                          
01-12-06 14:43 lobstaj        Note Added: 0007587                          
01-12-06 16:45 eudoxos        Issue Monitored: eudoxos                     
01-12-06 21:04 rlrevell       Note Added: 0007591                          
01-13-06 01:11 rlrevell       Relationship added       duplicate of 0001517
01-13-06 08:03 eudoxos        Note Added: 0007631                          
01-13-06 11:30 er-ku          Issue Monitored: er-ku                       
01-16-06 00:32 jwoithe        Note Added: 0007682                          
01-17-06 23:32 ilovetronik    Issue Monitored: ilovetronik                    
01-19-06 23:36 ajmitch        Issue Monitored: ajmitch                     
02-08-06 14:46 svilen         Note Added: 0007965                          
02-09-06 00:29 jwoithe        Note Added: 0007969                          
02-09-06 09:04 hweigel        Issue Monitored: hweigel                     
02-10-06 11:02 svilen         Note Added: 0007999                          
02-12-06 21:42 AndyP          Note Added: 0008031                          
02-12-06 22:11 wattazoum      Note Added: 0008032                          
02-12-06 22:14 rlrevell       Note Added: 0008033                          
02-12-06 23:05 er-ku          Note Added: 0008034                          
02-12-06 23:07 er-ku          Note Edited: 0008034                         
02-13-06 00:45 jwoithe        Note Added: 0008035                          
02-13-06 06:42 er-ku          Note Added: 0008037                          
02-13-06 06:43 er-ku          Note Edited: 0008037                         
02-14-06 00:07 jwoithe        Note Added: 0008066                          
02-18-06 23:48 AndyP          Note Added: 0008125                          
02-19-06 10:41 er-ku          Note Added: 0008131                          
02-19-06 16:49 AndyP          Note Added: 0008134                          
02-22-06 18:29 lobstaj        Note Added: 0008160                          
02-23-06 01:12 jwoithe        Note Added: 0008165                          
02-24-06 12:21 lobstaj        Note Added: 0008173                          
02-24-06 12:25 lobstaj        Note Edited: 0008173                         
02-24-06 14:58 mytux          Note Added: 0008176                          
02-24-06 15:41 wattazoum      Note Added: 0008179                          
02-24-06 15:42 wattazoum      Note Edited: 0008179                         
02-24-06 22:32 er-ku          Note Added: 0008181                          
02-24-06 23:23 AndyP          Note Added: 0008182                          
02-25-06 12:29 wattazoum      File Added: patch_realtek.diff                    
02-25-06 12:31 wattazoum      Note Added: 0008187                          
02-26-06 05:50 at2000         Note Added: 0008196                          
02-26-06 06:02 rlrevell       Note Added: 0008197                          
02-26-06 14:58 er-ku          Note Added: 0008201                          
02-26-06 15:00 er-ku          Note Added: 0008202                          
02-26-06 23:39 er-ku          Note Edited: 0008201                         
02-26-06 23:47 er-ku          Note Edited: 0008202                         
02-26-06 23:47 er-ku          Note Deleted: 0008202                        
02-26-06 23:48 er-ku          Note Added: 0008206                          
02-26-06 23:53 jwoithe        Note Added: 0008207                          
02-27-06 00:16 jwoithe        Note Added: 0008208                          
02-27-06 00:27 er-ku          Note Added: 0008209                          
02-27-06 00:41 er-ku          Note Edited: 0008209                         
02-27-06 03:16 frat           Issue Monitored: frat                        
02-27-06 18:33 mixcha         Issue Monitored: mixcha                      
02-27-06 21:20 grattemedi     Note Added: 0008230                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
