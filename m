From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Re: Fwd: [PATCH] Dreamcast AICA sound driver G2 bus
	handling
Date: Tue, 18 Sep 2007 08:02:46 +0100
Message-ID: <8b67d60709180002h3c2167b4qb0b42db3c98e3543@mail.gmail.com>
References: <8b67d60709151239w2f983e74t9a36eb0c566e09cc@mail.gmail.com>
	<8b67d60709160412p2f4dfdfkba2b6a54c7ffc5cf@mail.gmail.com>
	<s5hps0heaxr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 93F392445A
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 09:02:48 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id u77so3591980pyb
	for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2007 00:02:47 -0700 (PDT)
In-Reply-To: <s5hps0heaxr.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17/09/2007, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 16 Sep 2007 12:12:08 +0100,
> Adrian McMenamin wrote:
> >
> > Resending this as I typed the wrong address for alsa-devel last night.
> > A general clean up as well as some changes to interrupt handling.
> >
> >
> >
> > This patch handles instability on the Dreamcast G2 bus while PIO or
> > DMA is underway on the System -> AICA channel.
> >
> > Without the suspension of interrupts when PIO or DMA is underway the
> > G2 bus is prone to timeouts leading to seemingly random crashes. This
> > is particularly visible in cases such as maple bus (see
> > http://lkml.org/lkml/2007/9/15/181) hotplugging but the patch is good
> > for all conditions.
>
> Hm, it isn't optimal but if it's safe...
>
> BTW, what is the exat matter?
> Is it race or do you have to always disable IRQ during DMA?
> In the former case, spin_lock_irqsave() is basically the way to go.
>

I'm afraid it is a hardware bug/feature rather than a race. I'll
rework and repost
