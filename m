From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim
	ngd dt bindings
Date: Wed, 23 May 2018 21:01:43 +0100
Message-ID: <9bf83e8b-df06-ead9-1075-8b1a387d6052@linaro.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
 <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
 <20180523164023.GA24671@rob-hp-laptop>
 <4b83b699-59ad-b177-f360-3e76ba847892@linaro.org>
 <CAL_Jsq+YF+EFfqua_GTFU=cwf8oF3HCPCR09MWOoRCJf0-zVnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81BF7266C1C
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 22:01:46 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so28637493wrf.5
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 13:01:46 -0700 (PDT)
In-Reply-To: <CAL_Jsq+YF+EFfqua_GTFU=cwf8oF3HCPCR09MWOoRCJf0-zVnQ@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, girishm@quicinc.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org



On 23/05/18 20:28, Rob Herring wrote:
> On Wed, May 23, 2018 at 1:11 PM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>> On 23/05/18 17:40, Rob Herring wrote:
>>>>
>>>> +
>>>> +- qcom,ngd-id
>>>> +       Usage: required
>>>> +       Value type: <u32>
>>>> +       Definition: ngd instance id in the controller
>>>
>>> Why do you need this?
>>>
>> Please ignore my comment from previous reply.
>>
>> There are more than one instances of ngd in this slim controller.
>> We need this to make sure we are programming the correct one.
> 
> Doesn't the parent-child relationship of devices on the bus provide
> that? 
Thanks for the hint, that sounds like the actual problem here,
If I represent the node with proper parent-child relationship like this, 
it will remove the need of this property and would work perfectly in 
case we want to support multiple ngds in future!

slim@91c0000 {
	compatible = "qcom,msm8996-slim";
	reg = <0x91c0000 0x2C000>;
	interrupts = <0 163 0>;
	dmas = <&slimbam 3>, <&slimbam 4>;
	dma-names = "rx", "tx";
	#address-cells = <1>;
	#size-cells = <1>;
	ngd@1 {
		reg  = <1>;
		#address-cells = <1>;
		#size-cells = <1>;
		codec@1 {
			compatible = "slim217,1a0";
			reg  = <1 0>;
		};	
	};
};



If you mean to provide consistent numbering to userspace, then
> that's not a DT problem (nor one that Linux plans to solve).
> 
No, this is not problem am trying to solve.

>> We also need this instance ID during powering it up using QMI.
> 
> Wouldn't that be a QMI ID?

It is passed as parameter to SLIMBUS_QMI_SELECT_INSTANCE_REQ_V01 request.

thanks,
srini
> 
> Rob
> 
