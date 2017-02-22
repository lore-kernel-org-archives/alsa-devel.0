From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v2 2/7] IIO: Add bindings for simple sigma
	delta adc
Date: Wed, 22 Feb 2017 09:17:50 -0600
Message-ID: <20170222151750.h5d7gycltwnk7b4t@rob-hp-laptop>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-3-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADA1C266D63
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 16:17:52 +0100 (CET)
Received: by mail-ot0-f193.google.com with SMTP id w44so576200otw.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 07:17:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1487003909-11710-3-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, olivier moysan <olivier.moysan@st.com>, kernel@stlinux.com, Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 13, 2017 at 05:38:24PM +0100, Arnaud Pouliquen wrote:
> Add documentation of device tree bindings to support
> sigma delta modulator in IIO framework.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
> new file mode 100644
> index 0000000..2b3968a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
> @@ -0,0 +1,13 @@
> +Device-Tree bindings for simple sigma delta adc

What makes it "simple"?

> +
> +Required properties:
> +- compatible: should be "sd-modulator".
> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> +
> +Example node:
> +
> +	ads1202: simple_sd_adc@0 {

Is ads1202 the actual chip? Then it should be in the compatible list.

unit address without a reg prop is an error. The node name should be 
"adc".

> +		compatible = "sd-modulator";
> +		#io-channel-cells = <1>;
> +		status = "okay";

Drop status from examples.

> +	};
> -- 
> 1.9.1
> 
