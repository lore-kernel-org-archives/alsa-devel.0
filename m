From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
 mask to 32bits
Date: Fri, 13 Dec 2013 13:46:46 +0200
Message-ID: <52AAF3A6.7000306@ti.com>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk> <52A09CDA.6010700@ti.com>
 <20131205192853.GH4360@n2100.arm.linux.org.uk> <s5h4n6nhxbt.wl%tiwai@suse.de>
 <20131205210707.GI4360@n2100.arm.linux.org.uk> <s5htxemgzyx.wl%tiwai@suse.de>
 <20131209170300.GW4360@n2100.arm.linux.org.uk> <52A6E0C5.1080103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 61CE2260320
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:46:51 +0100 (CET)
In-Reply-To: <52A6E0C5.1080103@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 12/10/2013 11:37 AM, Peter Ujfalusi wrote:
> Hi Russell,
> =

> On 12/09/2013 07:03 PM, Russell King - ARM Linux wrote:
>> Yes, that's a good idea.  Revised version of the patch.  Peter, can you
>> retest please, thanks.
> =

> With this patch PandaES and BeagleXM works fine on top of today's mainlin=
e.
> =

> Thank you Russell and Takashi!
> =

> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Russell,

are you planning to send this for 3.13? Without the patch all OMAP audio fa=
ils
to probe in 3.13 kernel.

-- =

P=E9ter

> =

>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index f6b6bfa88ecf..86c564e52ea7 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -158,6 +158,44 @@ struct dma_map_ops arm_coherent_dma_ops =3D {
>>  };
>>  EXPORT_SYMBOL(arm_coherent_dma_ops);
>>  =

>> +static int __dma_supported(struct device *dev, u64 mask, bool warn)
>> +{
>> +	unsigned long max_dma_pfn;
>> +
>> +	/*
>> +	 * If the mask allows for more memory than we can address,
>> +	 * and we actually have that much memory, then we must
>> +	 * indicate that DMA to this device is not supported.
>> +	 */
>> +	if (sizeof(mask) !=3D sizeof(dma_addr_t) &&
>> +	    mask > (dma_addr_t)~0 &&
>> +	    dma_to_pfn(dev, ~0) < max_pfn) {
>> +		if (warn) {
>> +			dev_warn(dev, "Coherent DMA mask %#llx is larger than dma_addr_t all=
ows\n",
>> +				 mask);
>> +			dev_warn(dev, "Driver did not use or check the return value from dma=
_set_coherent_mask()?\n");
>> +		}
>> +		return 0;
>> +	}
>> +
>> +	max_dma_pfn =3D min(max_pfn, arm_dma_pfn_limit);
>> +
>> +	/*
>> +	 * Translate the device's DMA mask to a PFN limit.  This
>> +	 * PFN number includes the page which we can DMA to.
>> +	 */
>> +	if (dma_to_pfn(dev, mask) < max_dma_pfn) {
>> +		if (warn)
>> +			dev_warn(dev, "Coherent DMA mask %#llx (pfn %#lx-%#lx) covers a smal=
ler range of system memory than the DMA zone pfn 0x0-%#lx\n",
>> +				 mask,
>> +				 dma_to_pfn(dev, 0), dma_to_pfn(dev, mask) + 1,
>> +				 max_dma_pfn + 1);
>> +		return 0;
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>>  static u64 get_coherent_dma_mask(struct device *dev)
>>  {
>>  	u64 mask =3D (u64)DMA_BIT_MASK(32);
>> @@ -176,34 +214,8 @@ static u64 get_coherent_dma_mask(struct device *dev)
>>  			return 0;
>>  		}
>>  =

>> -		max_dma_pfn =3D min(max_pfn, arm_dma_pfn_limit);
>> -
>> -		/*
>> -		 * If the mask allows for more memory than we can address,
>> -		 * and we actually have that much memory, then fail the
>> -		 * allocation.
>> -		 */
>> -		if (sizeof(mask) !=3D sizeof(dma_addr_t) &&
>> -		    mask > (dma_addr_t)~0 &&
>> -		    dma_to_pfn(dev, ~0) > max_dma_pfn) {
>> -			dev_warn(dev, "Coherent DMA mask %#llx is larger than dma_addr_t all=
ows\n",
>> -				 mask);
>> -			dev_warn(dev, "Driver did not use or check the return value from dma=
_set_coherent_mask()?\n");
>> -			return 0;
>> -		}
>> -
>> -		/*
>> -		 * Now check that the mask, when translated to a PFN,
>> -		 * fits within the allowable addresses which we can
>> -		 * allocate.
>> -		 */
>> -		if (dma_to_pfn(dev, mask) < max_dma_pfn) {
>> -			dev_warn(dev, "Coherent DMA mask %#llx (pfn %#lx-%#lx) covers a smal=
ler range of system memory than the DMA zone pfn 0x0-%#lx\n",
>> -				 mask,
>> -				 dma_to_pfn(dev, 0), dma_to_pfn(dev, mask) + 1,
>> -				 arm_dma_pfn_limit + 1);
>> +		if (!__dma_supported(dev, mask, true))
>>  			return 0;
>> -		}
>>  	}
>>  =

>>  	return mask;
>> @@ -1032,28 +1044,7 @@ void arm_dma_sync_sg_for_device(struct device *de=
v, struct scatterlist *sg,
>>   */
>>  int dma_supported(struct device *dev, u64 mask)
>>  {
>> -	unsigned long limit;
>> -
>> -	/*
>> -	 * If the mask allows for more memory than we can address,
>> -	 * and we actually have that much memory, then we must
>> -	 * indicate that DMA to this device is not supported.
>> -	 */
>> -	if (sizeof(mask) !=3D sizeof(dma_addr_t) &&
>> -	    mask > (dma_addr_t)~0 &&
>> -	    dma_to_pfn(dev, ~0) > arm_dma_pfn_limit)
>> -		return 0;
>> -
>> -	/*
>> -	 * Translate the device's DMA mask to a PFN limit.  This
>> -	 * PFN number includes the page which we can DMA to.
>> -	 */
>> -	limit =3D dma_to_pfn(dev, mask);
>> -
>> -	if (limit < arm_dma_pfn_limit)
>> -		return 0;
>> -
>> -	return 1;
>> +	return __dma_supported(dev, mask, false);
>>  }
>>  EXPORT_SYMBOL(dma_supported);
>>  =

>>
> =

> =
