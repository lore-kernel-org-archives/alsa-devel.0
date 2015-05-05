From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 12/14] ASoC: qcom: add apq8016 sound card support
Date: Tue, 05 May 2015 08:17:41 +0100
Message-ID: <55486E95.50509@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <1430414287-11384-1-git-send-email-srinivas.kandagatla@linaro.org> <20150503000154.GF27804@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150503000154.GF27804@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 03/05/15 01:01, Kenneth Westfield wrote:
> On Thu, Apr 30, 2015 at 06:18:07PM +0100, Srinivas Kandagatla wrote:
>> This patch adds apq8016 machine driver support. This patch was tested on
>> two apq8016-sbc and msm8916-mtp board for both hdmi and analog audio
>> features.
>
> apq8016 refers to the SOC, whereas machine drivers are board-specific.
> Better to reference the board (or SOC-Codec combo) instead.

Yes, Initially I started of with apq8016-sbc, but as it also worked for 
mtp, I had to rename it to apq8016.

But you are right, I think renaming it to apq8016-sbc.c and 
msm8916-mtp.c would make sense.


--srini
>
>> ---
>>   sound/soc/qcom/Kconfig   |   9 ++
>>   sound/soc/qcom/Makefile  |   1 +
>>   sound/soc/qcom/apq8016.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 224 insertions(+)
>>   create mode 100644 sound/soc/qcom/apq8016.c
>
>
