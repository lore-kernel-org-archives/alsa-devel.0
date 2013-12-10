From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Tue, 10 Dec 2013 08:47:14 +0100
Message-ID: <52A6C702.4000607@metafoo.de>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
 <52A62BC3.1050807@metafoo.de> <52A6573E.1000504@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 43DA52608E8
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 08:46:02 +0100 (CET)
In-Reply-To: <52A6573E.1000504@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/10/2013 12:50 AM, Stephen Warren wrote:
> On 12/09/2013 01:44 PM, Lars-Peter Clausen wrote:
>> On 12/09/2013 09:24 PM, Stephen Warren wrote:
>> [...]
>>>
>>> -static int ep93xx_soc_platform_probe(struct platform_device *pdev)
>>> +int ep93xx_pcm_platform_register(struct device *dev)
>>>   {
>>> -	return snd_dmaengine_pcm_register(&pdev->dev,
>>> +	return snd_dmaengine_pcm_register(dev,
>>
>> This will have a conflict with the "ASoC: ep93xx: Use
>> devm_snd_dmaengine_pcm_register()" patch from the topic/ep93xx branch.
>
> That's true. The conflict isn't conceptually that hard to resolve, but
> probably a lot more than you want to do in a merge. I guess the way to
> resolve it is to merge topic/ep93xx and topic/spear into topic/dma, then
> to apply these patches on top. If that sounds good, I can rebase them
> and resend.

I'd assume that the first two patches from this series go into topic/ep93xx and 
the second two into topic/spear and the last one will have to wait for ux500 
anyway.

>
> ... although that said, I'll need topic/dma as a dependency for that
> Tegra DMA controller rework, and I'm not sure I want to pick up these
> ep93xx/spear changes there, so I wonder if we should hold off doing the
> merge and applying these patches until I've pulled in topic/dma, or
> perhaps a separate topic branch is needed for this cleanup?
>
