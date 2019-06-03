From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH] ALSA: pcm: Check for integer overflow
 during multiplication
Date: Sun, 2 Jun 2019 21:43:41 -0700
Message-ID: <ef3f8ccc-8e0e-b8d9-38ca-350621905dea@codeaurora.org>
References: <1559021223-28674-1-git-send-email-bgoswami@codeaurora.org>
 <s5hftoz870o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C564F80774
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 06:43:57 +0200 (CEST)
In-Reply-To: <s5hftoz870o.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, Phani Kumar Uppalapati <phaniu@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Thanks Takashi for the review!

On 5/27/2019 10:47 PM, Takashi Iwai wrote:
> On Tue, 28 May 2019 07:27:03 +0200,
> <bgoswami@codeaurora.org> wrote:
>> From: Phani Kumar Uppalapati <phaniu@codeaurora.org>
>>
>> Channel info data structure is parsed from userspace and if
>> the number of channels is not set correctly, it could lead
>> to integer overflow when the number of channels is multiplied
>> with pcm bit width. Add a condition to check for integer
>> overflow during the multiplication operationi, and return error
>> if overflow detected.
>>
>> Signed-off-by: Phani Kumar Uppalapati <phaniu@codeaurora.org>
>> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
> Did you really hit this?

This was reported by static analysis tool.

I will take your feedback, and re-look at the issue, to see if this 
issue can happen.

> The info->channel value is already checked in snd_pcm_channel_info()
> before calling the ioctl ops, to the upper bound runtime->channels.
> So it shouldn't overflow at the point you suggested.
>
>
> thanks,
>
> Takashi

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
