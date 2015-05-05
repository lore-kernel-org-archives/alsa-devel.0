From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 07/14] ASoC: qcom: add no osr clk flag to lpass variant
Date: Tue, 05 May 2015 08:16:50 +0100
Message-ID: <55486E62.80006@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <1430414244-11168-1-git-send-email-srinivas.kandagatla@linaro.org> <20150504122619.GS15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150504122619.GS15510@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 04/05/15 13:26, Mark Brown wrote:
> On Thu, Apr 30, 2015 at 06:17:24PM +0100, Srinivas Kandagatla wrote:
>
>> +	if (!drvdata->variant->no_osr_clk) {
>> +		ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->id]);
>
> Can we do this by checking to see if the clock is set to IS_ERR()
> instead?  That's what we're doing elsewhere for possibly optional
> clocks.
>
Yes, I think that should be possible, I will fix it in next version.

--srini
