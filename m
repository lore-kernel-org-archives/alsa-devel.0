From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Fix Baytrail SST DSP
	firmware loading
Date: Wed, 14 May 2014 09:18:14 +0300
Message-ID: <53730AA6.5060300@linux.intel.com>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140513172604.GM12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5921C261A01
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 08:18:18 +0200 (CEST)
In-Reply-To: <20140513172604.GM12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/13/2014 08:26 PM, Mark Brown wrote:
> On Fri, May 09, 2014 at 04:47:43PM +0300, Jarkko Nikula wrote:
>
>> -	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +	ret = dma_coerce_mask_and_coherent(sst->dma_dev, DMA_BIT_MASK(32));
>>   	if (ret)
>>   		return ret;
> My resolution of the merge of your revised version and topic/intel looks
> like this so I *think* it's OK but please check that I did the right
> thing.

Thanks, it's ok! And sorry the mess, I was somehow blind to see Liam's 
patch being 3.15 material. Hurry to weekend I guess.

-- 
Jarkko
