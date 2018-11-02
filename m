From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: core: Invoke pcm_new() for all
 DAI-link
Date: Fri, 2 Nov 2018 17:36:49 +0530
Message-ID: <48c78f67-8178-2d07-e35d-2e4eca51ccbc@codeaurora.org>
References: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
 <s5htvl0exil.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htvl0exil.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, olivier.moysan@st.com
Cc: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


On 11/2/2018 1:12 PM, Takashi Iwai wrote:
> On Thu, 01 Nov 2018 13:38:49 +0100,
> Rohit kumar wrote:
>> Remove no_pcm check to invoke pcm_new() for backend dai-links
>> too. This fixes crash in hdmi codec driver during hdmi_codec_startup()
>> while accessing chmap_info struct. chmap_info struct memory is
>> allocated in pcm_new() of hdmi codec driver which is not invoked
>> in case of DPCM when hdmi codec driver is part of backend dai-link.
>>
>> Below is the crash stack:
>>
>> [   61.635493] Unable to handle kernel NULL pointer dereference at virtual address 00000018
>> ..
>> [   61.666696]   CM = 0, WnR = 1
>> [   61.669778] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffc0d6633000
>> [   61.676526] [0000000000000018] *pgd=0000000153fc8003, *pud=0000000153fc8003, *pmd=0000000000000000
>> [   61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP
>> [   61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21
>> ..
>> [   61.740269] PC is at hdmi_codec_startup+0x124/0x164
>> [   61.745308] LR is at hdmi_codec_startup+0xe4/0x164
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Did you check whether all drivers have no side-effect by this change?
> The hdmi-codec isn't the only driver that has pcm_new ops, so we have
> to make sure that such a fundamental change wouldn't bring any
> regressions.
>
Below are the drivers calling pcm_new() other than hdmi codec driver.
sound/soc/meson/axg-frddr.c
sound/soc/meson/axg-toddr.c
These two drivers are frontend DAI drivers and should not be impacted
because of this.

Other than this, pcm_new() is called from sound/soc/stm/stm32_sai_sub.c
I could not get much info about this driver. However, it is just adding
kcontrols in pcm_new() which uses internal private structs in get()/put().
Olivier Moysan can too confirm on this.

Thanks,
Rohit
> thanks,
>
> Takashi

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.
