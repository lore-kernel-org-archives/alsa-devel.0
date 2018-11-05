From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: core: Invoke pcm_new() for all
 DAI-link
Date: Mon, 5 Nov 2018 23:44:44 +0530
Message-ID: <3616f01f-6a00-6eb1-0bdd-f161b7ce15e6@codeaurora.org>
References: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
 <s5htvl0exil.wl-tiwai@suse.de>
 <48c78f67-8178-2d07-e35d-2e4eca51ccbc@codeaurora.org>
 <791d4587-4db3-3ffa-331a-f79d0993ca8c@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <791d4587-4db3-3ffa-331a-f79d0993ca8c@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Takashi Iwai <tiwai@suse.de>, olivier.moysan@st.com
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Hello Arnaud,


On 11/5/2018 4:43 PM, Arnaud Pouliquen wrote:
> Hello Rohit,
>
> On 11/2/18 1:06 PM, Rohit Kumar wrote:
>> On 11/2/2018 1:12 PM, Takashi Iwai wrote:
>>> On Thu, 01 Nov 2018 13:38:49 +0100,
>>> Rohit kumar wrote:
>>>> Remove no_pcm check to invoke pcm_new() for backend dai-links
>>>> too. This fixes crash in hdmi codec driver during hdmi_codec_startup()
>>>> while accessing chmap_info struct. chmap_info struct memory is
>>>> allocated in pcm_new() of hdmi codec driver which is not invoked
>>>> in case of DPCM when hdmi codec driver is part of backend dai-link.
>>>>
>>>> Below is the crash stack:
>>>>
>>>> [   61.635493] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000018
>>>> ..
>>>> [   61.666696]   CM = 0, WnR = 1
>>>> [   61.669778] user pgtable: 4k pages, 39-bit VAs, pgd =
>>>> ffffffc0d6633000
>>>> [   61.676526] [0000000000000018] *pgd=0000000153fc8003,
>>>> *pud=0000000153fc8003, *pmd=0000000000000000
>>>> [   61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP
>>>> [   61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21
>>>> ..
>>>> [   61.740269] PC is at hdmi_codec_startup+0x124/0x164
>>>> [   61.745308] LR is at hdmi_codec_startup+0xe4/0x164
>>>>
>>>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>>> Did you check whether all drivers have no side-effect by this change?
>>> The hdmi-codec isn't the only driver that has pcm_new ops, so we have
>>> to make sure that such a fundamental change wouldn't bring any
>>> regressions.
>>>
>> Below are the drivers calling pcm_new() other than hdmi codec driver.
>> sound/soc/meson/axg-frddr.c
>> sound/soc/meson/axg-toddr.c
>> These two drivers are frontend DAI drivers and should not be impacted
>> because of this.
>>
>> Other than this, pcm_new() is called from sound/soc/stm/stm32_sai_sub.c
>> I could not get much info about this driver. However, it is just adding
>> kcontrols in pcm_new() which uses internal private structs in get()/put().
>> Olivier Moysan can too confirm on this.
> First, i'm answering  for Olivier: no regression identified for the SAI
> driver, it is not a DPCM driver.
>
> Then i have a concern about the call of pcm_new for a no-PCM backend.
> Does it make sense? In DPCM concept, the backend is not linked to the
> PCM device...
>
> Instead, I would suggest that you add protection in HDMI_codec on
> chmap_info pointer.
>
> The drawback would be that the control is no more available...do you
> need it?
I don't need chmap_info, but ELD kcontrol is also defined in pcm_new() which
we need. We should probably update the driver to make it compatible with
DPCM. Any suggestions?
> Regards
> Arnaud
>
>> Thanks,
>> Rohit
>>> thanks,
>>>
>>> Takashi
Thanks,
Rohit

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.
