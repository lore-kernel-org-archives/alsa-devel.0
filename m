From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: add imx-cs427x machine driver
Date: Tue, 26 Jan 2016 09:50:46 -0600
Message-ID: <CAL_JsqJxQjw5yWmnUAev4e+pa601stcH-W-srbDCeRYOabJrOg@mail.gmail.com>
References: <1453744403-12268-1-git-send-email-eu@felipetonello.com>
 <20160126022948.GA21187@rob-hp-laptop> <56A73FDE.2060607@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A73FDE.2060607@felipetonello.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 26, 2016 at 3:43 AM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Rob,
>
> On 26/01/16 02:29, Rob Herring wrote:
>> On Mon, Jan 25, 2016 at 05:53:23PM +0000, Felipe F. Tonello wrote:
>>> This is the initial imx-cs427x device-tree-only machine driver working with
>>> fsl_ssi driver. More features can be added on top of it later.
>>>
>>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>>> ---
>>>  .../devicetree/bindings/sound/imx-audio-cs427x.txt |  47 +++++
>>>  sound/soc/fsl/Kconfig                              |  12 ++
>>>  sound/soc/fsl/Makefile                             |   2 +
>>>  sound/soc/fsl/imx-cs427x.c                         | 218 +++++++++++++++++++++
>>>  4 files changed, 279 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
>>>  create mode 100644 sound/soc/fsl/imx-cs427x.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
>>> new file mode 100644
>>> index 000000000000..295f60b19418
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
>>> @@ -0,0 +1,47 @@
>>> +Freescale i.MX audio complex with CS4271 or CS4272 codec
>>
>> Do all the i.MX audio bindings really vary more that the codec? Seems
>> like a lot of duplication.
>
> I agree, but that how it is today. These platform drivers for imx are
> similar but not identical. Looking at them I would guess that they have
> 50 to 60% of duplicated code.
>
> I believe we can add this driver and work on re-using the code on a
> future series of patches.
>
>>
>>> +
>>> +Required properties:
>>> +
>>> +  - compatible              : "fsl,imx-audio-cs427x"
>>> +
>>> +  - model           : The user-visible name of this sound complex
>>> +
>>> +  - ssi-controller  : The phandle of the i.MX SSI controller
>>> +
>>> +  - audio-codec     : The phandle of the CS4271 audio codec
>>> +
>>> +  - audio-routing   : A list of the connections between audio components.
>>> +                      Each entry is a pair of strings, the first being the
>>> +                      connection's sink, the second being the connection's
>>> +                      source. Valid names could be power supplies, CS427x
>>> +                      pins, and the jacks on the board:
>>> +
>>> +                      Board connectors:
>>> +                       * Mic Jack
>>> +                       * Headphone Jack
>>
>> This should be an exact list of possible strings and valid combinations.
>
> This is the exact list for this version of this driver. At least that is
> what I can verify on my hardware (custom build).

What are AINA, AINB, etc. then?

Also, model should have its string documented. I should be able to
write the example from the documentation.

Rob
