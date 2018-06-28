From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sdm845
 machine bindings
Date: Thu, 28 Jun 2018 11:50:19 +0530
Message-ID: <5c976a29-b1ff-4fb5-9346-2288dfecd4c3@codeaurora.org>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org>
 <20180625191737.GA13246@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 715F126799F
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 08:20:30 +0200 (CEST)
In-Reply-To: <20180625191737.GA13246@rob-hp-laptop>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Thanks Rob for reviewing.


On 6/26/2018 12:47 AM, Rob Herring wrote:
> On Thu, Jun 21, 2018 at 04:23:18PM +0530, Rohit kumar wrote:
>> Add devicetree bindings documentation file for SDM845 sound card.
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,sdm845.txt      | 82 ++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>> new file mode 100644
>> index 0000000..68feb08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
>> @@ -0,0 +1,82 @@
>> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
>> +
>> +This binding describes the SDM845 sound card, which uses qdsp for audio.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,sdm845-sndcard"
>> +
>> +- qcom,audio-routing:
> Use just 'audio-routing'.

This is same which is being followed in apq8096 machine driver. As all 
qcom machine drivers will
mostly follow the same design, Vinod asked to pull out the APIs in 
common file - https://patchwork.kernel.org/patch/10479625/ .
Same is for qcom,model. I will add missing documentation for it in the 
next patchset.

>> +	Usage: Optional
>> +	Value type: <stringlist>
>> +	Definition:  A list of the connections between audio components.
>> +		  Each entry is a pair of strings, the first being the
>> +		  connection's sink, the second being the connection's
>> +		  source. Valid names could be power supplies, MicBias
>> +		  of codec and the jacks on the board.
>> +
>> +- cdc-vdd-supply:
>> +	Usage: Optional
>> +	Value type: <phandle>
>> +	Definition: phandle of regulator supply required for codec vdd.
> The codec supply should be in the codec node.

Sure. Will add this in codec driver.
>> +
>> += dailinks
>> +Each subnode of sndcard represents either a dailink, and subnodes of each
>> +dailinks would be cpu/codec/platform dais.
>> +
>> +- link-name:
>> +	Usage: required
>> +	Value type: <string>
>> +	Definition: User friendly name for dai link
>> +
>> += CPU, PLATFORM, CODEC dais subnodes
>> +- cpu:
>> +	Usage: required
>> +	Value type: <subnode>
>> +	Definition: cpu dai sub-node
>> +
>> +- codec:
>> +	Usage: required
>> +	Value type: <subnode>
>> +	Definition: codec dai sub-node
>> +
>> +- platform:
>> +	Usage: Optional
>> +	Value type: <subnode>
>> +	Definition: platform dai sub-node
>> +
>> +- sound-dai:
>> +	Usage: required
>> +	Value type: <phandle>
>> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
>> +
>> +Example:
>> +
>> +audio {
>> +	compatible = "qcom,sdm845-sndcard";
>> +	qcom,model = "sdm845-snd-card";
> Not documented. Just use 'model'.
>
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
>> +	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
>> +
>> +	cdc-vdd-supply = <&pm8998_l14>;
>> +
>> +	mm1-dai-link {
>> +		link-name = "MultiMedia1";
>> +		cpu {
>> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
>> +		};
>> +	};
>> +
>> +	pri-mi2s-dai-link {
>> +		link-name = "PRI MI2S Playback";
>> +		cpu {
>> +			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
>> +		};
>> +
>> +		platform {
>> +			sound-dai = <&q6routing>;
>> +		};
>> +	};
>> +};
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Regards,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
