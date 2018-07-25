From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 14/15] ASoC: meson: add axg sound card DT
 binding documentation
Date: Wed, 25 Jul 2018 13:06:19 -0600
Message-ID: <20180725190619.GA20234@rob-hp-laptop>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
 <20180717153643.8806-18-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 9539A26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:06:21 +0200 (CEST)
Received: by mail-it0-f68.google.com with SMTP id e14-v6so1966106itf.1
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 12:06:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180717153643.8806-18-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 17, 2018 at 05:36:41PM +0200, Jerome Brunet wrote:
> Add the DT binding documentation for axg sound card

I see Mark already applied, but...

> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-sound-card.txt      | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
> new file mode 100644
> index 000000000000..39e005da0407
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
> @@ -0,0 +1,124 @@
> +Amlogic AXG sound card:
> +
> +Required properties:
> +
> +- compatible: "amlogic,axg-sound-card"
> +- amlogic,name : User specified audio sound card name, one string

Just using "model" for new bindings.

> +
> +Optional properties:
> +
> +- amlogic,aux-devs : List of phandles pointing to auxiliary devices
> +- amlogic,widgets : Please refer to widgets.txt.
> +- amlogic,routing : A list of the connections between audio components.

audio-routing IIRC

> +
> +Subnodes:
> +
> +- amlogic,dai-link: Container for dai-link level properties and the
> +		    CODEC sub-nodes. There should be at least one (and
> +		    probably) subnode of this type.

Just 'dai-link'

> +
> +Required dai-link properties:
> +
> +- sound-dai: phandle and port of the CPU DAI.
> +
> +Required TDM Backend dai-link properties:
> +- dai-format : CPU/CODEC common audio format
> +
> +Optional TDM Backend dai-link properties:
> +- dai-tdm-slot-rx-mask-{0,1,2,3}: Receive direction slot masks
> +- dai-tdm-slot-tx-mask-{0,1,2,3}: Transmit direction slot masks
> +				  When omitted, mask is assumed to have to no
> +				  slots. A valid must have at one slot, so at
> +				  least one these mask should be provided with
> +				  an enabled slot.
> +- dai-tdm-slot-num : Please refer to tdm-slot.txt.
> +		     If omitted, slot number is set to accommodate the largest
> +		     mask provided.
> +- dai-tdm-slot-width : Please refer to tdm-slot.txt. default to 32 if omitted.
> +- mclk-fs : Multiplication factor between stream rate and mclk
> +
> +Backend dai-link subnodes:
> +
> +- codec: dai-link representing backend links should have at least one subnode.
> +	 One subnode for each codec of the dai-link.
> +	 dai-link representing frontend links have no codec, therefore have no
> +	 subnodes
> +
> +Required codec subnodes properties:
> +
> +- sound-dai: phandle and port of the CODEC DAI.
> +
> +Optional codec subnodes properties:
> +
> +- dai-tdm-slot-tx-mask : Please refer to tdm-slot.txt.
> +- dai-tdm-slot-rx-mask : Please refer to tdm-slot.txt.
> +
> +Example:
> +
> +sound {
> +	compatible = "amlogic,axg-sound-card";
> +	amlogic,name = "AXG-S420";
> +	amlogic,aux-devs = <&tdmin_a>, <&tdmout_c>;
> +	amlogic,widgets = "Line", "Lineout",
> +			  "Line", "Linein",
> +			  "Speaker", "Speaker1 Left",
> +			  "Speaker", "Speaker1 Right";
> +			  "Speaker", "Speaker2 Left",
> +			  "Speaker", "Speaker2 Right";
> +	amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
> +			  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
> +			  "TDM_C Playback", "TDMOUT_C OUT",
> +			  "TDMIN_A IN 2", "TDM_C Capture",
> +			  "TDMIN_A IN 5", "TDM_C Loopback",
> +			  "TODDR_A IN 0", "TDMIN_A OUT",
> +			  "Lineout", "Lineout AOUTL",
> +			  "Lineout", "Lineout AOUTR",
> +			  "Speaker1 Left", "SPK1 OUT_A",
> +			  "Speaker2 Left", "SPK2 OUT_A",
> +			  "Speaker1 Right", "SPK1 OUT_B",
> +			  "Speaker2 Right", "SPK2 OUT_B",
> +			  "Linein AINL", "Linein",
> +			  "Linein AINR", "Linein";
> +
> +	amlogic,dai-link@0 {
> +		sound-dai = <&frddr_a>;
> +	};
> +
> +	amlogic,dai-link@1 {
> +		sound-dai = <&toddr_a>;
> +	};
> +
> +	amlogic,dai-link@2 {
> +		sound-dai = <&tdmif_c>;
> +		dai-format = "i2s";
> +		dai-tdm-slot-tx-mask-2 = <1 1>;
> +		dai-tdm-slot-tx-mask-3 = <1 1>;
> +		dai-tdm-slot-rx-mask-1 = <1 1>;
> +		mclk-fs = <256>;
> +
> +		codec@0 {
> +			sound-dai = <&lineout>;
> +		};
> +
> +		codec@1 {
> +			sound-dai = <&speaker_amp1>;
> +		};
> +
> +		codec@2 {
> +			sound-dai = <&speaker_amp2>;
> +		};
> +
> +		codec@3 {
> +			sound-dai = <&linein>;
> +		};
> +
> +	};
> +
> +	amlogic,dai-link@4 {
> +		sound-dai = <&spdifout>;
> +
> +		codec {
> +			sound-dai = <&spdif_dit>;
> +		};
> +	};
> +};
> -- 
> 2.14.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
