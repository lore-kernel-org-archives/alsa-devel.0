From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/6] ASoC: dt-bindings: add dt bindings for
 WCD9340/WCD9341 audio codec
Date: Tue, 2 Jul 2019 17:36:47 +0100
Message-ID: <fa816433-71d1-e7ad-7fd9-fcc306c665ff@linaro.org>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
 <20190702080920.22623-2-srinivas.kandagatla@linaro.org>
 <20190702140252.GO2793@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E294F800C1
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 18:36:49 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id f9so18547324wre.12
 for <alsa-devel@alsa-project.org>; Tue, 02 Jul 2019 09:36:49 -0700 (PDT)
In-Reply-To: <20190702140252.GO2793@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 02/07/2019 15:02, Mark Brown wrote:
> On Tue, Jul 02, 2019 at 09:09:15AM +0100, Srinivas Kandagatla wrote:
> 
>> +- qcom,micbias1-lvl:
>> +	Usage: required
>> +	Value type: <u32>
>> +	Definition: Should be voltage in milli Volts for micbias1 output
> 
> milivolts
> 
>> +	Supported values are in inbetween 1800mV-2850mV
> 
> in between

yes, I agree and I will fix them in next version.

thanks,
srini
> 
