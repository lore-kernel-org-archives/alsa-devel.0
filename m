From: Rudolf Schmidt <mail@rudolfschmidt.com>
Subject: Bug with alsamixer: ALSA lib
 simple_none.c:1550:(simple_add1) helem (MIXER, 'Master Playback Switch', 0,
 1, 0) appears twice or more
Date: Sat, 20 May 2017 00:39:05 +0200
Message-ID: <1cf86f4c-b34e-f43c-4730-f4eb1ed5fb43@rudolfschmidt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rudolfschmidt.com (v2201507190326679.yourvserver.net
 [5.45.110.221]) by alsa0.perex.cz (Postfix) with ESMTP id 0201C267212
 for <alsa-devel@alsa-project.org>; Sat, 20 May 2017 00:39:06 +0200 (CEST)
Received: from rs.com (ip5b415856.dynamic.kabel-deutschland.de [91.65.88.86])
 by mail.rudolfschmidt.com (Postfix) with ESMTPSA id 0A66B11F927
 for <alsa-devel@alsa-project.org>; Sat, 20 May 2017 00:39:05 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi guys,


I want to report a bug or some kind of problem with alsa


  $ alsamixer
ALSA lib simple_none.c:1550:(simple_add1) helem (MIXER,'Master Playback 
Switch',0,1,0) appears twice or more
cannot load mixer controls: Invalid argument


I tried to figure out what is going on, tried a lot of things, removing 
packages, installing packages, removing pulseaudio etc.


Nothing helped. I found a gentoo user who reported to had the same 
issue, upgrading to kernel 4.12 helped, in particular that patch: 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=topic/hda-dual-codecs&id=7beb3a6e9335d13872f24566b451f8371edd238f


So I also upgraded to kernel 4.12 but in my case I have still the same 
problem.


Here is my config: 
http://www.alsa-project.org/db/?f=9d35ec5d71ac60e210daf91b6c311f72fc8a98a0


Hope you can help me.

-- 
Best Regards,
Rudolf Schmidt
