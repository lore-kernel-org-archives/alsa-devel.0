From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 14/25] ASoC: qcom: qdsp6: Add support to
 q6afe dai driver
Date: Tue, 20 Feb 2018 09:36:10 +0000
Message-ID: <f5aed3f1-d037-861b-5efd-d6abd8cf7e6e@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
 <84723548-02a4-10e7-3de1-b347416d4fb0@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com
 [209.85.128.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 188C9267096
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 10:36:12 +0100 (CET)
Received: by mail-wr0-f182.google.com with SMTP id u49so7717198wrc.10
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 01:36:12 -0800 (PST)
In-Reply-To: <84723548-02a4-10e7-3de1-b347416d4fb0@codeaurora.org>
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

Thanks for testing this out,

On 19/02/18 10:32, Rohit Kumar wrote:
>>
>> diff --git a/sound/soc/qcom/qdsp6/Makefile 
>> b/sound/soc/qcom/qdsp6/Makefile
>> index 660afcab98fd..c7833842b878 100644
>> --- a/sound/soc/qcom/qdsp6/Makefile
>> +++ b/sound/soc/qcom/qdsp6/Makefile
>> @@ -1,5 +1,5 @@
>>   obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
>> -obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
>> +obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o q6afe-dai.o
> depmod: ERROR: Cycle detected: q6afe -> q6afe_dai -> q6afe
> need to use like:
> +qdsp6_afe-objs := q6afe.o q6afe-dai.o
> +obj-$(CONFIG_SND_SOC_QDSP6_AFE) += qdsp6_afe.o
> similarly for asm and adm


Yep, will fix this in next version,

thanks,
srini
>>   obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o q6routing.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
>> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c 
>> b/sound/soc/qcom/qdsp6/q6afe-dai.c
>> new file mode 100644
>> index 000000000000..f6a618e9db9e 
