From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Thu, 5 Dec 2013 17:33:46 +0200
Message-ID: <52A09CDA.6010700@ti.com>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A01D0265553
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 16:33:51 +0100 (CET)
In-Reply-To: <20131205095619.GC4360@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 12/05/2013 11:56 AM, Russell King - ARM Linux wrote:
> On Thu, Dec 05, 2013 at 10:06:42AM +0200, Peter Ujfalusi wrote:
>> The underlying API dma_coerce_mask_and_coherent() checks the requested b=
its
>> mask against the size of dma_addr_t which is 32bits on OMAP.
>> Because of the previously used 64bits mask audio was not probing after
>> commit c9bd5e6 (and 4dcfa6007).
>> 32bits for the DMA_BIT_MASK looks to be the correct one to use.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi Mark,
>>
>> This is the fix for OMAP audio for 3.13-rc2+. The dma coherent changes w=
ent in
>> between -rc1 and -rc2 which broke things because omap-pcm was using 64bi=
ts for
>> dma coherent mask.
> =

> Can you please try to understand _why_ it broke and post an explanation.
> This breakage wasn't expected and shouldn't have happened.

I'm not that familiar with this part of the code (mm, dma-mapping) but so f=
ar
this is what I found:

ret =3D dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(64));
is successful, no failure to set the mask to 64.

later on when requesting the dma channel however:
arm_dma_alloc() -> get_coherent_dma_mask()  fails.

As far I can see we have different checks in case of
dma_coerce_mask_and_coherent() and arm_dma_alloc():

[1] dma_coerce_mask_and_coherent() -> dma_supported()

 	if (sizeof(mask) !=3D sizeof(dma_addr_t) &&
 	    mask > (dma_addr_t)~0 &&
 	    dma_to_pfn(dev, ~0) > arm_dma_pfn_limit)  /* !!! */
 		return 0;


[2] arm_dma_alloc() -> get_coherent_dma_mask()

 	if (sizeof(mask) !=3D sizeof(dma_addr_t) &&
 	    mask > (dma_addr_t)~0 &&
 	    dma_to_pfn(dev, ~0) > min(max_pfn, arm_dma_pfn_limit)) /* !!! */
 		return 0;

On omap4:
max_pfn: 0xc0000, arm_dma_pfn_limit: 0xfffff

Not sure which check is the correct one but I think in both cases we should
have the same check in this way we can catch the issue at
dma_coerce_mask_and_coherent() time and try to figure out what to do.
In case of omap-pcm we request for 64 bit because of future SoCs, but I thi=
nk
it would be fine to try first 64 and in case it is not supported fall back =
to 32.

-- =

P=E9ter
