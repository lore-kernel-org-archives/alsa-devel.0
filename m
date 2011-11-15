From: r80115 <alan.tull@freescale.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Tue, 15 Nov 2011 11:22:50 -0600
Message-ID: <4EC29FEA.5070605@freescale.com>
References: <1321372779-8692-1-git-send-email-alan.tull@freescale.com>
	<CAOZdJXXubFXg1RTJTB2h_Q4YSPpvuGwikcT1xXsDVadEd3RZAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id E8D021038E4
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 18:22:59 +0100 (CET)
In-Reply-To: <CAOZdJXXubFXg1RTJTB2h_Q4YSPpvuGwikcT1xXsDVadEd3RZAg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Tull Alan-R80115 <R80115@freescale.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 11/15/2011 10:56 AM, Tabi Timur-B04825 wrote:
> Something is wrong.  When I apply this patch, I get this:
>
>    CC      sound/soc/soc-core.o
> /home/b04825/git/linux.34/sound/soc/soc-core.c: In function
> 'soc_cleanup_card_resources':
> /home/b04825/git/linux.34/sound/soc/soc-core.c:1583:3: error:
> incompatible type for argument 1 of 'kfree'
> /home/b04825/git/linux.34/include/linux/slab.h:161:6: note: expected
> 'const void *' but argument is of type 'struct snd_pcm_ops'
>
> 	/* free the ops */
> 	for (i = 0; i<  card->num_rtd; i++) {
> 		struct snd_soc_pcm_runtime *rtd =&card->rtd[i];
> 		kfree(rtd->ops);
> 	}
>
> rtd->ops is not a pointer, so it can't be freed.  Also, this:
>
> +	rtd->ops = soc_pcm_ops;
>
> is a memcpy.  Why not just write to rtd->ops directly?
>


I see the problem.  I implemented this under 2.6.38.  rtd->ops was a 
pointer under 2.6.38.  This could change much then.

-- 
Regards,
Alan
