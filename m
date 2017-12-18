From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RESEND PATCH v2 13/15] dt-bindings: sound: qcom:
 Add devicetree bindings for apq8096
Date: Mon, 18 Dec 2017 09:49:30 +0000
Message-ID: <a5943204-74df-b79c-5151-208397351345@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
 <20171216174433.dzjftpz6zcyyq4ph@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
 [209.85.215.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AD0F266C72
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 10:49:34 +0100 (CET)
Received: by mail-lf0-f68.google.com with SMTP id x204so17004240lfa.11
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 01:49:33 -0800 (PST)
In-Reply-To: <20171216174433.dzjftpz6zcyyq4ph@rob-hp-laptop>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, sboyd@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for your review comments.

On 16/12/17 17:44, Rob Herring wrote:
> On Thu, Dec 14, 2017 at 05:34:00PM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Add devicetree bindings documentation file for Qualcomm apq8096 sound card.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,apq8096.txt     | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,apq8096.txt b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
>> new file mode 100644
>> index 000000000000..27b511dab533
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt
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
>> +		  Each entry is a pair of strings, the first being the
>> +		  connection's sink, the second being the connection's
>> +		  source. Valid names could be power supplies, MicBias
>> +		  of codec and the jacks on the board:
>> +Example:
>> +	sound {
>> +		compatible	= "qcom,snd-apq8096";
>> +		qcom,model = "DB820c";
> 
> Not documented, but just use "model".
Yep, I will use that in next version.
> 
> This doesn't look complete. No codec, etc.?
All the dai links are done in non-DT way directly in the sound card driver.

Thanks,
Srini

> 
> Rob
> 
