From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001808]: Line 6 Toneport UX1 driver
Date: Sun, 26 Mar 2006 00:33:15 +0100
Message-ID: <ff04bc1b3267365c5645bce8c3d5d6fa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F198C167
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2006 00:33:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1808> 
======================================================================
Reported By:                daste
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1808
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-02-2006 00:49 CET
Last Modified:              03-26-2006 00:33 CET
======================================================================
Summary:                    Line 6 Toneport UX1 driver
Description: 
I recently bought a Line 6 Toneport UX1 USB sound card, but I can't use it
under Linux, since it's not supported by ALSA.
So I'd like to ask you what can I do: altough I'm quite capable of
programming in C, I never developed any kind of driver either for Linux or
any other OS.
I thought that maybe it was my turn to learn, so I wrote an e-mail to Line
6 asking them if they had plans on a Linux driver for such soundcard, or
otherwise, if they would have sent me infos, so that I could have tried to
spend some time trying to develop a driver. They haven't answered yet.
I do want to use that unbelivable sound card under Linux, so I think I'm
going to code, but I don't know where to start: can you give me any
suggestions?
And since I think I have to do some reverse engineering on Microsoft
Windows drivers, can you give some other advice on such topic too?
Otherwise, I'd like to ask you whether you're already developing a
solution for such a problem or not. Thanks in advance.
======================================================================

----------------------------------------------------------------------
 daste - 03-03-06 10:46 
----------------------------------------------------------------------
Ok, there's some news!
Take a look at http://www.tanzband-scream.at/line6/
I haven't tried it yet but it seems like that this driver supports Line6
USB stuff, so maybe you can consider to port it on the ALSA architecture
(if it's not working this way yet), and maybe improve it.
Let me know!

----------------------------------------------------------------------
 suamor - 03-26-06 00:33 
----------------------------------------------------------------------
No way with this driver. It's only for the Pods and the Variax guitar. Of
course integrating these into alsa is still very interesting. The author
does not seem to own a Toneport device.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-06 00:49 daste          New Issue                                    
02-02-06 01:31 rlrevell       Note Added: 0007866                          
02-02-06 08:58 Clemens LadischNote Added: 0007870                          
02-02-06 12:47 daste          File Added: lsusb                            
02-02-06 12:47 daste          Note Added: 0007875                          
02-02-06 16:29 daste          Issue Monitored: daste                       
02-03-06 08:37 Clemens LadischNote Added: 0007892                          
02-03-06 08:37 Clemens LadischAssigned To               => Clemens Ladisch 
02-03-06 08:37 Clemens LadischReproducibility          N/A => always       
02-03-06 08:37 Clemens LadischStatus                   new => assigned     
02-03-06 10:57 daste          Note Added: 0007895                          
03-03-06 10:46 daste          Note Added: 0008339                          
03-26-06 00:33 suamor         Note Added: 0008955                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
