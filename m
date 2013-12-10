From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 4/5] ASoC: SPEAr: remove custom DMA alloc
 compat function
Date: Tue, 10 Dec 2013 12:00:22 +0530
Message-ID: <52A6B4FE.3020300@st.com>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-5-git-send-email-swarren@wwwdotorg.org>
 <52A6336D.2040306@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog113.obsmtp.com (eu1sys200aog113.obsmtp.com
 [207.126.144.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D32E26513E
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 07:30:34 +0100 (CET)
In-Reply-To: <52A6336D.2040306@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On 12/10/2013 2:47 AM, Lars-Peter Clausen wrote:
> On 12/09/2013 09:24 PM, Stephen Warren wrote:
>> From: Stephen Warren<swarren@nvidia.com>
>>
>> spear_pcm_request_chan() is almost identical to
>> dmaengine_pcm_compat_request_channel(), with the exception that the
>> latter:
>>
>> a) Assumes that the DAI DMA data is a struct snd_dmaengine_dai_dma_data
>>     pointer rather than some custom type.
>>
>> b) dma_data->filter_data rather than dma_data should be passed to
>>     snd_dmaengine_pcm_request_channel() as the filter data.
>>
>> Make minor changes to the SPEAr DAI drivers so that those two conditions
>> are met. This allows removal of the custom .compat_request_channel().
>>
>> Signed-off-by: Stephen Warren<swarren@nvidia.com>
>> ---
>>   include/sound/spear_dma.h   |  1 -
>>   sound/soc/spear/spdif_in.c  | 10 +++++++---
>>   sound/soc/spear/spdif_out.c | 10 +++++++---
>>   sound/soc/spear/spear_pcm.c | 21 +++++++--------------
>>   sound/soc/spear/spear_pcm.h |  4 +++-
>>   5 files changed, 24 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/sound/spear_dma.h b/include/sound/spear_dma.h
>> index 1b365bfdfb37..65aca51fe255 100644
>> --- a/include/sound/spear_dma.h
>> +++ b/include/sound/spear_dma.h
>> @@ -29,7 +29,6 @@ struct spear_dma_data {
>>   	dma_addr_t addr;
>>   	u32 max_burst;
>>   	enum dma_slave_buswidth addr_width;
>> -	bool (*filter)(struct dma_chan *chan, void *slave);
>>   };
>
> Hm, that spear_dma_data struct looks pretty much like
> snd_dmaengine_dai_dma_data. It's a bit hard to say how it is used exactly
> since the receiver of that struct doesn't seem to be upstream. Rajeev, how
> is this used? The data in spear_dma_data looks like it should be passed to
> the DMA driver via dmaengine_slave_config() rather than while requesting the
> channel.
>
> - Lars
> .
>

The structure spear_dma_data is used to initialize dma parameters 
received from platform data which is required for dma slave configuration.

~Rajeev
