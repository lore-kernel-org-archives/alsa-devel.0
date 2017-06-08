From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 13/17] ASoC: madera: Add DT bindings for Cirrus Logic
 Madera codecs
Date: Thu, 8 Jun 2017 14:17:53 -0500
Message-ID: <20170608191753.aq2hsgcf5fwnelnd@rob-hp-laptop>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-14-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496415790-19164-14-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 02, 2017 at 04:03:06PM +0100, Richard Fitzgerald wrote:
> The Cirrus Logic Madera codecs are a family of related codecs with
> extensive digital and analogue I/O, digital mixing and routing,
> signal processing and programmable DSPs.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
> Changes since V2:
> - Edits to take account of removing the child driver node and moving these
>   bindings to be part of the parent MFD node
> - Improve descriptions of dmic-ref and inmode
> - Changed example to use defined constants instead of magic numbers
> 
>  Documentation/devicetree/bindings/sound/madera.txt | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/madera.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/madera.txt b/Documentation/devicetree/bindings/sound/madera.txt
> new file mode 100644
> index 0000000..1114fcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/madera.txt
> @@ -0,0 +1,67 @@
> +Cirrus Logic Madera class audio codecs
> +
> +This describes audio configuration bindings for these codecs.
> +
> +See also the core bindings for the parent MFD driver:
> +See Documentation/devicetree/bindings/mfd/madera.txt
> +
> +and defines for values used in these bindings:
> +include/dt-bindings/sound/madera.h

This file should be part of this commit. With that,

Acked-by: Rob Herring <robh@kernel.org>
