From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 07/14] ASoC: qcom: add no osr clk flag to lpass variant
Date: Tue, 05 May 2015 08:17:34 +0100
Message-ID: <55486E8E.8010105@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <1430414244-11168-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235800.GC27804@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150502235800.GC27804@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 03/05/15 00:58, Kenneth Westfield wrote:
> On Thu, Apr 30, 2015 at 06:17:24PM +0100, Srinivas Kandagatla wrote:
>> Some LPASS integrations like on APQ8016 do not have OSR clk, so adding
>> no osr clk bit would allow such integrations to use lpass driver.
>
> Going forward, as the code is generalized, perhaps having an enable flag
> for each clock, rather than a flag that negates an existing clock?
> Or checking that the clock pointer is NULL after probing would be the
> indication?
Mark also suggested the same thing, I will fix it in next version.

--srini
