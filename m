From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] slimbus: stream: add stream support
Date: Mon, 25 Jun 2018 17:30:48 +0100
Message-ID: <531e49bb-cdc9-610f-1bad-bd40f633e90d@linaro.org>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
 <20180622125050.GO27187@vkoul-mobl>
 <a922d359-2096-48ed-c442-affc5b0c4ccf@linaro.org>
 <20180625162156.GC2404@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D9A42673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 18:30:55 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id p126-v6so10018756wmb.2
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 09:30:55 -0700 (PDT)
In-Reply-To: <20180625162156.GC2404@vkoul-mobl>
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
To: Vinod <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, ctatlor97@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org



On 25/06/18 17:21, Vinod wrote:
>>>> +/*
>>>> + * slim_stream_enable() - Enable a prepared SLIMbus Stream
>>> Do you want to check if it is already prepared ..?
>> Yep, I think most of the code needs similar state machine check, I will add
>> this in next version.
> so if you are tying to snd stream states then I don't think you need a
> state machine here. ALSA already does that for you so you can skip it :D
Stream state machine looks redundant, I will try to skip it and see how 
things look at the end! before sending next version.

thanks,
srini
