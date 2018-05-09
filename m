From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v7 11/24] ASoC: qdsp6: q6afe: Add support
	to MI2S ports
Date: Wed, 9 May 2018 07:05:11 +0100
Message-ID: <3e8b4622-81b9-2091-dfd9-22ea035a8b52@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-12-srinivas.kandagatla@linaro.org>
 <2d1e7dfd-b65a-4297-f98b-15c2dd54c61a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DAE72672AF
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 08:05:13 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id j5-v6so25337958wme.5
 for <alsa-devel@alsa-project.org>; Tue, 08 May 2018 23:05:13 -0700 (PDT)
In-Reply-To: <2d1e7dfd-b65a-4297-f98b-15c2dd54c61a@codeaurora.org>
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
To: Banajit Goswami <bgoswami@codeaurora.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Banajit for review!

On 09/05/18 04:21, Banajit Goswami wrote:
> 
> On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
>> This patch adds support to 4 MI2S ports on LPASS.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6afe.c | 224 
>> +++++++++++++++++++++++++++++++++++++++++++
>>   sound/soc/qcom/qdsp6/q6afe.h |  13 +++
>>   2 files changed, 237 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
>> index be55b3ab045f..ceb18aaa5af4 100644
>> --- a/sound/soc/qcom/qdsp6/q6afe.c
>> +++ b/sound/soc/qcom/qdsp6/q6afe.c
>> @@ -14,6 +14,10 @@
>>   #include <linux/spinlock.h>
>>   #include <linux/delay.h>
>>   #include <linux/soc/qcom/apr.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dai.h>
>> +#include <sound/pcm.h>
> <snip>
> 
>>   union afe_port_config {
>>       struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
>>       struct afe_param_id_slimbus_cfg           slim_cfg;
>> +    struct afe_param_id_i2s_cfg    i2s_cfg;
>>   } __packed;
>>   struct q6afe_port {
>> @@ -210,6 +264,22 @@ static struct afe_port_map 
>> port_maps[AFE_PORT_MAX] = {
>>                   SLIMBUS_4_RX, 1, 1},
>>       [SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
>>                   SLIMBUS_5_RX, 1, 1},
>> +    [QUATERNARY_MI2S_RX] = { AFE_PORT_ID_QUATERNARY_MI2S_RX,
>> +                QUATERNARY_MI2S_RX, 1, 1},
>> +    [QUATERNARY_MI2S_TX] = { AFE_PORT_ID_QUATERNARY_MI2S_TX,
>> +                QUATERNARY_MI2S_TX, 0, 1},
>> +    [SECONDARY_MI2S_RX] = { AFE_PORT_ID_SECONDARY_MI2S_RX,
>> +                SECONDARY_MI2S_RX, 1, 1},
>> +    [SECONDARY_MI2S_TX] = { AFE_PORT_ID_SECONDARY_MI2S_TX,
>> +                SECONDARY_MI2S_TX, 0, 1},
>> +    [TERTIARY_MI2S_RX] = { AFE_PORT_ID_TERTIARY_MI2S_RX,
>> +                TERTIARY_MI2S_RX, 1, 1},
>> +    [TERTIARY_MI2S_TX] = { AFE_PORT_ID_TERTIARY_MI2S_TX,
>> +                TERTIARY_MI2S_TX, 0, 1},
>> +    [PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
>> +                PRIMARY_MI2S_RX, 1, 1},
>> +    [PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
>> +                PRIMARY_MI2S_RX, 0, 1},
> Can these be added after SLIMBUS_6_RX?
> Also, for better arrangement, please add the port_maps from 
> PRIMARY_MI2S_RX to QUATERNARY_MI2S_TX in the same sequence of definition 
> of AFE ports.
> Otherwise LGTM.
Yep, I have reordered this now!

> Once fixed the above comment add-
> Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
> 
