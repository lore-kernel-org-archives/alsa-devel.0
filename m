From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2 REPOST] ASoC: dmaengine: support
 deferred probe for DMA channels
Date: Tue, 10 Dec 2013 11:11:16 -0700
Message-ID: <52A75944.1020305@wwwdotorg.org>
References: <1386698361-7910-1-git-send-email-swarren@wwwdotorg.org>
 <52A75831.3020307@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5E526531B
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 19:11:19 +0100 (CET)
In-Reply-To: <52A75831.3020307@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/10/2013 11:06 AM, Lars-Peter Clausen wrote:
> On 12/10/2013 06:59 PM, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Enhance dmaengine_pcm_request_chan_of() to support deferred probe for
>> DMA channels, by using the new dma_request_slave_channel_or_err() API.
>> This prevents snd_dmaengine_pcm_register() from succeeding without
>> acquiring DMA channels due to the relevant DMA controller not yet being
>> registered.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Still looks good, but one nitpick:
> 
>> -		pcm->chan[i] = dma_request_slave_channel(dev, name);
>> +		chan = dma_request_slave_channel_reason(dev, name);
>> +		if (IS_ERR(chan)) {
>> +			if (PTR_ERR(pcm->chan[i]) == -EPROBE_DEFER)
>> +				return -EPROBE_DEFER;
>> +			pcm->chan[i] = NULL;
>> +		} else
>> +			pcm->chan[i] = chan;
> 
> I think checkpatch will complain about the above. There should be brackets
> around the else branch.

Hmm. It doesn't complain for some reason, but I'll fix that and repost.
