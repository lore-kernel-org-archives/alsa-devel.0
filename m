From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
Date: Mon, 9 Jul 2018 17:31:04 +0530
Message-ID: <2110bdcf-96ad-deb5-a5cb-767d7b2e242d@codeaurora.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 9551926739D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jul 2018 14:01:12 +0200 (CEST)
In-Reply-To: <20180709111437.GB16082@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Thanks Mark for reviewing.


On 7/9/2018 4:44 PM, Mark Brown wrote:
> On Fri, Jul 06, 2018 at 03:13:13PM +0530, Rohit kumar wrote:
>
>> @@ -0,0 +1,390 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
> Please make the entire comment block a C++ comment, it makes it look
> more intentional.

Sure, will make this change in next patchset.
>> +static const struct component_master_ops sdm845_ops = {
>> +	.bind = sdm845_bind,
>> +	.unbind = sdm845_unbind,
>> +};
> Why is this using the component stuff rather than the normal support for
> finding the components of audio cards?
>
QCOM soundcard is dependent on platform and cpu dais which gets 
registered only when ADSP is up.
This is the design being followed in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/qcom/apq8096.c?h=v4.18-rc4#n132
We too have the same dependency.
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Thanks,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
