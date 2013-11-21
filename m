From: =?GB2312?B?stzE3Luq?= <cosmo.ustc@gmail.com>
Subject: Re: question about aplay fails on arm 64
Date: Thu, 21 Nov 2013 21:55:29 +0800
Message-ID: <CA+ai60hSD9WT6=CLntPzPh9cUKc1Whu4fMe2a6mm4n3e0ZaN4Q@mail.gmail.com>
References: <CA+ai60gtVtXhZ2m+BuJXV8W9tkd+=9_t8kEsM1-i7E+S_64oZw@mail.gmail.com>
 <528CAF84.20307@ladisch.de>
 <CA+ai60jWTvSpL1RCtarzX-JzSaX=f9rjgJv9T4Jq2VPMqGOjHw@mail.gmail.com>
 <CA+ai60igvunPAC4oPAxwdR0wp0NEBrD8TnT4X=Ti-gXXx03Tbg@mail.gmail.com>
 <528DC531.7010304@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E8D62602F3
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 14:55:30 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id ez12so1074006wid.12
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 05:55:29 -0800 (PST)
In-Reply-To: <528DC531.7010304@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, Clemens:

       Sorry for my mistake. After avoiding using mmap to transer data from
userface to kernel, alsa will use snd_pcm_ioctl_compat to do this work. I
check the returned value, and it seems good. but error still happned.


[  198.838437] 837 (aplay) snd_pcm_ioctl_sync_ptr_compat++

[  198.845630] 837 (aplay) state:0x2

[  198.850803] 837 (aplay) hw_ptr:0x0

[  198.855658] 837 (aplay) tstamp:0x0

[  198.860934] 837 (aplay) suspend_stat:0x0

[  198.866878] 837 (aplay) tstamp:0x0

[  198.871682] 837 (aplay) appl_ptr:0x0

[  198.877199] 837 (aplay) avail_min:0x300

[  198.882574] 837 (aplay) snd_pcm_ioctl_sync_ptr_compat--

[  198.890779] 837 (aplay) ======snd_pcm_ioctl_compat++++++++

[  198.898759] 837 (aplay) ======snd_pcm_ioctl_compat11

[  198.905507] 837 (aplay) ========snd_pcm_ioctl_xferi_compat++++

[  198.960915] 837 (aplay) ========snd_pcm_ioctl_xferi_compat-----,
result=0x300, buf=0x33b640, frames=0x300

[  198.982513] 837 (aplay) Bad mode in Error handler detected, code
0xbf000000

[  198.992198] 837 (aplay) CPU: 0 PID: 837 Comm: aplay Tainted: G      D
3.10.0+ #44

[  199.002870] 837 (aplay) task: ffffffc019adb0c0 ti: ffffffc019a36000
task.ti: ffffffc019a36000

[  199.014226] 837 (aplay) PC is at 0xf7228aec

[  199.020120] 837 (aplay) LR is at 0x0

[  199.025312] 837 (aplay) pc : [<00000000f7228aec>] lr :
[<0000000000000000>] pstate: 60000010

[  199.036415] 837 (aplay) sp : ffffffc019a37ff0


BR
Cosmo


2013/11/21 Clemens Ladisch <clemens@ladisch.de>

> Please don't top-post.
>
> Cosmo wrote:
> > Hi, Clemens
>
> Don't drop the mailing list from replies.
>
> > Do you mean we need to change ALSA's mmap code to adapt to ARM64.
>
> Maybe.
>
> > Do you know how to port it?
>
> No.
>
>
> Regards,
> Clemens
>
