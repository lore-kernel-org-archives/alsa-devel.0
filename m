From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 01/25] dt-bindings: soc: qcom: Add
	bindings for APR bus
Date: Wed, 28 Feb 2018 18:55:15 +0000
Message-ID: <62ee863c-c3e8-ac81-0d83-8162da8d0458@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-2-srinivas.kandagatla@linaro.org>
 <20180213231244.ama4bwsehzuh5sr7@rob-hp-laptop>
 <ae65a9c8-85a3-5494-f4cc-1038fd8c9bd1@linaro.org>
 <20180218230414.dkd6kb6kd35arcyv@rob-hp-laptop>
 <636d4ac2-3bc2-7290-1645-0451c089cb8a@linaro.org>
 <CAL_JsqK3KFBGqpHRaURSrHew1HhObUvFYxuhND-FOQ4tCUaAHg@mail.gmail.com>
 <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D98A2677B5
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 19:55:17 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id a20so27568085wmd.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Feb 2018 10:55:17 -0800 (PST)
In-Reply-To: <465a2ca7-9f74-8977-37ea-29fe3944c27c@linaro.org>
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



On 22/02/18 10:03, Srinivas Kandagatla wrote:
>>> Also the versions of each service are independent to each other.
>>
>> Not sure I follow the last statement. Meaning firmware updates change
>> the services?
> Sorry for not being clear, so the services like AFE, ASM, ADM have 
> different version numbers for a given SoC/firmware.
> 
> Not 100% sure if firmware updates would change the service version 
> number, even if it does, it can be queried dynamically on new B family 
> SoCs, and on older A Family SoCs I have not seen the firmware updates in 
> last 4 years.
> 
>> I don't see any versioning of services here.
> 
> Yes, Plan is that it will be part of the compatible string in cases 
> where version query is not supported on older QCOM A family SoCs.
> On B Family SoCs we can query the version dynamically.
> 
>>
>>>
>>>>>
>>>>> apr {
>>>>>           compatible = "qcom,apr-v2";
>>>>>           qcom,smd-channels = "apr_audio_svc";
>>>>>           qcom,apr-dest-domain-id = <APR_DOMAIN_ADSP>;
>>>>>
>>>>>           apr-services {
>>>>>                   q6core {
>>>>>                           qcom,apr-svc-name = "CORE";
>>>>>                           qcom,apr-svc-id = <APR_SVC_ADSP_CORE>;
>>>>>                           compatible = "qcom,q6core";
>>>>>                   };
>>>>>
>>>>>                   q6afe: q6afe {
>>>>>                           compatible = "qcom,q6afe";
>>>>>                           qcom,apr-svc-name = "AFE";
>>>>>                           qcom,apr-svc-id = <APR_SVC_AFE>;
>>>>>                           #sound-dai-cells = <1>;
>>>>>                   };
>>>>>
>>>>>                   q6asm: q6asm {
>>>>>                           compatible = "qcom,q6asm";
>>>>>                           qcom,apr-svc-name = "ASM";
>>>>>                           qcom,apr-svc-id = <APR_SVC_ASM>;
>>>>>                           #sound-dai-cells = <1>;
>>>>>                   };
>>>>>
>>>>>                   q6adm: q6adm {, "external-sleep"
>>>>>                           compatible = "qcom,q6adm";
>>>>>                           qcom,apr-svc-name = "ADM";
>>>>>                           qcom,apr-svc-id = <APR_SVC_ADM>;
>>>>>                           #sound-dai-cells = <0>;
>>>>>                   };
>>>>
>>>>
>>>> All these DAI nodes could be a single node and the cell value be the
>>>> svc-id?
>>>
> So we will have 2 cell values, one representing the apr service and 
> other the dai.
> 
>>> No, DAI's here are both backends and frontends, and some of the services
>>> like core, USM are not DAI's
>>>
>>> Are you also saying that we should have a single driver entity for 
>>> all these
>>> services?
>>
>> DT nodes do not equate driver entities. A driver can instantiate other 
>> drivers.
>>
>> Am I saying a single DT node for this? Yes, perhaps.
> Yes, I will give that a go.

I did try your suggestion of making audio services into a single node 
and it ended up more messy and non scalable.

Mainly because q6afe node has more than one interface type of backend 
dais (child nodes).

Each of this backend dai may need board specific setting ex: MI2S case 
where board could wire up specific tx and rx lines from 4 possible lines 
for that board. Also other type of dais also have some interface 
specific properties.

MI2S example:
apr {
	...
	q6afe: q6afe {
		compatible = "qcom,q6afe";
		qcom,apr-svc-name = "AFE";
		qcom,apr-svc-id = <APR_SVC_AFE>;
		pinctrl-0 = <&ext_sec_tlmm_lines_act>;
		pinctrl-names = "default";
		#sound-dai-cells = <1>;

                 mi2s_prim_rx_dai@34{
			reg = <34>;
			rx-lines = <0>;
			...
		};

		mi2s_prim_tx_dai@35{
			reg = <35>;
			tx-lines = <1 2>
			...
		};
	     	...
	};
};

Here is block diagram to give a quick overview of the components


   +---------+          +---------+         +---------+
   |  q6asm  |          |q6routing|         | q6afe   |
   |  fedai  | <------> |  mixers | <-----> | bedai   |
   +---------+          +---------+         +---------+
       ^                     ^                   ^
       |                     |                   |
       |  +------------------+----------------+  |
       |  |                  |                |  |
       v  v                  v                v  v
   +---------+          +---------+         +---------+
   |   q6ASM |          |  q6ADM  |         |   q6AFE |
   +---------+          +---------+         +---------+
       ^                     ^                   ^          ^
       |                     |                   | CPU Side |
------+---------------------+-------------------+--------
       |                     |                   |
       |APR                  |APR                |APR
       |                     |                   |
       |  +------------------+----------------+  |
       |  |                  |                |  |
+-----+--+-----------------------------------+--+-------
       |  |                  |                |  | QDSP Side |
       v  v                  v                v  v           v
  +---------+          +---------+         +---------+
  |   ASM   | <------> |   ADM   | <-----> |   AFE   |
  +---------+          +---------+         +---------+
                                                ^
                                                |
                            +-------------------+
                            |
---------------------------+--------------------------
                            |            Audio I/O |
                            v                      v
     +--------------------------------------------------+
     |                Audio devices                     |
     | CODEC | HDMI-TX | PCM  | SLIMBUS | I2S |MI2S |...|
     |                                                  |
     +--------------------------------------------------+

thanks,
srini
