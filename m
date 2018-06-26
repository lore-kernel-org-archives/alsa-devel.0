From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 03/11] ASoC: q6afe: dt-bindings: add
 compatible string to dais
Date: Tue, 26 Jun 2018 09:53:59 +0100
Message-ID: <70ad3f74-3fb3-af04-3515-5a593077b82a@linaro.org>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-4-srinivas.kandagatla@linaro.org>
 <20180625180130.GC10876@centauri.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E4632676B4
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 10:54:00 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so886478wmf.3
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 01:54:00 -0700 (PDT)
In-Reply-To: <20180625180130.GC10876@centauri.lan>
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
>> @ -103,6 +108,7 @@ q6afe@4 {
>>   		#sound-dai-cells = <1>;
>>   		#address-cells = <1>;
>>   		#size-cells = <0>;
>> +		compatible = "qcom,q6afe-dais";
> Perhaps have the compatible before #sound-dai-cells
> (and #size-cells, #address-cells) like in two previous
> patches.
> 
Sure, Will fix this in next version!
thanks,
srini
