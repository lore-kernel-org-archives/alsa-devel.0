From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH RFC 03/15] ASoC: qcom: rename
 rdmactl_audif_start to dmactrl_audif_start
Date: Wed, 3 Feb 2016 08:48:29 +0000
Message-ID: <56B1BEDD.1010000@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454347708-10446-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160203003547.GD14436@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 7485C261569
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 09:48:31 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id l66so59123925wml.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Feb 2016 00:48:31 -0800 (PST)
In-Reply-To: <20160203003547.GD14436@kwestfie-linux.qualcomm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 03/02/16 00:35, Kenneth Westfield wrote:
> On Mon, Feb 01, 2016 at 09:28:28AM -0800, Srinivas Kandagatla wrote:
>> diff --git a/sound/soc/qcom/lpass-platform.c
>> b/sound/soc/qcom/lpass-platform.c
>> index a6dce1b..bfc9de6 100644
>> --- a/sound/soc/qcom/lpass-platform.c
>> +++ b/sound/soc/qcom/lpass-platform.c
>> @@ -91,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct
>> snd_pcm_substream *substream,
>>   	unsigned int channels = params_channels(params);
>>   	unsigned int regval;
>>   	int bitwidth;
>> -	int ret, rdma_port = pcm_data->i2s_port + v->rdmactl_audif_start;
>> +	int ret, rdma_port = pcm_data->i2s_port + v->dmactl_audif_start;
>
> I was wondering why rdma_port had not been changed as well, until I saw
> that in a later patch.  Would it make sense to combine all changes
> related to removing read-only indications from identifiers to one patch?

Yep, I will see if I can merge this and also I need to fix the ordering, 
I got same report from 0day testing too.

>
