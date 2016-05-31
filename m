From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC v2 1/3] ASoC: msm8916: Add codec Device Tree
	bindings.
Date: Tue, 31 May 2016 09:52:08 +0100
Message-ID: <574D50B8.5060009@linaro.org>
References: <1464356746-29610-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1464356746-29610-2-git-send-email-srinivas.kandagatla@linaro.org>
 <20160530230123.GA4004@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A5C2651AD
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 10:52:11 +0200 (CEST)
Received: by mail-wm0-f45.google.com with SMTP id a136so119598187wme.0
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 01:52:11 -0700 (PDT)
In-Reply-To: <20160530230123.GA4004@kwestfie-linux.qualcomm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 31/05/16 00:01, Kenneth Westfield wrote:
> On Fri, May 27, 2016 at 02:45:44PM +0100, Srinivas Kandagatla wrote:
>> This patch adds DT bindings required for msm8916 codec which is
>> integrated in msm8916 and apq8016 SOCs.
>>
>> Codec IP is divided into two parts, first analog which is integrated
>> in pmic pm8916 and secondly digital part which is integrated into
>> application processor. Codec register controls are also split across
>> pmic an lpass. Analog part is controlled via spmi bus to pmic, registers
>> on the Application processor are memory mapped.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,msm8916-wcd.txt | 101 +++++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
>> new file mode 100644
>> index 0000000..4e3826d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
>> @@ -0,0 +1,101 @@
>> +msm8916 audio CODEC aka Tombak audio CODEC
>
> Please remove all mentions of "Tombak" from the patch submissions.
Sure, Will fix that in next version.
>
>> +
>> +Codec IP is divided into two parts, first analog which is integrated in pmic pm8916
>> +and secondly digital part which is integrated into application processor. Codec register
>> +controls are also split across pmic an lpass. Analog part is controlled via spmi bus to pmic.
>> +
>> +## Bindings for codec core on pmic:
>> +
>> +Required properties
>
> Need to document the clocks and clock-names properties as well.
yep.

...
>> +
>> +Required properties
>> + - compatible: should be "qcom,msm8916-lpass-codec" followed by "syscon".
>
> IMO, the driver names are somewhat confusing.  Perhaps,
> qcom,msm8916-pmic-codec - for the codec blocks in the PMIC
Am Ok with this, naming.
> qcom,msm8916-soc-codec - for the codec blocks in the SoC

But I think we can just use "qcom,msm8916-lpass-codec" for the codec 
block in side the lpass, as SOC seems to be more generic term.

>
>> +		vdd-tx-rx-supply = <&pm8916_l5>;
>> +		vdd-micbias-supply = <&pm8916_l13>;
>> +		qcom,lpass-codec-core = <&lpass_codec_core>;
>
> Is there a reason the PMIC codec holds a phandle reference to the SoC
> codec node?  Rather than having the SoC codec hold a ref to the PMIC
> codec?

It depends, How you want to model the driver.
But in this case, most of the codec stuff like interrupts are handled in 
pmic, and the lpass side of it had just few mapped registers, so making 
a syscon for the lpass and accessing it in the pmic driver made more 
sense for me, if not we are going to complicate the driver design.


Thanks,
srini

>
>> +		#sound-dai-cells = <1>;
>> +	};
>> +};
>> +
>> +soc {
>> +	...
>> +	lpass_codec_core: lpass-codec{
>> +		compatible = "qcom,msm8916-lpass-codec", "syscon";
>> +		reg = <0x0771c000 0x400>;
>> +	};
>> +
>> +};
>> --
>> 2.8.2
>>
>
