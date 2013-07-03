From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 2/2] ASoC: atmel-pcm: use generic dmaengine
 framework
Date: Wed, 3 Jul 2013 16:13:28 +0800
Message-ID: <51D3DD28.8050900@atmel.com>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com>
 <1372755849-19546-3-git-send-email-voice.shen@atmel.com>
 <51D2F306.7040603@metafoo.de> <51D37F87.2010008@atmel.com>
 <51D3D482.1050100@metafoo.de> <51D3D969.1060308@atmel.com>
 <51D3DBE8.4090407@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nasmtp02.atmel.com (nasmtp02.atmel.com [204.2.163.16])
 by alsa0.perex.cz (Postfix) with ESMTP id C41F5265575
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 10:14:02 +0200 (CEST)
In-Reply-To: <51D3DBE8.4090407@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 7/3/2013 16:08, Lars-Peter Clausen wrote:
> On 07/03/2013 09:57 AM, Bo Shen wrote:
>> Hi Lars,
>>
>> On 7/3/2013 15:36, Lars-Peter Clausen wrote:
>>>>>> +        slave_config->dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
>>>>>>> [...]
>>>>>>>>> +        slave_config->src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;
>>>>>>>
>>>>>>> Change the type of phybase to dma_addr_t
>>>>>
>>>>> It should be:
>>>>> slave_config->dst_addr = (dma_addr_t)(ssc->phybase + SSC_THR);
>>>>> slave_config->src_addr = (dma_addr_t)(ssc->phybase + SSC_RHR);
>>> The type of phybase in the ssc_device struct should be changed from
>>> resource_size_t to dma_addr_t.
>>
>> Actually, the phybase in ssc_device structure is resource_size_t which used to
>> access the ssc device register.
>> Here, we use ssc register as dma source address or destination address, so we
>> convert it to dma_addr_t type. So, not need to change, am I right?
>
> Isn't 'regs' used to access the registers? As far as I can see phybase is only
> used in the audio DMA driver.

Thanks for point out this. I will change the phybase type from 
resource_size_t to dma_addr_t.

> - Lars
>

Best Regards,
Bo Shen
