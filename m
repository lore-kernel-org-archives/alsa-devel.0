From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB devices should not oops after disconnect now
Date: Wed, 27 Nov 2002 19:42:12 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE4A184.4020706@boosthardware.com>
References: <Pine.LNX.4.33.0211271031190.532-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA03917
	for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2002 21:44:48 +0100
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA10877
	for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2002 11:54:17 +0100
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
> 
> Note that you'll have to terminate all applications using that soundcard
> before you'll try to reconnect the device again. In next code, hopefully
> the applications will be somehow terminated to make the cleanup process
> automatic.
> 


Ok. That's the probable cause as I am having problems with jack not 
releasing the device.

It seems that hotpluging out is a tricky issue because we have to decide 
whether the application/s that are using the device should also be 
terminated.

Is it possible to transparently swap snd-usb-audio with snd-dummy if it 
has been installed? That could be a secondary default if people would 
prefer their apps do not automatically segv.




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
