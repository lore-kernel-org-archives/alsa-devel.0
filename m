From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Getting physical address of the DMA buffer
Date: Wed, 27 Jun 2007 13:23:10 +0200
Message-ID: <1182943390.6968.1197305251@webmail.messagingengine.com>
References: <61445c750706261104i24d912edp6eee24944e3bd16f@mail.gmail.com>
	<1182926306.31503.1197270305@webmail.messagingengine.com>
	<61445c750706270148m486dcceai27959d18feedd63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id EA129244EF
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 13:23:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706270148m486dcceai27959d18feedd63c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> On 6/27/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > SNDRV_DMA_TYPE_CONTINUOUS is for a buffer that cannot be accessed
> > over DMA.
> >
> > What kind of bus does your hardware use, and how would you
> > allocate memory for it?
> 
> Continuous buffers unrelated to the bus type can be allocated using
> SNDRV_DMA_TYPE_CONTINUOUS right? I am referring a standard driver from
> omap source tree, and the buffer allocation functions I have copied
> from there and they should be same for the range of OMAPs since the
> dma handling is same for them.

I don't know anything about OMAP.

If the processor doesn't use a MMU, then the memory addresses as seen
by the CPU are the same as those used by a device using DMA.  In that
case, you could use SNDRV_DMA_TYPE_CONTINUOUS and the correct address
would be available as runtime->dma_area.


HTH
Clemens
