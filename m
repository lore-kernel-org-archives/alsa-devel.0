From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: sst-acpi: Request
 firmware before SST platform driver probing
Date: Wed, 19 Feb 2014 08:57:53 +0200
Message-ID: <530455F1.5000309@linux.intel.com>
References: <1392734523-5109-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1392734523-5109-2-git-send-email-jarkko.nikula@linux.intel.com>
 <s5h38jgxybf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D1E872652C1
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 07:57:58 +0100 (CET)
In-Reply-To: <s5h38jgxybf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 02/18/2014 04:58 PM, Takashi Iwai wrote:
> At Tue, 18 Feb 2014 16:42:03 +0200,
> Jarkko Nikula wrote:
>>   
>> -sst_err:
>> -	platform_device_unregister(sst_acpi->pdev_pcm);
>> -	return ret;
>> +	/* continue SST probing after firmware is loaded */
>> +	return request_firmware_nowait(THIS_MODULE, true, desc->fw_filename,
>> +				       dev, GFP_KERNEL, pdev, sst_acpi_fw_cb);
> sst_acpi->pdev_mach still should be unregistered when
> request_firmware_nowait() returns an error.
I was thinking to leave that for sst_acpi_remove but you are right, it 
doesn't make sense to leave it registered for instance if 
request_firmware_nowait fails because of -ENOMEM or some other fatal issue.

>>   }
>>   
>>   static int sst_acpi_remove(struct platform_device *pdev)
>>   {
>>   	struct sst_acpi_priv *sst_acpi = platform_get_drvdata(pdev);
>> +	struct sst_pdata *sst_pdata = &sst_acpi->sst_pdata;
>>   
>>   	platform_device_unregister(sst_acpi->pdev_mach);
>>   	platform_device_unregister(sst_acpi->pdev_pcm);
> With your patch, pdev_pcm isn't always a valid pointer.  You can't
> pass it unconditionally any longer.
>
I felt it was needless to test NULL pointers here since release_firmware 
checks it directly and platform_device_unregister indirectly. Not in 
platform_device_unregister but when calling platform_device_del and 
platform_device_put there.

-- 
Jarkko
