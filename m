From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000721]: System stops completely when playing audio
Date: Sun, 2 Jan 2005 20:21:27 +0100
Message-ID: <ee635fd99c4d761d3b384c43aab0f404@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E3B22A8
	for <alsa-devel@alsa-project.org>; Sun,  2 Jan 2005 20:21:28 +0100 (MET)
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
Last Modified:              01-02-2005 20:21 CET
======================================================================
Summary:                    System stops completely when playing audio
Description: 
I have a Tascam US-428. Wehen I connect to the USB, the driver is loaded,
the USB-LED of the 428 lights up. When I try to play audio (e.g. with
aplay or XMMS), the computer immedeately stops working. All I can do is to
push the reset-button. No log-entrys, nothing.
======================================================================

----------------------------------------------------------------------
 karsten - 12-31-04 16:31 
----------------------------------------------------------------------
maybe also usx2yloader didn't run / exist?
it has to be called before.
Complete sequence goes like this:
$ usx2yloader
$ modprobe snd-seq
$ us428control

----------------------------------------------------------------------
 spirou - 01-02-05 20:21 
----------------------------------------------------------------------
Now I put snd-seq to /etc/modules.autoload.d so it gets loaded before
everything, and now it works :)! So the bootsequence here is

snd-seq
usx2yloader (via hotplug/tascam.fw)
us428control (via hotplug/tascam.fpga)
snd-usb-usx2y (? Guess hotplug does this for me..)

I'm a little confused, because I already tried it without having snd-seq
autoloaded, and it didn't work, although everything else has been
unchanged.
I did modprobe snd-seq, then plugged the us428 in which starts the
hotplug-scripts - nothing. With snd-seq autoloaded everything's fine.

Anyway, thanks a few million times for your patience! :)

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
12-31-04 16:31 karsten        Note Added: 0003027                          
01-02-05 20:21 spirou         Note Added: 0003048                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
