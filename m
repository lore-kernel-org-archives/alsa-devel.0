From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000721]: System stops completely when playing audio
Date: Fri, 31 Dec 2004 16:25:38 +0100
Message-ID: <1c7a40b00b057d61c4afa0b70e22fc53@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 242E22AB
	for <alsa-devel@alsa-project.org>; Fri, 31 Dec 2004 16:25:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=721> 
======================================================================
Reported By:                spirou
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   721
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-12-2004 13:58 CET
Last Modified:              12-31-2004 16:25 CET
======================================================================
Summary:                    System stops completely when playing audio
Description: 
I have a Tascam US-428. Wehen I connect to the USB, the driver is loaded,
the USB-LED of the 428 lights up. When I try to play audio (e.g. with
aplay or XMMS), the computer immedeately stops working. All I can do is to
push the reset-button. No log-entrys, nothing.
======================================================================

----------------------------------------------------------------------
 spirou - 12-30-04 18:59 
----------------------------------------------------------------------
Thank you. It's getting mysterious...:
us428control: cannot open hwdep hw:0
us428control: cannot open hwdep hw:1
us428control: cannot open hwdep hw:2
us428control: cannot open hwdep hw:3
us428control: cannot open hwdep hw:4
us428control: cannot open hwdep hw:5
us428control: cannot open hwdep hw:6
us428control: cannot open hwdep hw:7
us428control: no US-X2Y-compatible cards found

I swear, it's a US-428! ;)
With WinXP it works OK.

Could this be a firmware-problem?

----------------------------------------------------------------------
 karsten - 12-31-04 16:25 
----------------------------------------------------------------------
us428control was started as root?
if not, retry as root.

if no success, please supply 
$ lsmod
$ ls -al /dev/snd/
$ for XX in $(find /proc/asound/ -type f) ; do echo;echo $XX; cat $XX;
done;

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-12-04 13:58 spirou         New Issue                                    
12-12-04 13:58 spirou         Distribution              => Gentoo          
12-12-04 13:58 spirou         Kernel Version            => 2.6.9           
12-12-04 14:20 karsten        Note Added: 0002816                          
12-12-04 14:52 spirou         Note Added: 0002817                          
12-12-04 18:51 karsten        Note Added: 0002818                          
12-29-04 11:15 spirou         Note Added: 0002994                          
12-29-04 20:14 karsten        Note Added: 0003010                          
12-29-04 23:01 spirou         Note Added: 0003013                          
12-29-04 23:17 martin         Note Added: 0003014                          
12-30-04 00:12 spirou         Note Added: 0003016                          
12-30-04 14:53 karsten        Note Added: 0003020                          
12-30-04 18:59 spirou         Note Added: 0003023                          
12-31-04 16:25 karsten        Note Added: 0003026                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
