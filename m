From: "Fischer, Christian" <fischerc@swissphone.de>
Subject: Re: [PATCH] ASoC: sgtl5000: fix powerup/down of
 micbias-voltage
Date: Sat, 13 Jan 2018 09:50:58 +0000
Message-ID: <DD64F087E8F0B540A1C9216D6716FFBDF9949231@defrsexc01.swissphone.de>
References: <DD64F087E8F0B540A1C9216D6716FFBDF994813E@defrsexc01.swissphone.de>
 <CAOMZO5A9ypZOhA01hHwS3Eyig7t=3ivD2nnWh8NF7PB2P-w-Uw@mail.gmail.com>,
 <CAOMZO5D8hpwg+mfZ0LFhuvQU8EX0n+qkfc8PR=BF7ar2Fp=hJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.avectris.ch (mail2.avectris.ch [185.94.144.40])
 by alsa0.perex.cz (Postfix) with ESMTP id CAE05266CFE
 for <alsa-devel@alsa-project.org>; Sat, 13 Jan 2018 10:51:01 +0100 (CET)
In-Reply-To: <CAOMZO5D8hpwg+mfZ0LFhuvQU8EX0n+qkfc8PR=BF7ar2Fp=hJw@mail.gmail.com>
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "bhumirks@gmail.com" <bhumirks@gmail.com>, "richard.leitner@skidata.com" <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

>> What about using simple audio card binding in your device tree instead?
>>
>> You could pass the simple-audio-card,routing property as described in
>> Documentation/devicetree/bindings/sound/simple-card.txt
>>
>> A dts where sgtl5000 is used with simple audio card is
>> arch/arm/boot/dts/imx7s-warp.dts.
>>
>> This one does not use simple-audio-card,routing, but at least it gives
>> you a reference.
>
> This one uses sgtl5000 with simple-audio-card,routing:
> arch/arm/boot/dts/imx6ul-tx6ul.dtsi
> 
> Hope it helps.

Hello Fabio,

you are right, a simple-audio-card would work too! Thanks!
I also applied a patch for mxs-sgtl5000 machine-driver that adds audio-routing support:
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/130666.html
