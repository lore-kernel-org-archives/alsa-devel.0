From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [RFC PATCH 00/14] ASoC: qcom: add support to apq8016
 audio
Date: Tue, 12 May 2015 19:04:51 +0200
Message-ID: <555232B3.3090205@metafoo.de>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org> <20150502235704.GA27804@kwestfie-linux.qualcomm.com> <20150506054758.GD5639@kwestfie-linux.qualcomm.com> <5549BA98.9080501@linaro.org> <20150512040600.GA24087@kwestfie-linux.qualcomm.com> <5551D436.2070600@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5551D436.2070600@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 05/12/2015 12:21 PM, Srinivas Kandagatla wrote:
> + adding Lars
>
> On 12/05/15 05:06, Kenneth Westfield wrote:
>> Srinivas,
>>
>> I was able to get audio working on the Storm board.  There were several
>> issues.  First, the I2S control port was saved in the DAI driver id field
>> (which was 4), but the DAI id field was used by the macro (which was 0).
>> The patch below fixed it:
>
> Ah, I did not expect that to happen, dai->id and dai->driver->id should be
> same. Surprisingly this is not true for IPQ806x platform only because dais
> count == 1. Which results in dai->id not getting assigned to dai->driver->id
> due to below code snippet in  sound/soc/soc-core.c
>
> --------------------><------------------------------------------
> /*
>   * Back in the old days when we still had component-less DAIs,
>   * instead of having a static name, component-less DAIs would
>   * inherit the name of the parent device so it is possible to
>   * register multiple instances of the DAI. We still need to keep
>   * the same naming style even though those DAIs are not
>   * component-less anymore.
>   */
> if (count == 1 && legacy_dai_naming) {
>      dai->name = fmt_single_name(dev, &dai->id);
> } else {
>      dai->name = fmt_multiple_name(dev, &dai_drv[i]);
>      if (dai_drv[i].id)
>          dai->id = dai_drv[i].id;
>      else
>          dai->id = i;
> }
> --------------------><------------------------------------------
>
> Its not clear from code, why should we enter to legacy naming if the dais
> count == 1 even-though the dai_drv has has valid name and id information.
>
> Mark/Lars,
>
> I can workaround this by using dai->driver->id in the driver, But do you
> think that dai name and id should be assigned from dai drv if present?

I think it should be OK to extend that if condition to

if (count == 1 && dai_drv[0].id == 0 && legacy_dai_naming) ...

It doesn't look like any of the systems for which we currently take the 
legacy path do set id to non 0. And the less new systems following legacy 
naming scheme the better.

- Lars
