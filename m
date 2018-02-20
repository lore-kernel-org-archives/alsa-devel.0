From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to
 Q6AFE
Date: Tue, 20 Feb 2018 09:34:39 +0000
Message-ID: <2360f3a9-f207-bc84-b0da-2675b7c9f0e0@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com
 [209.85.128.173])
 by alsa0.perex.cz (Postfix) with ESMTP id EE095267096
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 10:34:41 +0100 (CET)
Received: by mail-wr0-f173.google.com with SMTP id v65so12324603wrc.11
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 01:34:41 -0800 (PST)
In-Reply-To: <2465335e-4d45-02d7-2e64-0a1c28a44ff1@codeaurora.org>
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
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Thanks for your review comments



On 19/02/18 10:30, Rohit Kumar wrote:
>> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
>> index d5280355c24f..748f5e891dcf 100644
>> --- a/sound/soc/qcom/Makefile
>> +++ b/sound/soc/qcom/Makefile
>> @@ -13,6 +13,11 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += 
>> snd-soc-lpass-apq8016.o
>>   # Machine
>>   snd-soc-storm-objs := storm.o
>>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>> +snd-soc-msm8996-objs := apq8096.o
> This needs to be moved out of this patch

Will fix it in next version.

>>   obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>> +obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-msm8996.o
>> +
>> +#DSP lib 
