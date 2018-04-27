From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v6 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
Date: Fri, 27 Apr 2018 20:16:57 +0100
Message-ID: <16204d76-c3f9-a185-6e1d-34d86dc40688@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-5-srinivas.kandagatla@linaro.org>
 <20180427141323.2ykh676xpdf7b6bl@rob-hp-laptop>
 <dd30b0ed-d958-9bf8-13cf-55d100b645ab@linaro.org>
 <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLLqr87F53rbR+DU9Qj9=9SWWrw45TWZaG6f_gnYfPNgw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org



On 27/04/18 19:32, Rob Herring wrote:
>>>> +
>>>> += AFE DAIs (Digial Audio Interface)
>>>> +"dais" subnode of the AFE node represents dai specific configuration
>>>> +
>>>> +- #sound-dai-cells
>>>> +       Usage: required
>>>> +       Value type: <u32>
>>>> +       Definition: Must be 1
>>>> +
>>>> +- reg
>>>
>>> It's not clear here these are in a grandchild node.
>>>
>> Every afe port/dai has some board specifics, to allow that we need dai
>> specific child nodes.
> Yes, but what I mean is #sound-dai-cells is a property of the dais
> node, but reg and qcom,sd-lines are properties of child nodes under
> the dais node. It is evident in the example, but not without the
> example. >
> Also, anywhere with reg needs #address-cells and #size-cells in the parent node.
>
Yep, #address-cells and #size-cells are missing, Will add them along 
with some notes.

thanks,
srini




> Rob
