From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem opening default device in haswell system
 using aplay
Date: Fri, 24 May 2013 02:18:27 +0000
Message-ID: <CAN8cciZ6UMdCJ=5aetG50xpcoDwpqQySmuxJGdYcFY+uhZPQ=A@mail.gmail.com>
References: <519CE8EA.3010303@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D26926509A
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2013 04:18:28 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id u16so10948681iet.28
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 19:18:27 -0700 (PDT)
In-Reply-To: <519CE8EA.3010303@citrix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefano Panella <stefano.panella@citrix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> I am working on some haswell systems running Ubuntu 12.04 and I have a
problem if I run aplay -D sysdefault.
>
> when I do:
>
> cat /proc/asound/pcm
>
> I get:
>
> 00-03: HDMI 0 : HDMI 0 : playback 1
> 00-07: HDMI 1 : HDMI 1 : playback 1
> 00-08: HDMI 2 : HDMI 2 : playback 1
> 01-00: ALC662 rev3 Analog : ALC662 rev3 Analog : playback 1 : capture 1
> 01-02: ALC662 rev3 Analog : ALC662 rev3 Analog : capture 1
>
> If I do:
>
> aplay -L | grep sysdefault
>
> I get:
>
> sysdefault:CARD=PCH
>
> where PCH is card number 1 (id = 1)
>
> on most of my systems (non haswell laptops) the default card is number 0
>
> If I run
>
> aplay -D sysdefault
>
> I get:
>
> ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_open) unable to open slave
> aplay: main:682: audio open error: No such file or directory
>
> if I strace it I get:
>
> open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK|O_CLOEXEC) = -1 ENOENT (No
> such file or directory)

defaults.pcm.dmix.device defaults.pcm.device

You have to change defaults.pcm.dmix.device to the device of  your hdmi if
your are not using the analog device 0
