From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 01/25] dt-bindings: soc: qcom: Add
	bindings for APR bus
Date: Thu, 22 Feb 2018 10:03:42 +0000
Message-ID: <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 509B826767F
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 11:03:44 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id t74so2766499wme.3
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 02:03:44 -0800 (PST)
In-Reply-To: <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, rohkumar@qti.qualcomm.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, spatakok@qti.qualcomm.com, Andy Gross <andy.gross@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 22/02/18 00:14, Rob Herring wrote:
> On Tue, Feb 20, 2018 at 3:33 AM, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>> Thanks for your review comments,
>>
>>
>> On 18/02/18 23:04, Rob Herring wrote:
>>>
>>> On Wed, Feb 14, 2018 at 09:13:23AM +0000, Srinivas Kandagatla wrote:
>>>>
>>>> Thanks for the review,
>>>>
>>>> On 13/02/18 23:12, Rob Herring wrote:
>>>>>
>>>>> On Tue, Feb 13, 2018 at 04:58:13PM +0000, srinivas.kandagatla@linaro.org
>>>>> wrote:
>>>>>>
>>>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>>>
>>>>>> This patch add dt bindings for Qualcomm APR (Asynchronous Packet
>>>>>> Router)
>>>>>> bus driver. This bus is used for communicating with DSP which provides
>>>>>> audio and various other services to cpu.
>>>>>>
>>>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>>> ---
>>>>>>     .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 83
>>>>>> ++++++++++++++++++++++
>>>>>>     1 file changed, 83 insertions(+)
>>>>>>     create mode 100644
>>>>>> Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>>>>>> b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..1b95fbfed348
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>>>>>> @@ -0,0 +1,83 @@
>>>>>> +Qualcomm APR (Asynchronous Packet Router) binding
>>>>>> +
>>>>>> +This binding describes the Qualcomm APR. APR is a IPC protocol for
>>>>>> +communication between Application processor and QDSP. APR is mainly
>>>>>> +used for audio/voice services on the QDSP.
>>>>>> +
...
>>>>>
>>>>>
>>>>> It's not a good design generally to mix different types of nodes at one
>>>>> level.
>>>>
>>>>
>>>> I agree, may be I can split the services and devices into different
>>>> subnodes
>>>> like below, which should avoid mixing different types of nodes.
>>>>
>>>> Does this sound good to you?
>>>
>>>
>>> Seems your original example wasn't so complete...
>>>
>> Yep, I will fix it in next version.
>>>
>>> I don't see why you need all these nodes in the first place. For a
>>> single SoC, how much does all this vary?
>>>
>> It might not vary for a given SoC, but It does vary across the SoCs.
>> Also the versions of each service are independent to each other.
> 
> Not sure I follow the last statement. Meaning firmware updates change
> the services?
Sorry for not being clear, so the services like AFE, ASM, ADM have 
different version numbers for a given SoC/firmware.

Not 100% sure if firmware updates would change the service version 
number, even if it does, it can be queried dynamically on new B family 
SoCs, and on older A Family SoCs I have not seen the firmware updates in 
last 4 years.

> I don't see any versioning of services here.

Yes, Plan is that it will be part of the compatible string in cases 
where version query is not supported on older QCOM A family SoCs.
On B Family SoCs we can query the version dynamically.

> 
>>
>>>>
>>>> apr {
>>>>           compatible = "qcom,apr-v2";
>>>>           qcom,smd-channels = "apr_audio_svc";
>>>>           qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
>>>>
>>>>           apr-services {
>>>>                   q6core {
>>>>                           qcom,apr-svc-name = "CORE";
>>>>                           qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
>>>>                           compatible = "qcom,q6core";
>>>>                   };
>>>>
>>>>                   q6afe: q6afe {
>>>>                           compatible = "qcom,q6afe";
>>>>                           qcom,apr-svc-name = "AFE";
>>>>                           qcom,apr-svc-id = <APR_SVC_AFE>;
>>>>                           #sound-dai-cells = <1>;
>>>>                   };
>>>>
>>>>                   q6asm: q6asm {
>>>>                           compatible = "qcom,q6asm";
>>>>                           qcom,apr-svc-name = "ASM";
>>>>                           qcom,apr-svc-id = <APR_SVC_ASM>;
>>>>                           #sound-dai-cells = <1>;
>>>>                   };
>>>>
>>>>                   q6adm: q6adm {
>>>>                           compatible = "qcom,q6adm";
>>>>                           qcom,apr-svc-name = "ADM";
>>>>                           qcom,apr-svc-id = <APR_SVC_ADM>;
>>>>                           #sound-dai-cells = <0>;
>>>>                   };
>>>
>>>
>>> All these DAI nodes could be a single node and the cell value be the
>>> svc-id?
>>
So we will have 2 cell values, one representing the apr service and 
other the dai.

>> No, DAI's here are both backends and frontends, and some of the services
>> like core, USM are not DAI's
>>
>> Are you also saying that we should have a single driver entity for all these
>> services?
> 
> DT nodes do not equate driver entities. A driver can instantiate other drivers.
> 
> Am I saying a single DT node for this? Yes, perhaps.
Yes, I will give that a go.

So we will endup having something like this in DT for one frontend and 
backend dailink:

apr {
	compatible = "qcom,apr-v2";
	qcom,smd-channels = "apr_audio_svc";
	qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>

	q6audio: audiosvc {
		compatible = "qcom,q6audio-svc";
		qcom,apr-svcs = <APR_SVC_CORE APR_SVC_AFE APR_SVC_ASM>;
		qcom,apr-svc-names = "CORE", "AFE", "ASM";
	};

	sndcard {
		compatible = "qcom,msm8996-snd-card"
		qcom,model = "DB820c";
		qcom,audio-routing =
                 	"RX_BIAS", "MCLK";
		fe@1 {
                 	is-fe;
                         link-name = "MultiMedia1";
                         cpu {
                         	sound-dai = <&q6audio  APR_SVC_ASM MM1>	
			};
                         platform {
                         	sound-dai = <&q6audio APR_SVC_ASM MM1>;
                         };
                  };

		be@1 {
                 	link-name = "HDMI Playback";
			cpu {
                         	sound-dai = <&q6audio APR_SVC_AFE HDMI>;
                         };

                         platform {
	                        sound-dai = <&q6audio ARP_SVC_ADM>;
                         };

                         codec {
                         	sound-dai = <&hdmi 0>;
			};
             	};
	};
};	

Thanks,
Srini
