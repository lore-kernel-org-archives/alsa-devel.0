From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: snd-usb-midi vs ohci
Date: Sun, 10 Nov 2002 06:44:58 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCD81DA.7030004@boosthardware.com>
References: <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu> <3DC97C55.6000507@boosthardware.com> <3DCAE7C8.5030808@boosthardware.com> <3DCB8155.5000202@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA03445
	for <alsa-devel@alsa-project.org>; Sat, 9 Nov 2002 22:56:25 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm have a machine which needs the ohci usb driver. I have 2.4.19-pre10 
kernel for it.

When I try to load the usb-audio module I get a constant stream of

snd-usb-midi: usb_submit_urb: -22

Which doesn't stop until I remove the module.

This happens if I compile alsa-driver with or without sequencer support.


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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
