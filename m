From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 11/14] ASoC: wcd9335: add mbhc support
Date: Wed, 26 Sep 2018 11:56:01 +0100
Message-ID: <ec360aa8-d32d-b391-ce50-abddf2705e3e@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-12-srinivas.kandagatla@linaro.org>
 <8582abce-b1c8-24fc-7db2-b7101a6e1362@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B680F267730
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 12:56:03 +0200 (CEST)
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so1811973wmi.3
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 03:56:03 -0700 (PDT)
In-Reply-To: <8582abce-b1c8-24fc-7db2-b7101a6e1362@codeaurora.org>
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
To: Banajit Goswami <bgoswami@codeaurora.org>, lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org



On 26/09/18 10:31, Banajit Goswami wrote:
>> +static irqreturn_t wcd9335_mbhc_sw_irq(int irq, void *data)
> Are we supporting only headset and headphone detection for now ? 
> Extension cable and electrical detection will be supported later ?
> And how about cases for slow insertion scenarios ?
> 
I can not test extension cable and Other features like electrical 
detection will be added in future if we need it!

--srini
>> +{
>> +    struct wcd9335_codec *wcd = data;
