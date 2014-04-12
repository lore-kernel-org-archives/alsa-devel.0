From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Sat, 12 Apr 2014 12:38:23 +0800
Message-ID: <CAN8cciazgm+X37KuTBWspC0q=DPPjr47kgkXFgSKJiXfGAr+5Q@mail.gmail.com>
References: <loom.20140410T210136-313@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f169.google.com (mail-qc0-f169.google.com
 [209.85.216.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 27AAC26072A
 for <alsa-devel@alsa-project.org>; Sat, 12 Apr 2014 06:38:25 +0200 (CEST)
Received: by mail-qc0-f169.google.com with SMTP id i17so6926183qcy.28
 for <alsa-devel@alsa-project.org>; Fri, 11 Apr 2014 21:38:24 -0700 (PDT)
In-Reply-To: <loom.20140410T210136-313@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andoru <andoru.blah@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Continued from here:
http://article.gmane.org/gmane.linux.alsa.devel/121575
>
> > http://www.alsa-project.org/main/index.php/XRUN_Debug
> >
> > # Enable basic debugging and dump stack, check hardware pointer on the
> > period update
> > # Usefull to just see, if PCM stream is stopped for a reason (usually
wrong
> > audio process timing from scheduler)
> > # And to check the values from driver
> >
> > echo 11 > /proc/asound/card0/pcm0p/xrun_debug
>
> Okay, I not compiled my own kernel with CONFIG_SND_PCM_XRUN_DEBUG,
> CONFIG_SND_VERBOSE_PROCFS, CONFIG_SND_DEBUG all enabled in the kernel
> configuration, I have an xrun_debug file, but it doesn't seem to list
> anything, then I also tried with cat instead of echo, and just a 0 showed
up:
>
> ___________________________________________________________________
> $ echo 11 > /proc/asound/card0/pcm0p/xrun_debug
> bash: /proc/asound/card0/pcm0p/xrun_debug: Permission denied
>
> # echo 11 > /proc/asound/card0/pcm0p/xrun_debug
> bash: /proc/asound/card0/pcm0p/xrun_debug: Permission denied
>
> $ cat /proc/asound/card0/pcm0p/xrun_debug
> 0

You need root privilege to debug

sudo echo 11 > /proc/asound/card0/pcm0p/xrun_debug

Check the system log , you should find the hwptr change at 10ms interval if
vlc use period time of 10ms

Try different period time/size to verify that the hardware really support
any  arbitrary period time/size requested by the application ?
