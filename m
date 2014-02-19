From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: sst-acpi: Request
 firmware before SST platform driver probing
Date: Wed, 19 Feb 2014 09:09:57 +0200
Message-ID: <530458C5.9070603@linux.intel.com>
References: <1392734523-5109-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1392734523-5109-2-git-send-email-jarkko.nikula@linux.intel.com>
 <s5h38jgxybf.wl%tiwai@suse.de> <530455F1.5000309@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A082226558D
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 08:10:07 +0100 (CET)
In-Reply-To: <530455F1.5000309@linux.intel.com>
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

On 02/19/2014 08:57 AM, Jarkko Nikula wrote:
> Hi
>
> On 02/18/2014 04:58 PM, Takashi Iwai wrote:
>> At Tue, 18 Feb 2014 16:42:03 +0200,
>> Jarkko Nikula wrote:
>>>   -sst_err:
>>> -    platform_device_unregister(sst_acpi->pdev_pcm);
>>> -    return ret;
>>> +    /* continue SST probing after firmware is loaded */
>>> +    return request_firmware_nowait(THIS_MODULE, true, 
>>> desc->fw_filename,
>>> +                       dev, GFP_KERNEL, pdev, sst_acpi_fw_cb);
>> sst_acpi->pdev_mach still should be unregistered when
>> request_firmware_nowait() returns an error.
> I was thinking to leave that for sst_acpi_remove but you are right, it 
> doesn't make sense to leave it registered for instance if 
> request_firmware_nowait fails because of -ENOMEM or some other fatal 
> issue.
>
Answering myself after cup of coffee... Obviously probe function must 
free whatever it allocated when it returns with an error. In other words 
module loading fails and we won't ever call the remove function.

-- 
Jarkko
