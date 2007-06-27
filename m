From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Getting physical address of the DMA buffer
Date: Wed, 27 Jun 2007 08:38:26 +0200
Message-ID: <1182926306.31503.1197270305@webmail.messagingengine.com>
References: <61445c750706261104i24d912edp6eee24944e3bd16f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B87B0103830
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 08:38:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706261104i24d912edp6eee24944e3bd16f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> I have allocated the DMA buffer using snd_pcm_lib_malloc_pages() and
> it was preallocated as:
> 
> snd_pcm_lib_preallocate_pages_for_all(pcm,
>                                       SNDRV_DMA_TYPE_CONTINUOUS,
>                                       snd_dma_continuous_data
>                                       (GFP_KERNEL),

SNDRV_DMA_TYPE_CONTINUOUS is for a buffer that cannot be accessed
over DMA.

What kind of bus does your hardware use, and how would you
allocate memory for it?


Regards,
Clemens
