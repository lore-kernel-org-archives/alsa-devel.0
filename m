From: r80115 <alan.tull@freescale.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Thu, 10 Nov 2011 09:14:25 -0600
Message-ID: <4EBBEA51.90707@freescale.com>
References: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
	<20111110114310.GA3832@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AEF424349
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 16:14:36 +0100 (CET)
In-Reply-To: <20111110114310.GA3832@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On 11/10/2011 5:43 AM, Mark Brown wrote:
> On Tue, Nov 01, 2011 at 04:05:16PM -0500, Alan Tull wrote:
>
> This looks mostly good, though as someone pointed out earlier it'd be
> nicer to split the ioctl() operation addition out into a separate patch.
> One issue, though.
>
>> @@ -1547,6 +1547,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
>>
>>   	snd_soc_dapm_free(&card->dapm);
>>
>> +	kfree(card->rtd->ops);
>
> This is going to leak - rtd is an array per PCM, not a single value, so
> we need to free the ops for each element.  This is so we can have
> multiple DMA controllers in a single card.
>
> Actually what would be even easier would be to just embed the ops in the
> struct, we need to allocate one per runtime anyway and it makes for less
> allocation and cleanup code.
>

In soc-pcm.c we allocate:
soc_pcm_ops = kzalloc(sizeof(struct snd_pcm_ops), GFP_KERNEL);

and set it to the pointer

rtd->ops = soc_pcm_ops;

So that's what is freed there.

-- 
Regards,
Alan
