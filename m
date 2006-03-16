From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001733]: Intel HDA Modem ?
Date: Thu, 16 Mar 2006 02:17:13 +0100
Message-ID: <39ea908d47e032d22360aebcc1b34853@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A34AA1E9
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 02:17:13 +0100 (MET)
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
Last Modified:              03-16-2006 02:17 CET
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
 kratz00 - 03-15-06 21:42 
----------------------------------------------------------------------
i used cvs from today (driver, kernel, libs)
output off "./slmodemd -a -d 5 modem:0 -g root" is

SmartLink Soft Modem: version 2.9.10 Mar 10 2006 23:39:11
<081.923714> SmartLink Soft Modem: version 2.9.10 Mar 10 2006 23:39:11
<081.923736> modem:0: startup modem...
<081.923783> modem:0: update termios...
symbolic link `/dev/ttySL0' -> `/dev/pts/2' created.
modem `modem:0' created. TTY is `/dev/pts/2'
<081.924379> open file: /var/lib/slmodem/data.modem:0...
<081.924475> cannot open '/var/lib/slmodem/data.modem:0': No such file or
directory
<081.924823> main: rt applyed: SCHED_FIFO, pri 99
Use `/dev/ttySL0' as modem device, Ctrl+C for termination.

and still no luck with wvdail

----------------------------------------------------------------------
 sashak - 03-16-06 02:17 
----------------------------------------------------------------------
slmodem-2.9.10 is old, it does not do off-hook. Use slmodem-2.9.11-20051101
from http://linmodmes.technion.ac.il/packages/smartlink .

About wvdial. I know that such problem was reported and reason was that
this fails  after unsuccessful serial port specific ioctl()s.

What is the difference between wvdial-1.54.0 and wvdial-1.54.0 - I don't
know (configure parameters?) and actually never seen such problem
personally (my wvdial-1.54.0 was ok when I've used it last time). Try to
debug with gdb, this should not be too complicated problem.

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
03-15-06 11:35 tiwai          Note Added: 0008530                          
03-15-06 21:42 kratz00        Note Added: 0008573                          
03-15-06 21:42 kratz00        Issue Monitored: kratz00                     
03-16-06 02:17 sashak         Note Added: 0008581                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
