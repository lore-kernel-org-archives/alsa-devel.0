From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH v2] ALSA: x86: fix error return code in
 hdmi_lpe_audio_probe()
Date: Fri, 30 Jun 2017 15:31:32 -0500
Message-ID: <20170630153132.Horde.yKnCrx-eIdMDEfUpCJ07mLx@gator4166.hostgator.com>
References: <20170630151244.Horde.nPNra38wHbiLkXMM9mTTsxB@gator4166.hostgator.com>
 <20170630201841.GA8057@embeddedgus> <s5hy3s943xj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy3s943xj.wl-tiwai@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Quoting Takashi Iwai <tiwai@suse.de>:

> On Fri, 30 Jun 2017 22:18:41 +0200,
> Gustavo A. R. Silva wrote:
>>
>> Also,
>> notice that platform_get_irq() no longer returns 0 on error.
>
> There is no change by your patch in this regard, right?
>

You are correct. I just pointing it out. This is the commit that  
changed the platform_get_irq code:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

>
> Takashi
>
>> Print error message and propagate the return value of platform_get_irq
>> on failure.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>> Changes in v2:
>>  Fix error in commit message.
>>
>>  sound/x86/intel_hdmi_audio.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
>> index c19efc9..a095150 100644
>> --- a/sound/x86/intel_hdmi_audio.c
>> +++ b/sound/x86/intel_hdmi_audio.c
>> @@ -1758,8 +1758,8 @@ static int hdmi_lpe_audio_probe(struct  
>> platform_device *pdev)
>>  	/* get resources */
>>  	irq = platform_get_irq(pdev, 0);
>>  	if (irq < 0) {
>> -		dev_err(&pdev->dev, "Could not get irq resource\n");
>> -		return -ENODEV;
>> +		dev_err(&pdev->dev, "Could not get irq resource: %d\n", irq);
>> +		return irq;
>>  	}
>>
>>  	res_mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> --
>> 2.5.0
>>
>>

Thanks
--
Gustavo A. R. Silva
