From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000502]: Mp3+ crackles when on alsa, not when on oss emulation
Date: Wed, 15 Sep 2004 13:09:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040915110921.5FC6647007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B718B2EE
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 13:09:21 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000502
======================================================================
Reported By:                hhg
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     502
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 9.2
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-15-2004 00:44 CEST
Last Modified:              09-15-2004 13:09 CEST
======================================================================
Summary:                    Mp3+ crackles when on alsa, not when on oss emulation
Description: 
this shell-cut-and-paste wil ilustrate my problem:

At first when I plug my mp3+ in, it crackles. It is not scraping or
static, it is a distinct pop in the sound about 2-3 times/sec not
rythmical. The card shows up in alsamixer -c1, and everything about
controling it works. Then, without plugging my card in or out, I do this:

[root@localhost hhg]# rmmod snd_usb_audio
[root@localhost hhg]# modprobe audio
[root@localhost hhg]# alsamixer -c1
 
alsamixer: function snd_ctl_open failed for hw:1: No such file or
directory

I also have a boult-in intel-8x0-card working fine with alsa. But now the
mp3+card works great. Using oss-emulated mixer the card can also be
controled. I have to use oss-output, though, as the card no longer is
registrered by alsa.

even if I do

[root@localhost hhg]# modprobe snd-usb-audio

alsamixer -c1 fails and the card stil works as an oss-card.
======================================================================

----------------------------------------------------------------------
 hhg - 09-15-2004 13:09 CEST 
----------------------------------------------------------------------
After reading a previous bug, I discovered that when I plug my mp3+
directly into my pc and not via my usb2.0-hub (sweex hub) the crackling
goes away when on alsa-driver.

This is very strange. How can alsa not send good data through the hub when
the oss-emulator (audio) can do it just fine?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-15-04 00:44 hhg            New Bug                                      
09-15-04 00:44 hhg            Distribution              => Mandrake 9.2    
09-15-04 00:44 hhg            Kernel Version            => 2.6.8           
09-15-04 13:09 hhg            Bugnote Added: 0001760                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
