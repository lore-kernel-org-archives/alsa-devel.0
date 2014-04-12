From: Andoru <andoru.blah@gmail.com>
Subject: Re:
	=?utf-8?q?Invalid_PCM_pointer_with_CMI8738_and_pcm?=
	=?utf-8?q?=2Ec_buffer=09underuns?=
Date: Sat, 12 Apr 2014 17:56:12 +0000 (UTC)
Message-ID: <loom.20140412T194107-985@post.gmane.org>
References: <loom.20140410T210136-313@post.gmane.org>
 <CAN8cciazgm+X37KuTBWspC0q=DPPjr47kgkXFgSKJiXfGAr+5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C7322610B9
 for <alsa-devel@alsa-project.org>; Sat, 12 Apr 2014 19:56:29 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WZ2AG-000501-F9
 for alsa-devel@alsa-project.org; Sat, 12 Apr 2014 19:56:28 +0200
Received: from cl-86-125-143-172.cablelink.mures.rdsnet.ro ([86.125.143.172])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 12 Apr 2014 19:56:28 +0200
Received: from andoru.blah by cl-86-125-143-172.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 12 Apr 2014 19:56:28 +0200
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

> 
> You need root privilege to debug
> 
> sudo echo 11 > /proc/asound/card0/pcm0p/xrun_debug

___________________________________________________________
$ sudo echo 11 > /proc/asound/card0/pcm0p/xrun_debug
___________________________________________________________

implies:
___________________________________________________________
# echo 11 > /proc/asound/card0/pcm0p/xrun_debug
___________________________________________________________

So I did have root priviledges when I executed that command, and it still
gives me a Permission denied error.

I tried the command under root and it accepted the command but didn't print
anything after issuing the command. So I guess it worked?

> Check the system log , you should find the hwptr change at 10ms interval if
> vlc use period time of 10ms

Again, what system log? Be a little bit more specific please.

> Try different period time/size to verify that the hardware really support
> any  arbitrary period time/size requested by the application ?

VLC doesn't have any options or terminal parameters to be able to change the
period as you mention.
