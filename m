From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] ASoC: cs42888: Add codec driver support
Date: Tue, 11 Mar 2014 11:30:53 +0000
Message-ID: <20140311113053.GA1036@e106331-lin.cambridge.arm.com>
References: <1394536791-8381-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394536791-8381-1-git-send-email-Guangyu.Chen@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 11, 2014 at 11:19:51AM +0000, Nicolin Chen wrote:
> This patch adds support for the Cirrus Logic CS42888 Audio CODEC that
> has four 24-bit A/D and eight 24-bit D/A converters.
> 
> [ CS42888 supports both I2C and SPI control ports. As initial patch,
>   this patch only adds the support for I2C. ]
> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> ---
> 
> Changelog
> v2:
>  * Separated driver into I2C and main part drivers.
>  * Added error out if failed to get clock.
>  * Enabled Auto-mute function as default.
>  * Disabled runtime-pm in remove().
>  * Added return value checking for regcache_sync().
>  * Fixed some trival parts like 'const' as Lars mentioned.
> 
>  .../devicetree/bindings/sound/cs42888.txt          |  27 ++
>  sound/soc/codecs/Kconfig                           |  10 +
>  sound/soc/codecs/Makefile                          |   4 +
>  sound/soc/codecs/cs42888-i2c.c                     |  68 +++
>  sound/soc/codecs/cs42888.c                         | 536 +++++++++++++++++++++
>  sound/soc/codecs/cs42888.h                         | 213 ++++++++
>  6 files changed, 858 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cs42888.txt
>  create mode 100644 sound/soc/codecs/cs42888-i2c.c
>  create mode 100644 sound/soc/codecs/cs42888.c
>  create mode 100644 sound/soc/codecs/cs42888.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/cs42888.txt b/Documentation/devicetree/bindings/sound/cs42888.txt
> new file mode 100644
> index 0000000..7736527
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cs42888.txt
> @@ -0,0 +1,27 @@
> +CS42888 audio CODEC
> +
> +Required properties:
> +
> +  - compatible : "cirrus,cs42888"
> +
> +  - reg : the I2C address of the device for I2C
> +
> +  - clocks : phandle to the clock source for MCLK
> +
> +  - clock-names : must contain "mclk".

If you use clock-names, please define the clocks property in terms of
clock-names to avoid redundancy. e.g.

- clocks: a list of phandles + clock-specifiers, one for each entry in
  clock-names.

It makes the relationship between the two clearer, and makes it far
easier to alter the binding in future if required.

Cheers,
Mark.
