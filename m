From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000721]: System stops completely when playing audio
Date: Tue, 31 May 2005 18:03:45 +0200
Message-ID: <d09915b8ea202eecdba8690f47c30458@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 199131D3
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:45 +0200 (MEST)
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
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-12-2004 13:58 CET
Last Modified:              05-31-2005 18:03 CEST
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
03-07-05 23:47 karsten        Status                   assigned => resolved
03-07-05 23:47 karsten        Resolution               open => fixed       
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
