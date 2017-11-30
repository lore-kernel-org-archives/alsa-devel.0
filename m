From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: added error checks in dma driver
Date: Thu, 30 Nov 2017 10:59:17 +0530
Message-ID: <e6e54494-0579-7447-cee9-223a579f06bf@amd.com>
References: <1511844224-32404-1-git-send-email-Vijendar.Mukunda@amd.com>
 <20171128115210.n3lp3s2ryygx2m3v@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128115210.n3lp3s2ryygx2m3v@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, perex@perex.cz, Alexander.Deucher@amd.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Tuesday 28 November 2017 05:22 PM, Mark Brown wrote:
> On Tue, Nov 28, 2017 at 10:13:44AM +0530, Vijendar Mukunda wrote:
>
>> -	acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
>> +	status = acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
>> +	if (status) {
>> +		dev_err(&pdev->dev, "ACP Init failed\n");
>> +		return status;
>> +	}
>>   
> Better to print the error code to help people see what went wrong.
>
>>   static int acp_audio_remove(struct platform_device *pdev)
>>   {
>> +	int status;
>>   	struct audio_drv_data *adata = dev_get_drvdata(&pdev->dev);
>>   
>> -	acp_deinit(adata->acp_mmio);
>> +	status = acp_deinit(adata->acp_mmio);
>> +	if (status) {
>> +		dev_err(&pdev->dev, "ACP Deinit failed\n");
>> +		return status;
>> +	}
>>   	snd_soc_unregister_platform(&pdev->dev);
> Remove operations can't meaningfully fail, better to just log the error
> and carry on.
    Will prepare a patch based on your review comments and post it as V2 version.
