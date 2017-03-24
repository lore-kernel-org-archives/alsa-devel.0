From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 10/11] ASoC: add bindings for stm32
	DFSDM filter
Date: Fri, 24 Mar 2017 09:52:08 -0500
Message-ID: <20170324145208.6tj5swol5du5lkyc@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-11-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0662669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 15:52:10 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id n127so395735oih.2
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 07:52:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1489759704-30217-11-git-send-email-arnaud.pouliquen@st.com>
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

On Fri, Mar 17, 2017 at 03:08:23PM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes audio settings to support
> Digital Filter for pulse density modulation(PDM) microphone.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2->V3:
>    Fixes based on V2 comments
> 
>  .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> new file mode 100644
> index 0000000..ab610bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> @@ -0,0 +1,40 @@
> +STMicroelectronics audio DFSDM DT bindings
> +
> +This driver supports audio PDM microphone capture through Digital Filter format
> +Sigma Delta modulators (DFSDM).
> +
> +Required properties:
> +  - compatible: "st,stm32h7-adfsdm".
> +
> +  - #sound-dai-cells : Must be equal to 0
> +
> +  - io-channels : phandle to iio dfsdm instance node.
> +
> +
> +Example of a simple sound card using audio DFSDM node.
> +
> +	dmic0: dmic_@0 {

Drop the '_' and unit address.

> +		compatible = "dmic-codec";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	asoc-pdm@0 {

asoc is a Linux term. Drop the unit address.

> +		compatible = "st,stm32h7-adfsdm";

Is this a separate block from the ADC? A drawing of the h/w blocks and 
connections would help.

> +		#sound-dai-cells = <0>;
> +		io-channels = <&dfsdm_adc0 0>;
> +	};
> +
> +	sound_dfsdm_pdm {

sound-card {

> + 		compatible = "simple-audio-card";
> + 		simple-audio-card,name = "dfsdm_pdm";
> +
> + 		dfsdm0_mic0: simple-audio-card,dai-link@0 {

I'd suggest moving to the graph card.

> + 			format = "pdm";
> + 			cpu {
> + 				sound-dai = <&asoc_pdm1>;

This phandle doesn't point to anything.

> + 			};
> + 			dmic0_codec: codec {
> + 				sound-dai = <&dmic0>;
> + 			};
> + 		};
> +	};
> \ No newline at end of file

^^^

> -- 
> 1.9.1
> 
