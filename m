From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 16:20:33 +0530
Message-ID: <CAJe_ZhfnSkYz_zWbHTs43GtCdvisiq4xztV9xcbW6i0jj7boCA@mail.gmail.com>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <CABb+yY1-RyuCigCYM-dwsc1D1vSvy+QX1nunrc8G+3bT2n134g@mail.gmail.com>
 <1343039998.1726.4833.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EB7F6265283
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 12:50:31 +0200 (CEST)
Received: by vbip1 with SMTP id p1so4502909vbi.38
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 03:50:33 -0700 (PDT)
In-Reply-To: <1343039998.1726.4833.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 23 July 2012 16:09, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Mon, 2012-07-23 at 15:49 +0530, Jassi Brar wrote:
>> On Mon, Jul 23, 2012 at 3:36 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
>> > In many modern SoCs the audio DSP can buffer the PCM ring buffer data. Today we
>> > have no means to represent this buffering and ALSA wrongly detects an overrun
>> > when hw_ptr reaches app_ptr value, though DSP may still have some buffered data.
>> >
>> > This patch tries to add a new field "soc_delay" to represent buffering done in
>> > DSPs. This value is also used for the xrun calculations in ALSA.
>> >
>> Couldn't we employ snd_pcm_hw_params.fifo_size for the purpose ?
> Nope, that should be used to represent the delay in samples being output
> not the sample which are buffered and processed in a DSP
>
After leaving alsa ring buffer, don't the samples incur extra delay of
your internal  buffer ?
