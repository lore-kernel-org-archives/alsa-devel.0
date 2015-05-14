From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [RFC PATCH 00/14] ASoC: qcom: add support to apq8016
 audio
Date: Thu, 14 May 2015 08:55:30 +0100
Message-ID: <555454F2.1020200@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235704.GA27804@kwestfie-linux.qualcomm.com> <20150506054758.GD5639@kwestfie-linux.qualcomm.com> <5549BA98.9080501@linaro.org> <20150512040600.GA24087@kwestfie-linux.qualcomm.com> <5551D436.2070600@linaro.org> <555232B3.3090205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <555232B3.3090205@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 12/05/15 18:04, Lars-Peter Clausen wrote:
>>
>> Its not clear from code, why should we enter to legacy naming if the dais
>> count == 1 even-though the dai_drv has has valid name and id information.
>>
>> Mark/Lars,
>>
>> I can workaround this by using dai->driver->id in the driver, But do you
>> think that dai name and id should be assigned from dai drv if present?
>
> I think it should be OK to extend that if condition to
>
> if (count == 1 && dai_drv[0].id == 0 && legacy_dai_naming) ...
>
> It doesn't look like any of the systems for which we currently take the
> legacy path do set id to non 0. And the less new systems following
> legacy naming scheme the better.
>
Thanks Lars, will send out an RFC patch and see what other people thing.

--srini
> - Lars
