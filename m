From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 3/3] ASoC: qcom: fix STORM board Kconfig
Date: Tue, 26 May 2015 07:58:51 +0100
Message-ID: <556419AB.2010501@linaro.org>
References: <1432309956-5228-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432310057-5358-1-git-send-email-srinivas.kandagatla@linaro.org>
 <11006188.h6ZK0CVLeu@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B3D6526065A
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 08:58:55 +0200 (CEST)
Received: by wgez8 with SMTP id z8so88030846wge.0
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 23:58:55 -0700 (PDT)
In-Reply-To: <11006188.h6ZK0CVLeu@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 22/05/15 17:33, Arnd Bergmann wrote:
> On Friday 22 May 2015 16:54:17 Srinivas Kandagatla wrote:
>> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
>> index 6ecac6c..f50197e 100644
>> --- a/sound/soc/qcom/Kconfig
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -26,7 +26,7 @@ config SND_SOC_LPASS_APQ8016
>>
>>   config SND_SOC_STORM
>>          tristate "ASoC I2S support for Storm boards"
>> -       depends on (ARCH_QCOM && SND_SOC_QCOM) || COMPILE_TEST
>> +       depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
>>          select SND_SOC_LPASS_IPQ806X
>>          select SND_SOC_MAX98357A
>>          help
>> --
>
> Do you still have the problem that you are selecting another symbol
> that 'depends on OF', but this one does not have that dependency,
> or did you drop that patch now before it could get picked up?

Yes, I dropped the OF dependency patch, as these drivers could be 
compile tested.

--srini

>
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
