From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Re: print audio ring buffer in kernel space
Date: Thu, 29 Oct 2015 15:11:00 -0500
Message-ID: <CACaQK7COwmTMf0UBeKXRCtjAtDBLCHC2wMhKnNByAfUuWAKwDA@mail.gmail.com>
References: <CACaQK7C7bH1wHomQyJLS=N1V+m5DeSus=4cjB=2WMv4B+3Np+Q@mail.gmail.com>
 <56327C42.6000202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E6EF2651A5
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 21:11:01 +0100 (CET)
Received: by wicll6 with SMTP id ll6so237550950wic.0
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 13:11:01 -0700 (PDT)
In-Reply-To: <56327C42.6000202@ladisch.de>
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

No, I do not suspect an error in the snd_pcm_readi(), but would want to
print the data(using printk) from the hardware buffer directly, and see
that it matches with the buffer after snd_pcm_readi() call. I would want to
know where the hardware buffer is located at so that I can trace it down.

Regards,
Ankhit

On Thu, Oct 29, 2015 at 3:06 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Ankhit Vivekananda wrote:
> > I am trying to print the ring buffer used for DMA transfer using ALSA in
> > kernel space. I was able to print the ring buffer in user space after
> > calling the snd_pcm_readi() function. But, wanted to know as to which
> file
> > I need to be looking at to print the hardware buffer in kernel space.
>
> The driver typically does not access the buffer.  There is no such file.
>
> (And why would you need it?  Do you suspect an error in the
> implementation of snd_pcm_readi()?)
>
>
> Regards,
> Clemens
>
