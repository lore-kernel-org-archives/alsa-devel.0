From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 05/11] ASoC: qdsp6: q6asm: use
 of_platform_populate/depopulate()
Date: Tue, 26 Jun 2018 09:52:23 +0100
Message-ID: <b5a41a84-162b-62dd-271c-066e42370a3e@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-6-srinivas.kandagatla@linaro.org>
 <20180625180159.GD10876@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D8772676B4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 10:52:26 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id c13-v6so6405927wrq.2
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 01:52:26 -0700 (PDT)
In-Reply-To: <20180625180159.GD10876@centauri.lan>
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
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 25/06/18 19:01, Niklas Cassel wrote:
> On Mon, Jun 25, 2018 at 03:31:09PM +0100, Srinivas Kandagatla wrote:
>> Now that the child nodes have there own compatible strings,
>> Use of_platform_populate/depopulate() instead of less common
>> of_platform_device_create()/destroy().
>>
>> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6asm.c | 17 ++---------------
>>   1 file changed, 2 insertions(+), 15 deletions(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
>> index 530852385cad..2b2c7233bb5f 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm.c
>> +++ b/sound/soc/qcom/qdsp6/q6asm.c
>> @@ -174,10 +174,8 @@ struct q6asm {
>>   	struct device *dev;
>>   	struct q6core_svc_api_info ainfo;
>>   	wait_queue_head_t mem_wait;
>> -	struct platform_device *pcmdev;
> Why is this removed?
> If it's a cleanup, perhaps it should be in a separate patch.
Thanks, I will move this to a separate patch.
--srini
> 
