From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: Bug in hdmi codec driver in DPCM
Date: Wed, 31 Oct 2018 15:52:19 +0530
Message-ID: <7a44d8f9-ce40-6e13-ee74-fa3f830cb2d5@codeaurora.org>
References: <52692082-70ce-9616-6a0b-4c68ed2c61c0@codeaurora.org>
 <0b77361c-61a0-70a1-e9af-bb16ff3c6eb6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 68A6F2675B8
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2018 11:22:27 +0100 (CET)
In-Reply-To: <0b77361c-61a0-70a1-e9af-bb16ff3c6eb6@codeaurora.org>
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
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org, asishb@codeaurora.org
List-Id: alsa-devel@alsa-project.org


On 10/31/2018 3:55 AM, Patrick Lai wrote:
> On 10/30/18 7:50 AM, Rohit Kumar wrote:
>> Hi,
>>
>> We are facing crash in hdmi codec driver when we use DPCM based 
>> dai-links. Crash is happening in hdmi_codec_eld_chmap() while 
>> accessing chmap_info struct during hdmi_codec_startup(). However, 
>> chmap_info struct is allocated in hdmi_codec_pcm_new() which is only 
>> called in non-DPCM based dai-links.
>>
>> Below is the crash stack:
>>
>> [61.635493] Unable to handle kernel NULL pointer dereference at 
>> virtual address 00000018
>>
>> .....
>>
>> [61.666696]CM = 0, WnR = 1
>>
>> [61.669778] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffc0d6633000
>>
>> [61.676526] [0000000000000018] *pgd=0000000153fc8003, 
>> *pud=0000000153fc8003, *pmd=0000000000000000
>>
>> [61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP
>>
>> [61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21
>>
>> ..
>>
>> [61.740269] PC is at hdmi_codec_startup+0x124/0x164
>>
>> [61.745308] LR is at hdmi_codec_startup+0xe4/0x164
>>
>> ..
>>
>> We would probably need to move the implementation on pcm_new() to 
>> some other function to make it compatible with DPCM.
>>
>> Can you please provide suggestions in solving the issue.
>>
> In my opinion, it is not responsibility of driver to speculate whether
> the ops it exposes would only be called under certain usage (non-DPCM in
> this case). I think ASoC framework should be updated to call pcm_new()
> of each driver even though no actual PCM device would be created for
> backend dailink.
>
Thanks Patrick for the response. In that case, we should avoid no_pcm
check before calling pcm_new() in soc_link_dai_pcm_new().
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/soc-core.c?h=v4.19#n1413

Mark, Can you please provide your opinion for the same.
>>
>> Thanks,
>>
>> Rohit
>
>

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.
