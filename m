From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Mon, 9 Dec 2013 11:56:03 +0200
Message-ID: <52A593B3.1010607@ti.com>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>	<20131205095619.GC4360@n2100.arm.linux.org.uk>	<52A09CDA.6010700@ti.com>	<20131205192853.GH4360@n2100.arm.linux.org.uk>	<s5h4n6nhxbt.wl%tiwai@suse.de>	<20131205210707.GI4360@n2100.arm.linux.org.uk>	<s5htxemgzyx.wl%tiwai@suse.de>	<20131206122543.GL4360@n2100.arm.linux.org.uk>
 <s5hpppa3zc9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F05C32615F7
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 10:56:09 +0100 (CET)
In-Reply-To: <s5hpppa3zc9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 12/06/2013 03:04 PM, Takashi Iwai wrote:
> At Fri, 6 Dec 2013 12:25:43 +0000,
> Russell King - ARM Linux wrote:
>>
>> On Fri, Dec 06, 2013 at 09:12:22AM +0100, Takashi Iwai wrote:
>>> But, it's still unclear why only get_coherent_dma_mask() takes max_pfn
>>> into account for the check of dma_to_pfn(dev, mask).
>>>
>>> In dma_supported(), =

>>>
>>> 	unsigned long limit;
>>> 	limit =3D dma_to_pfn(dev, mask);
>>> 	if (limit < arm_dma_pfn_limit)
>>> 		return 0;
>>>
>>> while in get_coherent_dma_mask(),
>>>
>>> 	unsigned long max_dma_pfn;
>>> 	max_dma_pfn =3D min(max_pfn, arm_dma_pfn_limit);
>>> 	if (dma_to_pfn(dev, mask) < max_dma_pfn)
>>> 		return 0;
>>>
>>> So, the current code looks to me that the results from
>>> dma_set_coherent_mask() and the actual allocation may conflict.
>>
>> I did ask Peter to replace *both* with the same thing.
> =

> Well, I'm looking at different points.  You requested Peter to test
> both functions to take:
> =

>  	if (sizeof(mask) !=3D sizeof(dma_addr_t) &&
>  	    mask > (dma_addr_t)~0 &&
>  	    dma_to_pfn(dev, ~0) < min(max_pfn, arm_dma_pfn_limit))
> 		return 0;
> =

> But, after that line, dma_supported() has another check:
> =

>  	if (dma_to_pfn(dev, mask) < arm_dma_pfn_limit)
>  		return 0;
> =

> and get_coherent_dma_mask() has a different check:
> =

>  	if (dma_to_pfn(dev, mask) < min(max_pfn, arm_dma_pfn_limit))
>  		return 0;
> =

> (the expressions here are expanded for easier comparison)
> =

> This is what I'm wondering.


The tests in get_coherent_dma_mask() and dma_supported() should be identica=
l.
Fixing the dma_supported() checks and calling dma_supported() from
get_coherent_dma_mask() instead of doing the same test coded locally there
should be the preferred solution.

I think dma_supported() should be like this:

int dma_supported(struct device *dev, u64 mask)
{
	unsigned long max_dma_pfn;

	/*
	 * If the mask allows for more memory than we can address,
	 * and we actually have that much memory, then we must
	 * indicate that DMA to this device is not supported.
	 */
	max_dma_pfn =3D min(max_pfn, arm_dma_pfn_limit);
	if (sizeof(mask) !=3D sizeof(dma_addr_t) &&
	    mask > (dma_addr_t)~0 &&
	    dma_to_pfn(dev, ~0) < max_dma_pfn)
		return 0;

	/*
	 * Translate the device's DMA mask to a PFN limit.  This
	 * PFN number includes the page which we can DMA to.
	 */
	if (dma_to_pfn(dev, mask) < max_dma_pfn)
		return 0;

	return 1;
}


-- =

P=E9ter
