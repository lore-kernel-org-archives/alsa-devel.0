From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 06/23] ASoC: qdsp6: dt-bindings: Add
	q6asm dt bindings
Date: Tue, 24 Apr 2018 17:20:07 +0100
Message-ID: <0cc7f804-4c3c-1955-3d61-0dcbb70ae017@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-7-srinivas.kandagatla@linaro.org>
 <20180424161730.4r3vixqa4sdjv7a2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0AA2675CD
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 18:20:08 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id a8so2171573wmg.5
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:20:08 -0700 (PDT)
In-Reply-To: <20180424161730.4r3vixqa4sdjv7a2@rob-hp-laptop>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review comments,

On 24/04/18 17:17, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:40PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch add DT bindings for ASM (Audio Stream Manager) DSP module.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   .../devicetree/bindings/sound/qcom,q6asm.txt       | 33 ++++++++++++++++++++++
>>   include/dt-bindings/sound/qcom,q6asm.h             | 22 +++++++++++++++
>>   2 files changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>>   create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>> new file mode 100644
>> index 000000000000..d034a50a202a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>> @@ -0,0 +1,33 @@
>> +Qualcomm Audio Stream Manager (Q6ASM) binding
>> +
>> +Q6ASM is one of the APR audio service on Q6DSP.
>> +Please refer to qcom,apr.txt for details of the coommon apr service bindings
>> +used by the apr service device.
> 
> Need to be clear this is a child of APR.
Yep, I will add a line to state this explicitly.

> 
>> +
>> +- but must contain the following property:
>> +
>> +- compatible:
>> +	Usage: required
>> +	Value type: <stringlist>
>> +	Definition: must be "qcom,asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
>> +		    Or "qcom,asm" where the version number can be queried
>> +		    from DSP.
>> +		    example "qcom,asm-v2.0"
>> +
>> += ASM DAIs (Digial Audio Interface)
>> +"dais" subnode of the ASM node represents dai specific configuration
>> +
>> +- #sound-dai-cells
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: Must be 1
>> +
>> += EXAMPLE
>> +
>> +q6asm {
> 
> Unit address needed.
Agree, Will fix all such instances.
> 
>> +	compatible = "qcom,q6asm";
> 
> Doesn't match the doc.
Opps!! will fix all such instances with afe and asm too.
> 
