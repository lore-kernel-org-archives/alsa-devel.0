From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001733]: Intel HDA Modem ?
Date: Wed, 15 Mar 2006 00:42:33 +0100
Message-ID: <2874656d0ee5b6773b3bcb0708fd1bb4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9FBC71C4
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 00:42:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1733> 
======================================================================
Reported By:                chrmue
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1733
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               SuSE Linux 10.0
Kernel Version:             2.6.13-15
======================================================================
Date Submitted:             01-11-2006 07:23 CET
Last Modified:              03-15-2006 00:42 CET
======================================================================
Summary:                    Intel HDA Modem ?
Description: 
I want to use my HDA Softmodem in Linux, is there any development on a HDA
Modem Module ?

cat /proc/asound/card0/codec#1 gives me:
Codec: Generic 11c1 ID 3026
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x70500

In Windows it is called "Agere Systems HDA Modem" (Conexant ?)

If there is development on this i would like to participate to get it
going, because i dont't want to have a windows-installation on my Notebook
(Acer TravelMate 8104) just for getting my mails at my parents house,
where there is only analog telephone.
======================================================================

----------------------------------------------------------------------
 kratz00 - 03-12-06 11:22 
----------------------------------------------------------------------
i believe you two

just curious how chrmue got it working (with the wrong parameters) and i
really would like to know what wvdial version he uses

i'm not on SuSE :) it's a LFS system and i installed wvdial following the
BLFS instructions

wvdial is version 1.54.0 and wvstreams 4.0.1

----------------------------------------------------------------------
 chrmue - 03-15-06 00:42 
----------------------------------------------------------------------
I use slmodemd v. 2.9.10, wvdial v. 1.54.0 and wvstreams v. 4.0.1; all from
SuSE 10.0.
You're right hw:0 is the wrong parameter, hw:0,6 works on my system, but i
have to manually go off- AND on-hook in alsamixer. I use "slmodemd -a
modem:0" and it works with automatically going off-hook, but for going
on-hook on disconnect i got " disconnect "amixer sset Off-hook off >
/dev/null" " in my /etc/ppp/options, but this only works with connections
using pppd. If you use a terminal-programm (eg. minicom) you have to reset
the Off-hook switch in alsamixer manually after disconnecting (else your
telephone-line stays busy and you get NO DIALTONE the next time).

Btw.: If your problem is wvdial-related try to establish a connection to
your ISP or a mailbox-system with minicom. If you get a connection
slmodemd and alsa are okay and you should take a look to your wvdial.conf

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 07:23 chrmue         New Issue                                    
01-11-06 07:23 chrmue         Distribution              => SuSE Linux 10.0 
01-11-06 07:23 chrmue         Kernel Version            => 2.6.13-15       
01-11-06 07:42 rlrevell       Note Added: 0007559                          
01-11-06 23:32 sashak         File Added: hda-modem-si3054-11c13026.patch       
            
01-11-06 23:35 sashak         Note Added: 0007571                          
01-12-06 00:00 sashak         Note Added: 0007574                          
01-12-06 00:02 sashak         Issue Monitored: sashak                      
01-12-06 05:35 chrmue         Note Added: 0007581                          
01-13-06 00:16 sashak         Note Added: 0007598                          
01-16-06 20:19 chrmue         Note Added: 0007692                          
01-16-06 20:22 chrmue         Issue Monitored: chrmue                      
03-03-06 15:43 lrupn          Note Added: 0008341                          
03-03-06 15:44 lrupn          Issue Monitored: lrupn                       
03-10-06 23:44 kratz00        Note Added: 0008413                          
03-11-06 15:19 kratz00        Note Added: 0008416                          
03-11-06 19:03 rlrevell       Note Added: 0008421                          
03-11-06 19:23 kratz00        Note Added: 0008423                          
03-11-06 19:33 rlrevell       Note Added: 0008424                          
03-11-06 23:08 sashak         Note Added: 0008427                          
03-12-06 11:22 kratz00        Note Added: 0008431                          
03-15-06 00:42 chrmue         Note Added: 0008525                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
