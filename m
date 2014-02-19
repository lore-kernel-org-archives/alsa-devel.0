From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: sst-acpi: Request
 firmware before SST platform driver probing
Date: Wed, 19 Feb 2014 09:28:39 +0200
Message-ID: <53045D27.4060803@linux.intel.com>
References: <1392734523-5109-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1392734523-5109-2-git-send-email-jarkko.nikula@linux.intel.com>
 <s5h38jgxybf.wl%tiwai@suse.de> <530455F1.5000309@linux.intel.com>
 <s5hvbwby3np.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C4D2610D7
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 08:28:43 +0100 (CET)
In-Reply-To: <s5hvbwby3np.wl%tiwai@suse.de>
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

On 02/19/2014 09:15 AM, Takashi Iwai wrote:
> At Wed, 19 Feb 2014 08:57:53 +0200,
> Jarkko Nikula wrote:
>>
>> I felt it was needless to test NULL pointers here since release_firmware
>> checks it directly and platform_device_unregister indirectly. Not in
>> platform_device_unregister but when calling platform_device_del and
>> platform_device_put there.
> The problem is that it may contain ERR_PTR(xxx).  You have to either
> clear to NULL in
>
> 	if (IS_ERR(sst_acpi->pdev_pcm)) {
> 		dev_err(dev, "Cannot register device %s. Error %d\n",
> 			desc->drv_name, (int)PTR_ERR(sst_acpi->pdev_pcm));
> 		sst_acpi->pdev_pcm = NULL;
> 	}
>
> or check conditionally like
>
> 	if (!IS_ERR_OR_NULL(sst_acpi->pdev_pcm))
> 	 	platform_device_unregister(sst_acpi->pdev_pcm);
> 	
> Maybe the former is better.
>
Oh yes and I'm even testing it with the IS_ERR and PTR_ERR. Why that 
knowledge did not carry to sst_acpi_remove... will fix.

-- 
Jarkko
