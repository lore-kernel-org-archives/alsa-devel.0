From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH RFC 08/15] ASoC: qcom: add wrdma dma channel
 start
Date: Wed, 3 Feb 2016 08:48:43 +0000
Message-ID: <56B1BEEB.80508@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347741-10696-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160203003656.GI14436@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160203003656.GI14436@kwestfie-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 03/02/16 00:36, Kenneth Westfield wrote:
> On Mon, Feb 01, 2016 at 09:29:01AM -0800, Srinivas Kandagatla wrote:
>> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
>> index 30449f3..8475b60 100644
>> --- a/sound/soc/qcom/lpass.h
>> +++ b/sound/soc/qcom/lpass.h
>> @@ -80,6 +80,7 @@ struct lpass_variant {
>>   	 * at different offset to ipq806x
>>   	 **/
>>   	u32	dmactl_audif_start;
>> +	u32	wrdma_channel_start;
>
> This patch should come before patch 6 (ASoC: qcom: ipq806x: add wrdma
> related register offsets) as that patch references this field.
yes, I need to fix the correct ordering of the patches.

>
