From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Re: Discarding the first few frames inside the kernel
Date: Thu, 21 Jan 2016 10:28:56 -0600
Message-ID: <CACaQK7DO4ecdBXzto+p0pUB=3crKHKw-ceJVrvYWOWYVee2yog@mail.gmail.com>
References: <CACaQK7CtpKQK_j5q+F6ekK_j+w3SLQ=RQ0yR76+81ETvsg1Qdg@mail.gmail.com>
 <569D9DFE.5000503@sakamocchi.jp>
 <CACaQK7DCUx7=2t-SBZQ6vjU4OJ+Le0YcOK_D-0q4RqFczTO9Zg@mail.gmail.com>
 <56A04004.1020206@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6280C2606FD
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 17:28:56 +0100 (CET)
Received: by mail-wm0-f48.google.com with SMTP id l65so227154057wmf.1
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 08:28:56 -0800 (PST)
In-Reply-To: <56A04004.1020206@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Thank you very much for the explanation.

Regards,
Ankhit

On Wed, Jan 20, 2016 at 8:18 PM, Takashi Sakamoto <o-takashi@sakamocchi.jp>
wrote:

> Hi,
>
> On Jan 21 2016 02:24, Ankhit Vivekananda wrote:
>
>> I am not sure as to how the wait for 4.5ms can be applied there?
>>
>
> I think you asked about the way to achieve the idea.
>
> Call kernel's process scheduler in the .prepare() implementation of your
> driver. For example, msleep() in <linux/delay.h> (More geneous logic is
> preferrable, I think.)
>
> Don't do this in .trigger() implementation, because this can be called in
> interrupt context, or between spin_lock_irqsave()/spin_lock_irqstore() in
> process context.
>
> Alternatively, does calling snd_pcm_format_set_silence(), be a safe
>> method to silence the first few samples coming out of the buffer?
>>
>
> I don't know exactly because I have no supplemental information about your
> driver and hardware design.
>
>
> Regards
>
> Takashi Sakamoto
>
