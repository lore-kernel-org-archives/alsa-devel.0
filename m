From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: Add error checking to probe
	function
Date: Wed, 22 Nov 2017 15:22:43 +0530
Message-ID: <832412fe-41bd-c68a-1b43-37b6d3c3eb48@amd.com>
References: <1511238476-10314-1-git-send-email-linux@roeck-us.net>
 <BN6PR12MB16524EF04A6F7050D60AC602F7230@BN6PR12MB1652.namprd12.prod.outlook.com>
 <ab2e75d2-d1e4-860e-f1de-cf0ef60c94bc@amd.com>
 <BN6PR12MB1652C591F3D7744E549A77ABF7230@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0064.outbound.protection.outlook.com [104.47.37.64])
 by alsa0.perex.cz (Postfix) with ESMTP id D24192671E7
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 05:17:37 +0100 (CET)
In-Reply-To: <BN6PR12MB1652C591F3D7744E549A77ABF7230@BN6PR12MB1652.namprd12.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Agrawal, Akshu" <Akshu.Agrawal@amd.com>, 'Guenter Roeck' <linux@roeck-us.net>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dominik Behr <dbehr@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On Tuesday 21 November 2017 08:38 PM, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Agrawal, Akshu
>> Sent: Tuesday, November 21, 2017 1:15 AM
>> To: Deucher, Alexander; 'Guenter Roeck'; Liam Girdwood; Mukunda,
>> Vijendar
>> Cc: Mark Brown; Jaroslav Kysela; Takashi Iwai; alsa-devel@alsa-project.org;
>> linux-kernel@vger.kernel.org; Dominik Behr; Daniel Kurtz
>> Subject: Re: [PATCH] ASoC: amd: Add error checking to probe function
>>
>>
>>
>> On 11/21/2017 10:17 AM, Deucher, Alexander wrote:
>>>> -----Original Message-----
>>>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
>>>> Roeck
>>>> Sent: Monday, November 20, 2017 11:28 PM
>>>> To: Liam Girdwood
>>>> Cc: Mark Brown; Jaroslav Kysela; Takashi Iwai; alsa-devel@alsa-
>> project.org;
>>>> linux-kernel@vger.kernel.org; Guenter Roeck; Deucher, Alexander;
>> Dominik
>>>> Behr; Daniel Kurtz
>>>> Subject: [PATCH] ASoC: amd: Add error checking to probe function
>>>>
>>>> The acp_audio_dma does not perform sufficient error checking in its
>> probe
>>>> function. This can result in crashes if a critical error path is
>>>> encountered.
>>>>
>>>> Fixes: 7c31335a03b6a ("ASoC: AMD: add AMD ASoC ACP 2.x DMA driver")
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Dominik Behr <dbehr@chromium.org>
>>>> Cc: Daniel Kurtz <djkurtz@chromium.org>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> I didn't add an error check to acp_init() since I was not sure if
>>>> its return value is ignored on purpose.
>>> Vijendar, Akshu can you comment?
>> This is also the case of missing error check.
>> acp_init will return error if either sw reset did not happen or clock
>> did not get enabled. In both cases we should error out in probe.
>>
> Can you send out a patch to enable that error checking?
>
> Thanks,
>
> Alex
>   
on top of this patch will add more error checks and submit a new patch
>>> The patch looks good to me.
>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>>>    sound/soc/amd/acp-pcm-dma.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-
>>>> dma.c
>>>> index 9f521a55d610..b5e41df6bb3a 100644
>>>> --- a/sound/soc/amd/acp-pcm-dma.c
>>>> +++ b/sound/soc/amd/acp-pcm-dma.c
>>>> @@ -1051,6 +1051,11 @@ static int acp_audio_probe(struct
>> platform_device
>>>> *pdev)
>>>>    	struct resource *res;
>>>>    	const u32 *pdata = pdev->dev.platform_data;
>>>>
>>>> +	if (!pdata) {
>>>> +		dev_err(&pdev->dev, "Missing platform data\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>>    	audio_drv_data = devm_kzalloc(&pdev->dev, sizeof(struct
>>>> audio_drv_data),
>>>>    					GFP_KERNEL);
>>>>    	if (audio_drv_data == NULL)
>>>> @@ -1058,6 +1063,8 @@ static int acp_audio_probe(struct
>> platform_device
>>>> *pdev)
>>>>
>>>>    	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>    	audio_drv_data->acp_mmio = devm_ioremap_resource(&pdev-
>>>>> dev, res);
>>>> +	if (IS_ERR(audio_drv_data->acp_mmio))
>>>> +		return PTR_ERR(audio_drv_data->acp_mmio);
>>>>
>>>>    	/* The following members gets populated in device 'open'
>>>>    	 * function. Till then interrupts are disabled in 'acp_init'
>>>> --
>>>> 2.7.4
