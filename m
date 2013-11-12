From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Date: Tue, 12 Nov 2013 08:59:29 +0100
Message-ID: <5281DFE1.3040904@metafoo.de>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
 <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131112050226.GK8834@intel.com>
 <1DD289F6464F0949A2FCA5AA6DC23F8287E87B@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 147DE26087D
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 08:58:35 +0100 (CET)
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F8287E87B@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Li Xiubo <Li.Xiubo@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Shawn Guo <Shawn.Guo@freescale.com>, "djbw@fb.com" <djbw@fb.com>, rob.her
List-Id: alsa-devel@alsa-project.org

On 11/12/2013 08:35 AM, Li Xiubo wrote:
>>>>> +static int fsl_sai_probe(struct platform_device *pdev) {
>>>> [...]
>>>>> +
>>>>> +	sai->dma_params_rx.addr = res->start + SAI_RDR;
>>>>> +	sai->dma_params_rx.maxburst = 6;
>>>>> +	index = of_property_match_string(np, "dma-names", "rx");
>>>>> +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells",
>> index,
>>>>> +				&dma_args);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +	sai->dma_params_rx.slave_id = dma_args.args[1];
>>>>> +
>>>>> +	sai->dma_params_tx.addr = res->start + SAI_TDR;
>>>>> +	sai->dma_params_tx.maxburst = 6;
>>>>> +	index = of_property_match_string(np, "dma-names", "tx");
>>>>> +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells",
>> index,
>>>>> +				&dma_args);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +	sai->dma_params_tx.slave_id = dma_args.args[1];
>>>>
>>>> The driver should not have to manually parse the dma devicetree
>>>> properties, this is something that should be handled by the dma
>>>> engine driver.
>>>>
>>>
>>> What do you think about the DMA slave_id ?
>>> I have been noticed by one colleague that this should be parsed here,
>>> which is from your opinions ?
>> Sure slave_id can be parsed here, but IMO it should be programmed via the
>> dma_slave_confog into the respective channel
>>
>
> Actually, these are parsed for cpu_dai->playback_dma_data and cpu_dai->capture_dma_data dynamically, whose type is struct dma_slave_config.
>
> And now I must parse them here, because the platform eDMA driver's newest version will check and use the slave_ids to select and configure the eDMA channels via dma_device->device_control().

Parsing them here is a layering violation. The format of the DMA specifier 
depends on the DMA controller. A DMA slave should not make any assumptions 
about how the specifier looks like, it should not even look at them. You should 
fix the DMA controller driver to work without slave_id in the devicetree case.

- Lars
