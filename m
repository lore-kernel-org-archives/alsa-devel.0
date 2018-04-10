From: Freaky <freaky2000@gmail.com>
Subject: Re: No audio on iMac18,1 (A1418) with kernel 4.15.14
Date: Tue, 10 Apr 2018 16:34:47 +0200
Message-ID: <CAEw6ZytErrkSmBdC+aiQJk38qa64x5a6qLC4zAt1-rjn2+_2eg@mail.gmail.com>
References: <CAEw6ZysiM28o+AM5FTE5L24BNKYBEgV2Ktm4oifwmBR9KFEi_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id BBC772673C7
 for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2018 16:34:49 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id v2so13584566qkh.10
 for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2018 07:34:49 -0700 (PDT)
In-Reply-To: <CAEw6ZysiM28o+AM5FTE5L24BNKYBEgV2Ktm4oifwmBR9KFEi_g@mail.gmail.com>
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

FYI: Tested all the pin outs with hda-analyzer, didn't get sound on the
speakers with any of them.

On Tue, Apr 10, 2018 at 3:57 PM, Freaky <freaky2000@gmail.com> wrote:

> Hi there,
>
> we got an iMac18,1 here on which we have no audio.
>
> Maybe the codec is just too new, although I see people using it on
> non-Apple hardware. Using model parameters imac27 or imac27_122 doesn't
> help.
>
> Have alsa-info attached. lspci (on this distro (but it's dated although it
> has a recent kernel)) doesn't recognize it yet, the online PCI-IDs says:
>
> Sunrise Point-LP HD Audio
>
> Found some other people mentioning this issue at Arch, thread is here:
> https://bbs.archlinux.org/viewtopic.php?id=233449&p=2 - no solution so
> far.
>
> Will see if flipping bits with hda-analyzer will make it go.
>
> If there's a solution for this already we'd be much obliged if someone can
> point us to it. Otherwise very willing to help, but can't code drivers
> unfortunately. Can apply patches and build kernels however :). We'll have
> to return the machine in about a week, so if anyone desires
> output/testing/etc. please let us know asap as we only have it available
> for a short while.
>
> Will post the solution, if we can find one, to the Arch thread as well.
>
> Thanks in advance.
>
> Kind regards
>
