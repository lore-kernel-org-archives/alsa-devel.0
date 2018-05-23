From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim
	ngd dt bindings
Date: Wed, 23 May 2018 19:11:45 +0100
Message-ID: <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
 <20180523164023.GA24671@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ABA8266C1C
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 20:11:47 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id j4-v6so11463313wme.1
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 11:11:47 -0700 (PDT)
In-Reply-To: <20180523164023.GA24671@rob-hp-laptop>
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
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, girishm@quicinc.com, gregkh@linuxfoundation.org, broonie@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, kramasub@codeaurora.org, linux-arm-msm@vger.kernel.org, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org



On 23/05/18 17:40, Rob Herring wrote:
>> +
>> +- qcom,ngd-id
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: ngd instance id in the controller
> Why do you need this?
> 
Please ignore my comment from previous reply.

There are more than one instances of ngd in this slim controller.
We need this to make sure we are programming the correct one.

We also need this instance ID during powering it up using QMI.


thanks,
srini
