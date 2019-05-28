From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH] ASoC: Add a debug log to track DAPM widget
	power up/down
Date: Mon, 27 May 2019 18:15:20 -0700
Message-ID: <e65750b3-1fa6-e982-e695-4566f5e51e0c@codeaurora.org>
References: <1558684467-11333-1-git-send-email-bgoswami@codeaurora.org>
 <20190524112931.GB2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3F2CF8072E
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 03:15:24 +0200 (CEST)
In-Reply-To: <20190524112931.GB2456@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Thanks Mark for the review!

On 5/24/2019 4:29 AM, Mark Brown wrote:
> On Fri, May 24, 2019 at 12:54:27AM -0700, bgoswami@codeaurora.org wrote:
>> From: Banajit Goswami <bgoswami@codeaurora.org>
>>
>> Add a debug log to help track widgets being powered-up and powered-down
>> by DAPM.
> We already have huge amounts of trace available via tracepoints and
> having something on by default in the debug logs seems like it's going
> to get very verbose for people who aren't specifically working on audio.
> What's the advantage of adding dev_dbg() logs as well?

Having this debug statement helps collecting logs about DAPM widget power

Up/Down sequence, which helps significantly during debugging. The 
advantage of

having the dev_dbg here are-

1. Do not need to enable trace, which helps collecting logs, without 
much know-how

about audio or kernel

2. Dynamic debug (using /sys/kernel/debug/dynamic_debug) can be enabled for

either just this line of code, or, for the function containing this 
debug statement.

This way, logs can be collected just for the DAPM widget enable/disable, 
and thereby

avoid having the output logs filled with unwanted logs.

3. Though I agree with you about the additional DAPM debug logs being 
present for

someone who may not be specifically working on Audio, based on the number of

widgets in the audio path used, the number of prints should be limited 
to only widget

power on/off.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
