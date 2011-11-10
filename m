From: r80115 <alan.tull@freescale.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Thu, 10 Nov 2011 09:20:35 -0600
Message-ID: <4EBBEBC3.8060406@freescale.com>
References: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
	<20111110114310.GA3832@opensource.wolfsonmicro.com>
	<4EBBEA51.90707@freescale.com>
	<20111110151619.GI3832@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id DDC9524353
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 16:21:28 +0100 (CET)
In-Reply-To: <20111110151619.GI3832@opensource.wolfsonmicro.com>
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

On 11/10/2011 9:16 AM, Mark Brown wrote:
> On Thu, Nov 10, 2011 at 09:14:25AM -0600, r80115 wrote:
>> On 11/10/2011 5:43 AM, Mark Brown wrote:
>
>>> This is going to leak - rtd is an array per PCM, not a single value, so
>>> we need to free the ops for each element.  This is so we can have
>>> multiple DMA controllers in a single card.
>
>>> Actually what would be even easier would be to just embed the ops in the
>>> struct, we need to allocate one per runtime anyway and it makes for less
>>> allocation and cleanup code.
>
>> In soc-pcm.c we allocate:
>> soc_pcm_ops = kzalloc(sizeof(struct snd_pcm_ops), GFP_KERNEL);
>
>> and set it to the pointer
>
>> rtd->ops = soc_pcm_ops;
>
>> So that's what is freed there.
>
> You're not getting the point here.  The point is that you're only
> freeing a single copy of the ops no matter how many are allocated.
>

I see.  This is sounding like a significant rewrite.  I'll have to 
revisit this then.  Thanks for catching that.

-- 
Regards,
Alan
