From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: ./snddevices
Date: Wed, 18 Jun 2003 14:20:37 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EEFF6A5.6060102@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www2.webhosting.cx (www2.webhosting.cx [207.44.198.86])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA03054
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2003 07:39:09 +0200
Received: from boosthardware.com ([61.73.138.86])
	(authenticated (0 bits))
	by www2.webhosting.cx (8.11.6/8.11.6) with ESMTP id h5I5dGe22205
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2003 07:39:21 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have a report that the manually running snddevices script is needed to 
get 0.9.4 working.

Last time I asked I got the impression that it was being automatically 
handled and even saw the output messages after running make install.

However I and others using the quattro have a bizarre problem where we 
cannot access the alsa layer as a normal user.

This is the message I get before/after running ./snddevices manually:
-----
snd_pcm_open: Permission denied (quattro1)
Failed to initialize plugin!
Failed to register plugin: /usr/local/lib/alsaplayer/output/libalsa_out.so
Failed to load output plugin "alsa". Trying defaults.
snd_pcm_open: Permission denied (quattro1)
Failed to initialize plugin!
-----

Can someone let me know what is wrong or has support for the old dev 
system been dropped now?


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
