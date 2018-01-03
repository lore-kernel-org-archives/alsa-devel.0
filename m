From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RESEND PATCH v2 13/15] dt-bindings: sound: qcom: Add devicetree
 bindings for apq8096
Date: Wed, 3 Jan 2018 16:27:22 +0000
Message-ID: <787ecdc5-66d8-23ee-7136-2a8759c86536@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
 <20180103002835.GW478@tuxbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103002835.GW478@tuxbook>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sboyd@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 03/01/18 00:28, Bjorn Andersson wrote:
> On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla@linaro.org wrote:
> 
>> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
> 
> Wouldn't it be possible to describe all(?) qdsp based machines in this
> one document? I.e. should we name it a little bit more generic?

You mean like downstream ?

I see no harm in trying it out and see how it looks like.

> 
>> @@ -0,0 +1,22 @@
>> +* Qualcomm Technologies APQ8096 ASoC sound card driver
>> +
>> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,apq8096-sndcard"
>> +
>> +- qcom,audio-routing:
>> +	Usage: Optional
>> +	Value type: <stringlist>
>> +	Definition:  A list of the connections between audio components.
> 
> Double space before A
yep.

> 
>> +		  Each entry is a pair of strings, the first being the
>> +		  connection's sink, the second being the connection's
>> +		  source. Valid names could be power supplies, MicBias
>> +		  of codec and the jacks on the board:
>> +Example:
>> +	sound {
>> +		compatible	= "qcom,snd-apq8096";
> 
> Indentation
yep.

> 
>> +		qcom,model = "DB820c";
>> +	};
> 
> Regards,
> Bjorn
> 
