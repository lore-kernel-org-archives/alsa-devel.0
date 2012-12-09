From: Patrick Lai <plai@codeaurora.org>
Subject: Re: [PATCH] ASoC: pcm: allow backend hardware to be freed in pause
 state
Date: Sun, 09 Dec 2012 15:09:34 -0800
Message-ID: <50C51A2E.80209@codeaurora.org>
References: <1354819199-28795-1-git-send-email-plai@codeaurora.org> <20121209152805.GF6511@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20121209152805.GF6511@opensource.wolfsonmicro.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/9/2012 7:28 AM, Mark Brown wrote:
> On Thu, Dec 06, 2012 at 10:39:59AM -0800, Patrick Lai wrote:
>> When front-end PCM session is in paused state, back-end
>> PCM session will be put in paused state as well if given
>> front-end PCM session is the only client of given back-end.
>> Then, application closes front-end PCM session, DPCM
>> framework will not allow back-end enters HW_FREE state
>> so back-end will never get shutdown completely.
>
> I'm not entirely sure what this patch is generated against but it
> doesn't appear to apply to either -next or to v3.7-rc7 - can you check
> and regenerate please?
>

I generated this patch against tag v3.7-rc6. I just did a rebase against 
tag v3.7-rc7. I did not encounter merge error. I will regenerate patch again

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
