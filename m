From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001956]: regression BUG:0001517 No sound on Acer TravelMate.
Date: Sun, 9 Apr 2006 02:08:46 +0200
Message-ID: <58b776af413e6241c0adeb030511797f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3BD3F155
	for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2006 02:08:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1956> 
======================================================================
Reported By:                flujan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1956
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.6.13
======================================================================
Date Submitted:             03-23-2006 21:30 CET
Last Modified:              04-09-2006 02:08 CEST
======================================================================
Summary:                    regression BUG:0001517 No sound on Acer TravelMate.
Description: 
The problem where solved in the CVS from 2006-03-01 but in the rc4 version
the problem returns. 
======================================================================

----------------------------------------------------------------------
 flujan - 03-30-06 05:26 
----------------------------------------------------------------------
Tiwai,

The problem only occurs with kernel 2.6.13. I compiled and used rc4 with
the 2.4.31 series without problems.

I read a comment of Patrick about using 2.6.13 kernels-headers, and
uninstall this  headers and install 2.4.31 series again... The problem
persists.

http://mirror.switch.ch/ftp/mirror/slackware/slackware-10.2/testing/packages/linux-2.6.13/kernel-headers.WARNING

I dunno if the kernel is the main issue, since as I said early versions
work normally.

Thanks for the patient.

----------------------------------------------------------------------
 flujan - 04-09-06 02:08 
----------------------------------------------------------------------
Solved in the CVS. I tried the CVS and now it works again. I dunno what is
the problem, but for sure now it is fixed.

Thanks tiwaii.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-06 21:30 flujan         New Issue                                    
03-23-06 21:30 flujan         Distribution              => Slackware       
03-23-06 21:30 flujan         Kernel Version            => 2.6.13          
03-24-06 11:57 tiwai          Note Added: 0008914                          
03-24-06 12:52 er-ku          Note Added: 0008915                          
03-24-06 13:01 tiwai          Note Added: 0008916                          
03-25-06 04:33 flujan         Note Added: 0008941                          
03-25-06 23:27 flujan         Note Added: 0008954                          
03-26-06 01:35 tiwai          Note Added: 0008958                          
03-27-06 17:20 flujan         Note Edited: 0008954                         
03-29-06 18:43 flujan         Note Added: 0008998                          
03-29-06 19:13 tiwai          Note Added: 0009011                          
03-30-06 05:26 flujan         Note Added: 0009021                          
04-09-06 02:08 flujan         Note Added: 0009175                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
