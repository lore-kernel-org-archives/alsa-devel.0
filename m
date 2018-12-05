From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next v3 7/7] clk: renesas: Add binding document for
 ADG
Date: Wed, 5 Dec 2018 21:16:51 +0900
Message-ID: <3b2941db-4cd5-0975-c88d-4a23c1ff4907@mentor.com>
References: <20181205074947.28151-1-jiada_wang@mentor.com>
 <87tvjsbbgh.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87tvjsbbgh.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san

will rename dt bindings doc in next version

Thanks.
Jiada

On 2018/12/05 18:04, Kuninori Morimoto wrote:
> Hi Jiada
>
>> Add device tree bindings for Audio Clock Generator (ADG)
>> of R-Car Socs.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   .../clock/renesas,rcar-adg-clocks.txt         | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-adg-clocks.txt
> We want to have this document on rsnd.txt instead of
> not-exist-driver file
>
> 	/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
>
> Best regards
> ---
> Kuninori Morimoto
