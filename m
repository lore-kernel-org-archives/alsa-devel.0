From: Boris BREZILLON <b.brezillon.dev@gmail.com>
Subject: Re: [PATCH 0/8] ARM: at91: sama5d3: enable sound support
Date: Sat, 19 Apr 2014 00:06:22 +0200
Message-ID: <5351A1DE.9070801@gmail.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com> <53518C76.2020005@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53518C76.2020005@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Bo Shen <voice.shen@atmel.com>, Boris BREZILLON <b.brezillon@overkiz.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, devicetree@vger.kernel.org, Rob Landley <rob@landley.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: alsa-devel@alsa-project.org


On 18/04/2014 22:35, Nicolas Ferre wrote:
> On 17/03/2014 10:45, Bo Shen :
>> This patch add sound support on sama5d3xek board.
>>
>> This patch series based on the following patch set:
>>   clk: at91: better support for the PCKs
>>   http://comments.gmane.org/gmane.linux.kernel/1664477
>>
>>
>> Bo Shen (5):
>>   ARM: at91: sama5d3: add DMA property for SSC devices
>>   ARM: at91: sama5d3: disable sound by default
>>   ARM: at91: sama5d3: correct the sound compatible string
>>   ARM: at91: sama5d3: add the missing property
>>   ARM: at91: sama5d3: clock for ssc from rk pin
>>
>> Boris BREZILLON (3):
>>   ASoC: atmel: support CCF based clks
>>   ASoC: atmel: document clock properties of the wm8904 driver
>>   ARM: at91/dt: add clock properties to the wm8904 codec node
> Hi Voice and Boris,
>
> For this series I am a little bit puzzled: should I take the ASoC part
> of it? I see no acknowledgement from Mark and I also read some messages
> still discussing about CCF and wm8904 afterwards.
>
> So, I take the 5 patches by Voice Shen and tell me what is the proper
> sequence with this wm8904 work.

Bo was waiting for the "move sam9n12 SoC to the CCF" (which has been
submitted earlier this week) series before sending a new version of his
"wm8904: add CCF support" series.

Best Regards,

Boris

> I will be happy to stack more patches about this topic during the 3.16
> development phase.
>
>
> Otherwise, the 5 patches by Voice go into at91-3.16-dt branch.
>
> Thanks, bye.
>
>
>>  .../devicetree/bindings/sound/atmel-wm8904.txt     |  2 ++
>>  arch/arm/boot/dts/sama5d3.dtsi                     |  6 ++++++
>>  arch/arm/boot/dts/sama5d3xmb.dtsi                  | 11 +++++++++-
>>  sound/soc/atmel/atmel_wm8904.c                     | 25 +++++++++++-----------
>>  4 files changed, 31 insertions(+), 13 deletions(-)
>>
>
