From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Re: Use of snd_pcm_format_set_silence
Date: Wed, 20 Jan 2016 16:17:06 -0600
Message-ID: <CACaQK7ARzW=LJ3Xo5=Qyh42uyR96Pbo_SFGOfCh3j6ZozobjcA@mail.gmail.com>
References: <CACaQK7C04jg3nP-7ijntq+ADEdO41+Ab1VpRDS1vwFXWAPPTHg@mail.gmail.com>
 <56A002A2.5070200@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 898E4260439
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 23:17:06 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id 123so151230236wmz.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 14:17:06 -0800 (PST)
In-Reply-To: <56A002A2.5070200@ladisch.de>
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

Thanks for your response. Just to clarify, the snd_pcm_format_set_silence()
would simply *replace* the actual buffer read from snd_pcm_readi() to
zeros(since my application is using signed 32 bit little endian format).
There would be no delay induced in doing so. Correct?

Regards,
Ankhit

On Wed, Jan 20, 2016 at 3:56 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Ankhit Vivekananda wrote:
> > I have an application where in I need to silence the first few samples of
> > the buffer that is read from snd_pcm_readi(). In order to do this, I call
> > the snd_pcm_format_set_silence() providing the same buffer that the
> > snd_pcm_readi() reads to.
> >
> > 1) By doing this, is there going to be a timing delay due to the use of
> > snd_pcm_format_set_silence()?
>
> That function just modifies memory; it does not affect any PCM device.
>
> > 2) Is snd_pcm_format_set_silence() the correct function to achieve this
> > goal or are there better methods?
>
> You already know your sample format; memset(0) might be simpler.
>
>
> Regards,
> Clemens
>
