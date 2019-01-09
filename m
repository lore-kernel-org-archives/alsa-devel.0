From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH 2/2] ASoC: qcom: defer probe if platform dai is not
 registered
Date: Wed, 9 Jan 2019 14:05:10 +0530
Message-ID: <b8e7daaa-d3dd-380c-fb37-d4867be76b5d@codeaurora.org>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
 <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
 <20190107182757.GS9570@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107182757.GS9570@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Thanks Mark for review.

On 1/7/2019 11:57 PM, Mark Brown wrote:
> On Mon, Dec 24, 2018 at 02:32:13PM +0530, Rohit kumar wrote:
>> From: Ajit Pandey <ajitp@codeaurora.org>
>>
>> Platform DAI component probe is not called if it is not
>> present in component list during sound card registration.
>> Check if component is registered for platform dai before
>> soundcard registration.
> Why do we need to do this in the driver, I'd expect this to be something
> that we need to do for everything not just this driver so I'd expect it
> to be handled in the core?
True. Will post generic change which will not need change in machine driver.

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.
