From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Re: Use of snd_pcm_format_set_silence
Date: Thu, 21 Jan 2016 10:29:45 -0600
Message-ID: <CACaQK7A7J1+LdoK4Oa4Dx=wsLUNx7yVz=HiKgkweO9nFRZ7OFA@mail.gmail.com>
References: <CACaQK7C04jg3nP-7ijntq+ADEdO41+Ab1VpRDS1vwFXWAPPTHg@mail.gmail.com>
 <56A002A2.5070200@ladisch.de>
 <CACaQK7ARzW=LJ3Xo5=Qyh42uyR96Pbo_SFGOfCh3j6ZozobjcA@mail.gmail.com>
 <56A08C0F.8070902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E06FD26070C
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 17:29:45 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id b14so89704244wmb.1
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 08:29:45 -0800 (PST)
In-Reply-To: <56A08C0F.8070902@ladisch.de>
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

Hello Clemens,

Thank you very much for the confirmation.

Regards,
Ankhit

On Thu, Jan 21, 2016 at 1:43 AM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Ankhit Vivekananda wrote:
> > the snd_pcm_format_set_silence() would simply /replace/ the actual
> > buffer read from snd_pcm_readi() to zeros(since my application is
> > using signed 32 bit little endian format).
>
> Yes.
>
> > There would be no delay induced in doing so.
>
> Yes; this function does not block.
>
>
> Regards,
> Clemens
>
