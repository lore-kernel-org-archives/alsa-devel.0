From: Eliot Blennerhassett <linux@audioscience.com>
Subject: ALSA with Ubuntu 8.04
Date: Thu, 26 Jun 2008 11:47:13 +1200
Message-ID: <4862D901.4070700@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 05159244FC
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 01:47:21 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K3100B0GM2SPP20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 26 Jun 2008 11:47:16 +1200 (NZST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This just an FYI

In Ubuntu 8.04, ubuntu has packaged alsa-drivers including some out of 
tree drivers in a separate package: linux-ubuntu-modules-$kernelver

This gets installed in /lib/modules/$kernelver/ubuntu/sound

The only things installed in /lib/modules/$kernelver/sound are 
soundcore.ko and ac97_bus.ko

However, when you do a default "make install" from alsa-driver source, 
the modules get installed in /lib/modules/$kernelver/kernel/sound

So, now there are 2 copies of the drivers in different places.

I have taken to removing (moving away to say /root) 
/lib/modules/$kernelver/ubuntu/sound to avoid any confusion and some odd 
module versioning problems that I was having.

regards

Eliot.
