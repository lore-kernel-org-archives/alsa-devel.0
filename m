From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB devices should not oops after disconnect now
Date: Wed, 27 Nov 2002 13:34:10 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE44B42.8070601@boosthardware.com>
References: <Pine.LNX.4.33.0211251909590.1209-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA04156
	for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2002 21:50:43 +0100
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id FAA09355
	for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2002 05:46:16 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Hello all,
> 
> 	the subject says everything. CVS contains first code to avoid 
> oops / systems hangs when a "running" hotplug device is removed from the 
> system. Please, test and report problems.
> 

I have updated and now when I disconnect the device it will not register 
on reconnect. No "connection found" messages are written to dmesg an it 
doesn't appear in /proc/asound/cards. However it doesn't hang or cause 
an oops either :) This is with the maudio quattro.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
