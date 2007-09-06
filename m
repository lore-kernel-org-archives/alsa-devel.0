From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: DMA buffer gets played only once
Date: Wed, 5 Sep 2007 22:14:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709052207551.31808@shell4.speakeasy.net>
References: <46DE4AB1.20206@hrz.tu-chemnitz.de>
	<1188983079.7844.1208974467@webmail.messagingengine.com>
	<46DE7422.5020900@hrz.tu-chemnitz.de> <s5hbqch8e5o.wl%tiwai@suse.de>
	<46DF83C6.1090002@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail8.sea5.speakeasy.net (mail8.sea5.speakeasy.net
	[69.17.117.10]) by alsa0.perex.cz (Postfix) with ESMTP id C38841037F4
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 07:14:20 +0200 (CEST)
In-Reply-To: <46DF83C6.1090002@hrz.tu-chemnitz.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Franke <markus.franke@s2002.tu-chemnitz.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Sep 2007, Markus Franke wrote:
> Takashi Iwai wrote:
> >> At least this is the behaviour I experienced.
> >
> > It's your mis-interpretation of START/STOP concenpt in the ALSA
> > framework.  The trigger START and STOP mean the start/stop of the
> > whole streaming operation.  It's basically called from the outside,
> > i.e. the application starts/stops the stream.  If you need to keep
> > some DMA start/stop operations internally, do it in the driver
> > lowlevel side internally.
>
> thanks for reply but as already stated this is the behaviour I
> _experienced_. I don't know why also continuously calls trigger START,
> play one period, trigger STOP. Here is some pseudo code:
>
>
> vi1888_pcm_dma_userCallback() // gets called upon completion of DMA
> transfer
> {
>          prtd->period_ptr += prtd->period_size;
>          if (prtd->period_ptr >= prtd->dma_buffer_end) {
>                  prtd->period_ptr = prtd->dma_buffer;
>          }

You need to make sure the buffer size is an integer multiple of the period
size if you wrap like this.

> After each call to snd_pcm_period_elapsed() Alsa calls
> pcm_trigger(TRIGGER_STOP).
>
> Please tell me what I am doing wrong in these callbacks?

I found that ALSA would call TRIGGER_STOP if it detected an overrun.

Check the value returned for every call of your pointer callback.  I found out
that ALSA was calling the pointer callback before the first IRQ, which was
something I hadn't planned on and the values confused ALSA.
