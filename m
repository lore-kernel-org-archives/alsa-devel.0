From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/2] ASoC: pxa: add binding for pxa2xx-ac97 audio complex
Date: Wed, 13 Jun 2018 21:00:19 +0200
Message-ID: <87y3fiqzp8.fsf@belgarion.home>
References: <20180611202211.15501-1-robert.jarzmik@free.fr>
        <20180612221359.GA26741@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612221359.GA26741@rob-hp-laptop> (Rob Herring's message of
        "Tue, 12 Jun 2018 16:13:59 -0600")
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Rob Herring <robh@kernel.org> writes:

> On Mon, Jun 11, 2018 at 10:22:10PM +0200, Robert Jarzmik wrote:
>> This adds a binding for the Marvell PXA audio complex, available in
>> pxa2xx and pxa3xx variants.
>> +Required properties:
>> +  - compatible: "marvell,pxa2xx-ac97"
>
> Don't use wildcards in compatible strings. Though this is so old...
Yes, I could use pxa270-ac97.

>> +  - reset-gpio: gpio used for AC97 reset, refer to gpio.txt
> reset-gpios
Right, I'm on it.

>> +		status = "okay";
>
> Don't show status in examples.
Sure.

Cheers.

-- 
Robert
