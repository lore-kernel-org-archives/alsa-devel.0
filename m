From: andoru <andoru.blah@gmail.com>
Subject: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Thu, 10 Apr 2014 19:05:12 +0000 (UTC)
Message-ID: <loom.20140410T210136-313@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 91D54268140
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 21:05:30 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WYKHt-0006Fv-8f
 for alsa-devel@alsa-project.org; Thu, 10 Apr 2014 21:05:25 +0200
Received: from cl-86-125-143-211.cablelink.mures.rdsnet.ro ([86.125.143.211])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 21:05:25 +0200
Received: from andoru.blah by cl-86-125-143-211.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 21:05:25 +0200
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

Continued from here: http://article.gmane.org/gmane.linux.alsa.devel/121575

> http://www.alsa-project.org/main/index.php/XRUN_Debug
> 
> # Enable basic debugging and dump stack, check hardware pointer on the
> period update
> # Usefull to just see, if PCM stream is stopped for a reason (usually wrong
> audio process timing from scheduler)
> # And to check the values from driver
> 
> echo 11 > /proc/asound/card0/pcm0p/xrun_debug

Okay, I not compiled my own kernel with CONFIG_SND_PCM_XRUN_DEBUG,
CONFIG_SND_VERBOSE_PROCFS, CONFIG_SND_DEBUG all enabled in the kernel
configuration, I have an xrun_debug file, but it doesn't seem to list
anything, then I also tried with cat instead of echo, and just a 0 showed up:

___________________________________________________________________
$ echo 11 > /proc/asound/card0/pcm0p/xrun_debug
bash: /proc/asound/card0/pcm0p/xrun_debug: Permission denied

# echo 11 > /proc/asound/card0/pcm0p/xrun_debug
bash: /proc/asound/card0/pcm0p/xrun_debug: Permission denied

$ cat /proc/asound/card0/pcm0p/xrun_debug
0
___________________________________________________________________
