From: Forest Bond <forest@alittletooquiet.net>
Subject: via82xx: unreliable audio, strange mixer behavior
Date: Thu, 20 Nov 2008 12:04:09 -0500
Message-ID: <20081120170409.GG17813@storm.local.network>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.webfaction.com (mail3.webfaction.com [70.85.44.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 50E562414E
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 18:04:16 +0100 (CET)
Received: from storm (pool-64-223-124-145.burl.east.verizon.net
	[64.223.124.145]) (authenticated bits=0)
	by mail3.webfaction.com (8.13.1/8.13.3) with ESMTP id mAKH4E88031001
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 11:04:15 -0600
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using snd-via82xx on an Ubuntu 8.04 system.  alsa-info.sh output is here:

http://www.alsa-project.org/db/?f=1c3d5570e7b57d4d2f79b964a323dd7b4efd7e78

Here are the symptoms:

Audio goes away after a semi-random interval.  Sometimes it returns after
`modprobe -r snd-via82xx' followed by `modprobe snd-via82xx', but sometimes it
seems to take a full reboot.

This looks similar to:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D3194

Some folks think that this kind of issue is triggered by audio volume being
above a certain level.  I'm not entirely sure if this is true, but I think it
is.  One time, I apparently triggered the issue by unplugging and replugging the
audio cable from the mainboard during playback.

Audio can be heard even when the PCM volume level is 0 (as told by alsamixer).
The volume does get louder when I turn up that mixer control, but it never goes
away entirely when I turn the volume to zero.  Mute works as expected.

This issue is impacting a significant project for me and my company.  I'm
willing to spend as much time as it takes to debug, and I'm fairly technical.  I
can also offer a bounty of some sort, if that interests anyone.

Can anyone offer any input?

Thanks,
Forest
--
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org
