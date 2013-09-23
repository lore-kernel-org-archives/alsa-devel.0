From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple
	codec
Date: Mon, 23 Sep 2013 15:19:56 -0600
Message-ID: <5240B07C.6080404@wwwdotorg.org>
References: <20130919105437.75e0f0a3@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 16F8F2610D3
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 23:20:01 +0200 (CEST)
In-Reply-To: <20130919105437.75e0f0a3@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:
> This patch adds a simple sound codec which is described by the DT.
> This codec may be used when no specific codec action is needed.

> diff --git a/Documentation/devicetree/bindings/sound/simple-codec.txt b/Documentation/devicetree/bindings/sound/simple-codec.txt

> +Device-Tree bindings for the simple codec
> +
> +Required properties:
> +- compatible: should be "linux,simple-codec".

We shouldn't have any Linux-specific bindings. It might be reasonable to
define a binding for a "simple CODEC", but there's no reason it should
be Linux-specific.

> +- dai-name: name of the codec

That should be internal to the driver; it's Linux-specific.

> +Optional properties:
> +- capture: information about capture
> +- playback: information about playback
> +At least one of the 'capture' or 'playback' nodes must be present.

Judging by the example, those are nodes not properties.

> +Child 'capture' and 'playback' required properties:
> +- stream-name: name of the stream

Stream name is also probably too Linux-specific.

> +- formats: list of the supported formats (see below)
> +- rates: list of the supported rates (see below)
> +- #channels: minimum and maximum numbers of channels
> +
> +Formats:
> +	"s8"
> +	"u8"

I think the binding should specify on-the-wire formats, not in-memory
formats. For example, if this binding is used to represent an I2S CODEC,
it's more important to know whether it supports left-justified,
right-justified, DSP mode, etc., and the max number of bits (or perhaps
a list of supported numbers of bits) per channel in each case.
