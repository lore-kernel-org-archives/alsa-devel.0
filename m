From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: Add support jack detection via
 codec
Date: Thu, 21 Apr 2016 09:19:21 -0500
Message-ID: <20160421141921.GA25900@rob-hp-laptop>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, Adam.Thomson@diasemi.com, sugar.zhang@rock-chips.com, jay.xu@rock-chips.com, broonie@kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, Mengdong Lin <mengdong.lin@linux.intel.com>, Jun Nie <jun.nie@linaro.org>, Jyri Sarha <jsarha@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 18, 2016 at 04:17:31PM +0800, Xing Zheng wrote:
> In most cases, many codecs already supports jack detection, previouslly,
> we need to create a customized machine driver every time.
> 
> Hence, the simple-card need to support use them dynamically via parse dts
> file for better flexibility.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/sound/simple-card.txt      |   17 +++
>  sound/soc/generic/simple-card.c                    |  126 +++++++++++++++++++-
>  2 files changed, 140 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> index cf3979e..d25c8eb 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -22,6 +22,23 @@ Optional properties:
>  					  headphones are attached.
>  - simple-audio-card,mic-det-gpio	: Reference to GPIO that signals when
>  					  a microphone is attached.
> +- simple-audio-card,codec-jack		: A list of the codec supports jack detection.
> +					  The jack types which are supported refer to include/sound/jack.h.
> +					  All of the jack types:
> +						"JACK_HEADPHONE",
> +						"JACK_MICROPHONE",
> +						"JACK_HEADSET",
> +						"JACK_LINEOUT",
> +						"JACK_MECHANICAL",
> +						"JACK_VIDEOOUT",
> +						"JACK_AVOUT",
> +						"JACK_LINEIN",
> +						"JACK_BTN_0",
> +						"JACK_BTN_1",
> +						"JACK_BTN_2",
> +						"JACK_BTN_3",
> +						"JACK_BTN_4",
> +						"JACK_BTN_5".

simple-card is not so simple...

I think this information be part of the codec node if the codec 
provides the functionality. The binding should not be different whether 
a codec is part of simple-card or not. Also, I would make all these just 
boolean props. 

Rob
