From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Getting physical address of the DMA buffer
Date: Wed, 27 Jun 2007 17:04:46 +0530
Message-ID: <61445c750706270434haec1a30u4bee9dfe75c0328f@mail.gmail.com>
References: <61445c750706261104i24d912edp6eee24944e3bd16f@mail.gmail.com>
	<1182926306.31503.1197270305@webmail.messagingengine.com>
	<61445c750706270148m486dcceai27959d18feedd63c@mail.gmail.com>
	<1182943390.6968.1197305251@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 978EC103854
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 13:34:47 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so173678wag
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 04:34:46 -0700 (PDT)
In-Reply-To: <1182943390.6968.1197305251@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Okay got it now. The omap I am using has a ARM926 which has a MMU. So
I shouldn't be using SNDRV_DMA_TYPE_CONTINUOUS. I will try to allocate
using other methods.

On 6/27/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Pharaoh . wrote:
> > On 6/27/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > > SNDRV_DMA_TYPE_CONTINUOUS is for a buffer that cannot be accessed
> > > over DMA.
> > >
> > > What kind of bus does your hardware use, and how would you
> > > allocate memory for it?
> >
> > Continuous buffers unrelated to the bus type can be allocated using
> > SNDRV_DMA_TYPE_CONTINUOUS right? I am referring a standard driver from
> > omap source tree, and the buffer allocation functions I have copied
> > from there and they should be same for the range of OMAPs since the
> > dma handling is same for them.
>
> I don't know anything about OMAP.
>
> If the processor doesn't use a MMU, then the memory addresses as seen
> by the CPU are the same as those used by a device using DMA.  In that
> case, you could use SNDRV_DMA_TYPE_CONTINUOUS and the correct address
> would be available as runtime->dma_area.
>
>
> HTH
> Clemens
>
