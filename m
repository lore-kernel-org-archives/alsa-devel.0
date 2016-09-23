From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] ASoC: simple-card: add support for aux devices
Date: Fri, 23 Sep 2016 17:25:41 -0500
Message-ID: <20160923222541.GA25693@rob-hp-laptop>
References: <1474614673-12350-1-git-send-email-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474614673-12350-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Otto =?iso-8859-1?Q?Kek=E4l=E4inen?= <otto@seravo.fi>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mengdong Lin <mengdong.lin@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 23, 2016 at 10:11:12AM +0300, Nikita Yushchenko wrote:
> This patch makes it possible to use simple-card in setups where separate
> amplifier chip is connected to codec's output.
> 
> Changes from v1:
> - moved example usage from commit message to Documentation/, as
>   suggested by Kuninori Morimoto,
> - fixed typo in example usage.

Ah, one more property to the "simple" card. At what point in adding 
properties is it not simple?

> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  .../devicetree/bindings/sound/simple-card.txt      | 37 ++++++++++++++++++++++
>  sound/soc/generic/simple-card.c                    | 34 ++++++++++++++++++++
>  2 files changed, 71 insertions(+)


> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> index 59d8628..c7a9393 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -22,6 +22,8 @@ Optional properties:
>  					  headphones are attached.
>  - simple-audio-card,mic-det-gpio	: Reference to GPIO that signals when
>  					  a microphone is attached.
> +- simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
> +					  as amplifiers, to be added to the sound card.

I think the property should be specific as to the type of device. What 
if you have 2 amps? Maybe simple-card can't have 2 outputs. What if you 
have a chain of devices and need to know the order of them?

Rob
