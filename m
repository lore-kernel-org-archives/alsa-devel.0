From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
Date: Fri, 22 Jun 2018 16:06:17 +0530
Message-ID: <58db39ee-d2a7-1cdf-c7e2-eea020c8a2c6@codeaurora.org>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
 <20180621123503.GD27187@vkoul-mobl>
 <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 1696A2676B0
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 12:36:24 +0200 (CEST)
In-Reply-To: <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
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
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod <vkoul@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 6/21/2018 8:39 PM, Srinivas Kandagatla wrote:
>
>
> On 21/06/18 13:35, Vinod wrote:
>> And this one is generic DT parsing and seems quite similar to one in 
>> apq8096.c
>> Can we move these into a lib and use them instead of duplicating.
> I totally agree with Vinod, We should probably come up with a library 
> functions something like common.c so that we do not duplicate code.
> This code is going be exactly same for most of the SoCs using qdsp.
>
Sure, I will add a new file, qcom_snd_common.c, which will have these 
common functions and will update apq8096 and sdm845 machine driver to use
APIs exposed by qcom_snd_common.c

> thanks,
> srini
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Regards,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
