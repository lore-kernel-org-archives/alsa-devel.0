From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH RFC 07/15] ASoC: qcom: add mic related i2s
 control register defines
Date: Wed, 3 Feb 2016 08:48:40 +0000
Message-ID: <56B1BEE8.9060808@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347735-10654-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160203003638.GH14436@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203003638.GH14436@kwestfie-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 03/02/16 00:36, Kenneth Westfield wrote:
> On Mon, Feb 01, 2016 at 09:28:55AM -0800, Srinivas Kandagatla wrote:
>> diff --git a/sound/soc/qcom/lpass-lpaif-reg.h
>> b/sound/soc/qcom/lpass-lpaif-reg.h
>> index 95e22f1..8a64d1a 100644
>> --- a/sound/soc/qcom/lpass-lpaif-reg.h
>> +++ b/sound/soc/qcom/lpass-lpaif-reg.h
>> @@ -47,6 +47,28 @@
>
> ...
>
>> +#define LPAIF_I2SCTL_MICMODE_MASK	GENMASK(7, 4)
>> +#define LPAIF_I2SCTL_MICMODE_SHIFT	4
>> +#define LPAIF_I2SCTL_MICMODE_NONE	(0 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_SD0	(1 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_SD1	(2 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_SD2	(3 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_SD3	(4 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_QUAD01	(5 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_QUAD02	(6 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_6CH	(7 << LPAIF_I2SCTL_MICMODE_SHIFT)
>> +#define LPAIF_I2SCTL_MICMODE_8CH	(8 << LPAIF_I2SCTL_MICMODE_SHIFT)
>
> LPAIF_I2SCTL_MICMODE_QUAD02 should be LPAIF_I2SCTL_MICMODE_QUAD23, as
> the suffix numbers refer to SD[0-3].
Ok, will fix this in next version.
>
