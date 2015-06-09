From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 1/2] ASoC: qcom: document apq8016 sbc machine driver
 bindings
Date: Tue, 09 Jun 2015 18:31:33 +0100
Message-ID: <557722F5.7020506@linaro.org>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org> <1433854769-23807-1-git-send-email-srinivas.kandagatla@linaro.org> <20150609165718.GH14071@sirena.org.uk> <55771D88.4050603@linaro.org> <20150609171313.GK14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150609171313.GK14071@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/06/15 18:13, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 06:08:24PM +0100, Srinivas Kandagatla wrote:
>
>>>>> +- external	: flag to indicate if the I2S is connected to external codec
>
>>> not sure I understand why we need a boolean property indicating if an
>>> external CODEC is in use - what is the consequence of setting this
>>> property?
>
>> As of today, the consequence of setting this flag is to setup correct
>> dai_link names.
>> Also there are some limitations on which MI2S can be configured to external
>> or internal codecs, this flag can be used in future to validate such
>> configurations, if required.
>
> That validation sounds like something that the SoC drivers should be
> doing if required rather than the machine driver - otherwise every
> machine driver using this SoC would have to implement the same
> validation.

Thats a valid point, for now I can move to using dai link name property 
instead of external flag, this should work for now. I will add the 
validation logic in SOC driver if required in future.
>
