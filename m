From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2][RFC] ASoC: simple-card: add Device
 Tree support
Date: Thu, 12 Sep 2013 13:31:19 +0200
Message-ID: <5231A607.5080701@gmail.com>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87eh94xab2.wl%kuninori.morimoto.gx@renesas.com>
 <87d2ooxa9o.wl%kuninori.morimoto.gx@renesas.com>
 <87ob80i45a.wl%kuninori.morimoto.gx@renesas.com>
 <87li34i41w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0E62615AE
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:31:23 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id my10so4205400bkb.1
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 04:31:22 -0700 (PDT)
In-Reply-To: <87li34i41w.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/11/13 02:40, Kuninori Morimoto wrote:
> Support for loading the simple-card module via devicetree.
> It requests cpu/codec information,
> and .of_xlate_dai_name support on each component driver.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
[...]
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> new file mode 100644
> index 0000000..d1a0c89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -0,0 +1,73 @@
> +Simple-Card:
> +
> +Required properties:
> +
> +- compatible				: "simple-audio"
> +- simple-audio,card-name		: simple-audio card name
> +- simple-audio,format			: see below
> +- simple-audio,cpu			: CPU sub-node, see below
> +- simple-audio,codec			: CODEC sub-node, see below
> +
> +Optional properties:
> +
> +- simple-audio,system-clock-frequency	: system clock rate if it is connected to both CPU/CODEC
> +
> +Required cpu/codec subnode properties:
> +
> +- sound-dai				: phandle and port for CPU/CODEC
> +- #sound-dai-cells			: sound-dai phandle's node

IMHO, "sound-dai" is too ASoC specific for this property name.
To make it more generic, what about e.g. "sound-link" and
"#sound-link-cells" instead?

> +- frame-master				: frame master
> +- bitclock-master			: bitclock master
> +
> +Optional subnode properties:
> +
> +- bitclock-inversion			: if CPU/CODEC needs clock inversion
> +- frame-inversion			: if CPU/CODEC needs frame inversion
> +- system-clock-frequency		: system clock rate for each CPU/CODEC

Instead of "system-clock-frequency" use standard property name
"clock-frequency". In the driver, you can check for this property
and use it, if no common clocks are available on the arch running.

Sebastian
